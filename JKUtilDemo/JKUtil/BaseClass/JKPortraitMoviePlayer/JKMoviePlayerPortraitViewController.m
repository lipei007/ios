//
//  JKMoviePlayerPortraitViewController.m
//  moviePlayer
//
//  Created by emerys on 15/12/6.
//  Copyright © 2015年 Emerys. All rights reserved.
//

#import "JKMoviePlayerPortraitViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MediaToolbox/MediaToolbox.h>
#import "JKBackButton.h"
#import "JKCacheSlider.h"


#define PLAY_URL @"http://baobab.cdn.wandoujia.com/1449121380062b.mp4"
#define w [UIScreen mainScreen].bounds.size.width
#define h [UIScreen mainScreen].bounds.size.height
#define TIME_OFFSET 5

// 消除弃用警告
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

typedef NS_ENUM(NSInteger,JKMovieProgressControlState) {
    JKMovieProgressControlStateForward,
    JKMovieProgressControlStateBack
};

@interface JKMoviePlayerPortraitViewController ()
{
    MPMoviePlayerController *player;
    UIView *controlView;
    UIView *tapView;
    
    JKBackButton *backButton;
    UILabel *nameLabel;
    UIProgressView *volume;
    UILabel *durationLabel;
    UILabel *currentTimeLabel;
    JKCacheSlider *playSlider;
    UIButton *playButton;
    NSTimer *timer;
    NSTimeInterval duration;
}

@end

@implementation JKMoviePlayerPortraitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.URLString = PLAY_URL;
    if (self.navigationController) {
        self.navigationController.navigationBar.hidden = YES;
        if (self.navigationController.tabBarController) {
            self.navigationController.tabBarController.tabBar.hidden = YES;
        }
    }
    
    [self createPlayer];
    [self createControlView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * @brief 旋转视图 M_PI / 2角度
 */
-(void)rotateView:(UIView *)view{
    [self rotateView:view withAngle:M_PI / 2];
}

/**
 * @brief 旋转视图
 */
-(void)rotateView:(UIView *)view withAngle:(CGFloat)angle{
    CGAffineTransform transform = view.transform;
    transform = CGAffineTransformMakeRotation(angle);
    view.transform = transform;
}
/**
 * @brief 返回时间的字符串
 */
-(NSString *)timeStringOfTimeInterval:(NSTimeInterval)timeInterval{
    NSInteger minute = timeInterval / 60;
    NSInteger second = (int)timeInterval % 60;
    
    NSString *minuteStr;
    if (minute < 10) {
        minuteStr = [NSString stringWithFormat:@"0%li",minute];
    }else{
        minuteStr = [NSString stringWithFormat:@"%li",minute];
    }
    
    NSString *secondStr;
    if (second < 10) {
        secondStr = [NSString stringWithFormat:@"0%li",second];
    }else{
        secondStr = [NSString stringWithFormat:@"%li",second];
    }
    return [NSString stringWithFormat:@"%@:%@",minuteStr,secondStr];
}


/**
 * @brief 创建播放器
 */
-(void)createPlayer{
    NSURL *url = [NSURL URLWithString:self.URLString];
    player = [[MPMoviePlayerController alloc] initWithContentURL:url];
    [player prepareToPlay];
    player.shouldAutoplay = YES;
    player.repeatMode = MPMovieRepeatModeNone;
    /**
     *      typedef NS_ENUM(NSInteger, MPMovieControlStyle) {
     *          MPMovieControlStyleNone,       // No controls
     *          MPMovieControlStyleEmbedded,   // Controls for an embedded view
     *          MPMovieControlStyleFullscreen, // Controls for fullscreen playback
     *
     *          MPMovieControlStyleDefault = MPMovieControlStyleEmbedded
     *      } NS_DEPRECATED_IOS(3_2, 9_0);
     *
     */
    player.controlStyle = MPMovieControlStyleDefault;
    /**
     *  typedef NS_ENUM(NSInteger, MPMovieScalingMode) {
     *      MPMovieScalingModeNone,       // No scaling
     *      MPMovieScalingModeAspectFit,  // Uniform scale until one dimension fits
     *      MPMovieScalingModeAspectFill, // Uniform scale until the movie fills the visible bounds. One dimension may have clipped contents
     *      MPMovieScalingModeFill        // Non-uniform scale. Both render dimensions will exactly match the visible bounds
     *   } NS_DEPRECATED_IOS(2_0, 9_0);
     */
    player.scalingMode = MPMovieScalingModeAspectFit;
    
    player.view.frame = CGRectMake(0, 0, h, w);
    player.view.center = CGPointMake(w * 0.5, h * 0.5);
    [self rotateView:player.view];
    
    [self.view addSubview:player.view];
    
    // 播放状态改变,在dealloc中销毁
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playBackStateChangeNotification:)
                                                 name:MPMoviePlayerPlaybackStateDidChangeNotification
                                               object:nil];
    // 播放结束，在dealloc中销毁
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didFinishPlayCallBack:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:nil];
    // 准备开始播放
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(readyToPlay:)
                                                 name:MPMoviePlayerReadyForDisplayDidChangeNotification
                                               object:nil];
    
    [player play];
    
}

/**
 * @brief 从视图当中获取一个image
 */
-(UIImage *)getImageInView:(UIView *)view{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, view.layer.contentsScale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    return img;
}

/**
 * @brief 获取一个圆形白色小图，让滑条的滑块变小
 */
-(UIImage *)getImageOfSize:(CGSize)size withColor:(UIColor *)color{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    view.backgroundColor = [UIColor clearColor];
    
    CAShapeLayer *circle = [CAShapeLayer layer];
    circle.fillColor = color.CGColor;
    circle.strokeColor = [UIColor clearColor].CGColor;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:view.bounds];
    circle.path = path.CGPath;
    [view.layer addSublayer:circle];
    [view setNeedsDisplay];
    return [self getImageInView:view];
}
/**
 * @brief 添加控制响应
 */
-(void)addHandlerToDealWithControl{
    
    [backButton addTarget:self action:@selector(goBackButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [playButton addTarget:self action:@selector(playButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(controlSwipe:)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [controlView addGestureRecognizer:leftSwipe];
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(controlSwipe:)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [controlView addGestureRecognizer:rightSwipe];
    
    UISwipeGestureRecognizer *upSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(controlSwipe:)];
    upSwipe.direction = UISwipeGestureRecognizerDirectionUp;
    [controlView addGestureRecognizer:upSwipe];
    
    UISwipeGestureRecognizer *downSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(controlSwipe:)];
    downSwipe.direction = UISwipeGestureRecognizerDirectionDown;
    [controlView addGestureRecognizer:downSwipe];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showOrHideControlView:)];
    tap.numberOfTapsRequired = 1;
    [tapView addGestureRecognizer:tap];
    
    [playSlider addTarget:self action:@selector(changeCurrentPlaybackTime:) forControlEvents:UIControlEventValueChanged];
    [playSlider addTarget:self action:@selector(playForWard:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)goBackButtonClick:(UIButton *)sender{
    [player stop];
    player = nil;
    if (self.navigationController){
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
-(void)playButtonClick:(UIButton *)sender{
    playButton.selected = !playButton.selected;
    if (playButton.selected) {
        [player pause];
        return;
    }
    [player play];
}

-(void)changeProgressControlState:(JKMovieProgressControlState)state{
//    NSTimeInterval currentTime = player.currentPlaybackTime;
    
    switch (state) {
        case JKMovieProgressControlStateForward:{
//            [player setCurrentPlaybackTime:currentTime + TIME_OFFSET];
            [player beginSeekingForward];
            dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 1);
            dispatch_after(time, dispatch_get_main_queue(), ^{
                [player endSeeking];
            });
        }
            break;
        case JKMovieProgressControlStateBack:{
//            [player setCurrentPlaybackTime:currentTime - TIME_OFFSET];
            [player beginSeekingBackward];
            dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 1);
            dispatch_after(time, dispatch_get_main_queue(), ^{
                [player endSeeking];
            });
        }
            break;
            
        default:
            break;
    }
    
}

-(void)controlSwipe:(UISwipeGestureRecognizer *)swipe{
    switch (swipe.direction) {
        case UISwipeGestureRecognizerDirectionUp:{
            // + volume
//            NSLog(@"up");
        }
            break;
        case UISwipeGestureRecognizerDirectionLeft:{
            // back
            [self changeProgressControlState:JKMovieProgressControlStateBack];
        }
            break;
        case UISwipeGestureRecognizerDirectionDown:{
            // - volume
//            NSLog(@"down");
        }
            break;
        case UISwipeGestureRecognizerDirectionRight:{
            // forward
            [self changeProgressControlState:JKMovieProgressControlStateForward];
        }
            break;
            
        default:
            break;
    }
}

-(void)showOrHideControlView:(UITapGestureRecognizer *)tap{
    CGFloat alpha;
    if (!controlView.alpha) {
        alpha = 1.0f;
    }else{
        alpha = 0;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        controlView.alpha = alpha;
    }];
}

-(void)changeCurrentPlaybackTime:(JKCacheSlider *)slider{
    timer.fireDate = [NSDate distantFuture];
    currentTimeLabel.text = [self timeStringOfTimeInterval:player.duration * slider.value];
}

-(void)playForWard:(JKCacheSlider *)slider{
    [player pause];
    player.currentPlaybackTime = player.duration * slider.value;
    [player play];
    timer.fireDate = [NSDate distantPast];
}

/**
 * @brief 创建控制视图
 */
-(void)createControlView{
    
    tapView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, h, w)];
    tapView.center = CGPointMake(w * 0.5, h * 0.5);
    tapView.backgroundColor = [UIColor clearColor];
    
    controlView = [[UIView alloc] initWithFrame:tapView.bounds];
    controlView.backgroundColor = [UIColor clearColor];
    
    // 返回键
    backButton = [[JKBackButton alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
    backButton.backgroundColor = [UIColor clearColor];
    [controlView addSubview:backButton];
    
    // 名称
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake((h - 0.5 * h) / 2, 10, 0.5 * h, 20)];
    nameLabel.font = [UIFont systemFontOfSize:15.0f];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.text = self.movieName;
    [controlView addSubview:nameLabel];
    
    // 音量
    volume = [[UIProgressView alloc]
              initWithFrame:CGRectMake(backButton.center.x, w - (w - 0.4 * w) / 2, 0.4 * w, 4)];
    volume.trackTintColor = [UIColor grayColor];
    volume.progressTintColor = [UIColor whiteColor];
    [self rotateView:volume withAngle:(-M_PI / 2)];
//    [controlView addSubview:volume];
    volume.progress = 0.7;
    
    CGFloat timeW = 50;
    CGFloat timeH = 20;
    // 当前播放时间
    currentTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(backButton.frame), w - 30, timeW, timeH)];
    currentTimeLabel.font = [UIFont systemFontOfSize:12.0f];
    currentTimeLabel.textAlignment = NSTextAlignmentCenter;
    currentTimeLabel.textColor = [UIColor whiteColor];
    currentTimeLabel.text = @"00:00";
    [controlView addSubview:currentTimeLabel];
    // 播放进度条
    CGFloat sliderLen = h - 2 * (CGRectGetMaxX(currentTimeLabel.frame) + 5);
    playSlider = [[JKCacheSlider alloc] initWithFrame:CGRectMake(0, 0, sliderLen, 10)];
    playSlider.center = CGPointMake(h * 0.5, currentTimeLabel.center.y);
    [playSlider setMinimumTrackTintColor:[UIColor whiteColor] middleTrackTintColor:[UIColor lightGrayColor] maximumTrackTintColor:[UIColor darkGrayColor]];
    playSlider.minimumValue = 0;
    playSlider.maximumValue = 1;
    playSlider.cacheValue = 0;
//    [playSlider setThumbImage:[self getImageOfSize:CGSizeMake(10, 10) withColor:[UIColor whiteColor]] forState:UIControlStateNormal];
//    [playSlider setThumbImage:[UIImage imageNamed:@"thum"] forState:UIControlStateNormal];
    playSlider.slipCube = [UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(10, 10)];
    [controlView addSubview:playSlider];
    
    // 总时间
    durationLabel = [[UILabel alloc] initWithFrame:CGRectMake(h - CGRectGetMaxX(currentTimeLabel.frame), w - 30, timeW, timeH)];
    durationLabel.font = [UIFont systemFontOfSize:12.0f];
    durationLabel.textAlignment = NSTextAlignmentCenter;
    durationLabel.textColor = [UIColor whiteColor];
    durationLabel.text = @"192:12";
    [controlView addSubview:durationLabel];
    
    // 播放按钮
    playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    playButton.backgroundColor = [UIColor clearColor];
    playButton.frame = CGRectMake(0, 0, 50, 50);
    playButton.center = CGPointMake(h * 0.5, w * 0.5);
    [playButton setBackgroundImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    [playButton setBackgroundImage:[UIImage imageNamed:@"play"] forState:UIControlStateSelected];
    [controlView addSubview:playButton];
    
    [tapView addSubview:controlView];
    [self rotateView:tapView];
    [self.view addSubview:tapView];
    volume.center = CGPointMake(backButton.center.x, w / 2);
    
    [self addHandlerToDealWithControl];
    controlView.alpha = 0;
}

/**
 * @brief 播放状态改变回调
 */
-(void)playBackStateChangeNotification:(NSNotification *)notification{
    switch (player.playbackState) {
        case MPMoviePlaybackStateStopped:{
            timer.fireDate = [NSDate distantFuture];
            currentTimeLabel.text = [self timeStringOfTimeInterval:duration];
            playButton.selected = YES;
        }
            break;
        case MPMoviePlaybackStatePlaying:{
            playButton.selected = NO;
            if (timer) {
                timer.fireDate = [NSDate distantPast];
            }
        }
            break;
        case MPMoviePlaybackStateInterrupted:{
            playSlider.cacheValue = 1;
            timer.fireDate = [NSDate distantFuture];
            currentTimeLabel.text = [self timeStringOfTimeInterval:duration];
            playButton.selected = YES;
        }
            break;
        case MPMoviePlaybackStatePaused:{
            playButton.selected = YES;
            timer.fireDate = [NSDate distantFuture];
        }
            break;
        case MPMoviePlaybackStateSeekingBackward:{
            
        }
            break;
        case MPMoviePlaybackStateSeekingForward:{
            
        }
            break;
            
        default:
            break;
    }
}
/**
 * @brief 播放完成回调
 */
-(void)didFinishPlayCallBack:(NSNotification *)notification{
    timer.fireDate = [NSDate distantFuture];
    currentTimeLabel.text = [self timeStringOfTimeInterval:duration];
    playButton.selected = YES;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 * @brief 准备开始播放回调
 */
-(void)readyToPlay:(NSNotification *)notification{
    durationLabel.text = [self timeStringOfTimeInterval:player.duration];
    duration = player.duration;
    timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(playerCache) userInfo:nil repeats:YES];
}

/**
 * @brief 隐藏状态栏
 */
-(BOOL)prefersStatusBarHidden{
    return YES;
}

/**
 * @brief 设置缓冲数据
 */
-(void)playerCache{
    playSlider.cacheValue = player.playableDuration / player.duration;
    playSlider.value = player.currentPlaybackTime / player.duration;
    currentTimeLabel.text = [self timeStringOfTimeInterval:player.currentPlaybackTime];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    if (self.navigationController) {
//        self.navigationController.navigationBar.hidden = NO;
//        if (self.navigationController.tabBarController) {
//            self.navigationController.tabBarController.tabBar.hidden = NO;
//        }
//    }
}

- (BOOL)shouldAutorotate{
    return NO;
}

#pragma clang diagnostic pop

@end

