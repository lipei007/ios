//
//  ViewController.m
//  音乐播放器
//
//  Created by emerys on 15/9/11.
//  Copyright (c) 2015年 Emerys. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "MusicListViewController.h"
#import "MusicModel.h"

#define PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"000"]
//#define PATH [[[NSBundle mainBundle] resourcePath]
//stringByAppendingPathComponent:@"000"]

#define preference [PATH stringByAppendingPathComponent:@"caonima.txt"]

@interface ViewController () <AVAudioPlayerDelegate> {

  NSArray *musicList;     // 音乐列表,存放文件中所有歌曲的名字
  AVAudioPlayer *player;  // 播放器对象
  NSInteger currentIndex; // 当前所播放的歌曲在歌曲列表的位置
  NSTimer *timer;         // 用于进度更新

  MusicListViewController *listController;

  NSKeyedArchiver *archiver;
}
@property(strong, nonatomic) IBOutlet UIView *topCoverView;
@property(strong, nonatomic) IBOutlet UIView *bottomCoverView;

@property(strong, nonatomic) IBOutlet UILabel *songName;
@property(strong, nonatomic) IBOutlet UIImageView *artWork;
@property(strong, nonatomic) IBOutlet UILabel *artist;
@property(strong, nonatomic) IBOutlet UILabel *time;
@property(strong, nonatomic) IBOutlet UIProgressView *progress;
@property(strong, nonatomic) IBOutlet UIButton *loved;
@property(strong, nonatomic) IBOutlet UIButton *isDownload;
@property(strong, nonatomic) IBOutlet UIButton *isPlay;
@property(strong, nonatomic) IBOutlet UIButton *list;

- (IBAction)srcList:(UIButton *)sender;
- (IBAction)download:(UIButton *)sender;
- (IBAction)love:(UIButton *)sender;
- (IBAction)play:(UIButton *)sender;
- (IBAction)next:(UIButton *)sender;
- (IBAction)previous:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  NSData *data = [NSData dataWithContentsOfFile:preference];
  if (!data) {
    NSKeyedUnarchiver *unarchiver =
        [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    musicList = [unarchiver decodeObjectForKey:@"music"];
  }
  if (!musicList) {
    printf("没有从保存的数据中加载\n");
    //        [@"yeah" writeToFile:preference atomically:NO
    //        encoding:NSUTF8StringEncoding error:nil];
    NSFileManager *manager = [NSFileManager defaultManager];
    NSError *error;
    musicList = [manager contentsOfDirectoryAtPath:PATH error:&error];
    if (error) {
      UIAlertController *alert = [UIAlertController
          alertControllerWithTitle:@"警告"
                           message:@"获取播放列表失败"
                    preferredStyle:UIAlertControllerStyleAlert];

      UIAlertAction *action = [UIAlertAction
          actionWithTitle:@"确定"
                    style:UIAlertActionStyleDefault
                  handler:^(UIAlertAction *action) {
                    [alert dismissViewControllerAnimated:YES completion:nil];
                  }];

      [alert addAction:action];

      [self presentViewController:alert animated:YES completion:nil];
    }
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *str in musicList) {
      if ([[str pathExtension] isEqualToString:@"mp3"]) {
        MusicModel *model = [[MusicModel alloc] init];
        model.musicName = str;
        model.isLoved = NO;
        model.isDownload = NO;
        [array addObject:model];
      }
    }
    musicList = array;
    [self saveData];
  }
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(saveData)
                                               name:@"savedata"
                                             object:nil];

  [self createPlayerWithSong:((MusicModel *)[musicList firstObject]).musicName];
    
//    UISlider
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

/**程序退出时保存数据(musiclist)*/
- (void)saveData {
  NSMutableData *data = [NSMutableData data];
  archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
  [archiver encodeObject:musicList forKey:@"music"];
  [data writeToFile:preference atomically:NO];
  printf("写入成功\n");
}
/**根据音乐名创建一个player*/
- (void)createPlayerWithSong:(NSString *)songName {
  [self clearAllState];
  if (songName) {
    currentIndex = [musicList indexOfObject:[self modelWithName:songName]];
    NSString *currentMusicPath = [PATH stringByAppendingPathComponent:songName];
    NSURL *url = [NSURL fileURLWithPath:currentMusicPath];
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    player.delegate = self;
    AVAudioSession *session = [AVAudioSession sharedInstance];
    // 设置后台播放
    [session setActive:YES error:nil];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    // 设置支持线控
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];

    [self showInfoOfSong:songName];
    [self playSong];
  }
}
/**根据音乐名返回一个模型对象*/
- (MusicModel *)modelWithName:(NSString *)songName {
  MusicModel *model;
  for (MusicModel *tmpModel in musicList) {
    if ([tmpModel.musicName isEqualToString:songName]) {
      model = tmpModel;
      break;
    }
  }
  return model;
}

/**在视图上展示音乐文件的信息*/
- (void)showInfoOfSong:(NSString *)songName {
  if (songName) {
    NSString *currentMusicPath = [PATH stringByAppendingPathComponent:songName];
    NSURL *url = [NSURL fileURLWithPath:currentMusicPath];
    // 获取音乐文件的信息
    AVAsset *asset = [AVAsset assetWithURL:url];
    NSArray *metaDataFormts =
        [asset availableMetadataFormats]; // 获取文件元数据格式
    NSArray *metaData = [asset
        metadataForFormat:
            [metaDataFormts firstObject]]; // 根据获取到的元数据格式获取元数据
    BOOL hasArtWork = NO;                  // 标记有无歌曲封面
    for (AVMetadataItem *item in metaData) { // 遍历元数据的各项
      if ([item.commonKey isEqualToString:@"artist"]) { // 艺术家
        self.artist.text = (NSString *)item.value;

      } else if ([item.commonKey isEqualToString:@"artwork"]) { // 封面
        NSData *data = (NSData *)item.value;
        UIImage *image = [UIImage imageWithData:data];
        self.artWork.image = image;
        hasArtWork = YES;
      }
    }
    // 如果文件头信息不包含封面那么就用占位符
    if (!hasArtWork) {
      UIImage *image = [UIImage imageNamed:@"placeHolder.png"];
      self.artWork.image = image;
    }

    // 音乐名从头文件读取的title有时候不正确,所以在此用文件名
    NSString *name = [songName stringByDeletingPathExtension];
    NSRange range = [name rangeOfString:@"- "];
    name = [name substringFromIndex:range.location + 1];
    self.songName.text = name;
    // 根据模型对象,展示下载,喜欢按钮的状态
    MusicModel *model = [self modelWithName:songName];
    self.isDownload.selected = model.isDownload;
    self.loved.selected = model.isLoved;
  }
}

/**播放*/
- (void)playSong {
  [player prepareToPlay];
  [player play];
  timer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                           target:self
                                         selector:@selector(updatePlayProgress)
                                         userInfo:nil
                                          repeats:YES];
  self.isPlay.selected = YES;
}
/**清除所有标签文字,按钮设置为默认状态*/
- (void)clearAllState {
  player = nil;
  self.songName.text = nil;
  self.artist.text = nil;
  self.artWork.image = nil;
  self.progress.progress = 0;
  self.isDownload.selected = NO;
  self.loved.selected = NO;
  self.isPlay.selected = NO;
  self.time.text = nil;
}
/**更新播放进度*/
- (void)updatePlayProgress {
  NSTimeInterval interval = player.currentTime;
  NSInteger playMunite = interval / 60;
  NSInteger playSecond = (int)interval % 60;
  NSString *playTime =
      [NSString stringWithFormat:@"%li:%li", playMunite, playSecond];
  NSInteger totalMunite = player.duration / 60;
  NSInteger totalSecond = (int)player.duration % 60;
  NSString *totalTime =
      [NSString stringWithFormat:@"%li:%li", totalMunite, totalSecond];
  NSString *time = [NSString stringWithFormat:@"%@/%@", playTime, totalTime];
  self.time.text = time;
  self.progress.progress = interval / player.duration;
}
/**下一曲*/
- (void)nextSong {
  if (currentIndex < musicList.count - 1) {
    currentIndex++;
  } else {
    currentIndex = 0;
  }
  [self clearAllState];
  [self createPlayerWithSong:((MusicModel *)musicList[currentIndex]).musicName];
}
/**上一首*/
- (void)previousSong {
  if (currentIndex > 0) {
    currentIndex--;
  } else {
    currentIndex = musicList.count - 1;
  }
  [self clearAllState];
  [self createPlayerWithSong:((MusicModel *)musicList[currentIndex]).musicName];
}

#pragma mark - 按钮点击回调
/**展示歌单*/
- (IBAction)srcList:(UIButton *)sender { // 歌单
  if (!listController) {
    listController = [[MusicListViewController alloc] init];
//    // 注册观察者用于listController移除时回调
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(showSubview)
//                                                 name:@"showView"
//                                               object:nil];
  }

//  [self hideSubview];

  ViewController *__weak weakSelf = self;
//  __weak MusicListViewController *weakListController = listController;

    CGRect frame = listController.view.frame;
    frame.origin.x = weakSelf.view.frame.size.width;
  listController.playSong = ^(NSString *songName) {
    [weakSelf createPlayerWithSong:songName];
    [weakSelf srcAnimation:NO];
  };//block
  NSMutableArray *array = [NSMutableArray arrayWithCapacity:musicList.count];
  for (MusicModel *model in musicList) {
    [array addObject:model.musicName];
  }
  [listController setData:array];
  [listController.view setFrame:self.view.bounds];
    listController.view.frame = frame;
  [self.view addSubview:listController.view];
  [self srcAnimation:YES];
}

/**显示歌单视图动画*/
-(void)srcAnimation:(BOOL)isShow{
    ViewController *__weak weakSelf = self;
    __weak MusicListViewController *weakListController = listController;
    CGRect frame = weakListController.view.frame;
    if (isShow) {
        frame.origin.x = 0;
    }else{
        frame.origin.x = weakSelf.view.frame.size.width;
    }
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft
                           forView:weakSelf.view
                             cache:NO];
    [UIView animateWithDuration:1.0f
                     animations:^{
                         
                         weakListController.view.frame = frame;
                     }
                     completion:^(BOOL finished) {
                         //          [weakSelf showSubview];
                     }];
}

/**显示子视图*/
- (void)showSubview {
  self.list.hidden = NO;
  self.topCoverView.hidden = NO;
  self.bottomCoverView.hidden = NO;
}
/**隐藏子视图*/
- (void)hideSubview {
  self.list.hidden = YES;
  self.topCoverView.hidden = YES;
  self.bottomCoverView.hidden = YES;
}

/**点击下载*/
- (IBAction)download:(UIButton *)sender { // 下载
  sender.selected = !sender.selected;
  MusicModel *model = musicList[currentIndex];
  model.isDownload = sender.selected;
}
/**点击添加喜欢*/
- (IBAction)love:(UIButton *)sender { // 喜欢
  sender.selected = !sender.selected;
  MusicModel *model = musicList[currentIndex];
  model.isLoved = sender.selected;
}
/**播放,暂停*/
- (IBAction)play:(UIButton *)sender { // 播放/暂停
  sender.selected = !sender.selected;
  if (sender.selected) {
    [self playSong];
  } else {
    [player pause];
    timer.fireDate = [NSDate distantFuture];
    timer = nil;
  }
}
/**点击进入下一首*/
- (IBAction)next:(UIButton *)sender { // 下一曲
  [self nextSong];
}
/**点击进入上一首*/
- (IBAction)previous:(UIButton *)sender { // 上一曲
  [self previousSong];
}

#pragma mark - 播放代理回调
/**播放完毕*/
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player
                       successfully:(BOOL)flag {
  [self nextSong];
}

@end
