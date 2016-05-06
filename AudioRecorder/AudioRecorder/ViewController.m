//
//  ViewController.m
//  AudioRecorder
//
//  Created by emerys on 16/3/31.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import "ViewController.h"
#import "JKAudioRecorder.h"

@interface ViewController ()
{
    NSTimer *timer;
}
@property (weak, nonatomic) IBOutlet UIProgressView *progress;

@property (nonatomic,strong) JKAudioRecorder *audioRecorder;

@property (nonatomic,strong) AVAudioPlayer *audioPlayer;

@property (nonatomic,copy) NSString *path;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    [session setActive:YES error:nil];
    
    self.path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"record"];
    self.audioRecorder = [[JKAudioRecorder alloc] initWithSavePath:self.path];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(audioPowerChange:) userInfo:nil repeats:YES];
    timer.fireDate = [NSDate distantFuture];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}

-(AVAudioPlayer *)audioPlayer{
    if (!_audioPlayer) {
        NSURL *url= [NSURL URLWithString:self.path];
        NSError *error=nil;
        _audioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
        _audioPlayer.numberOfLoops=0;
        [_audioPlayer prepareToPlay];
        if (error) {
            NSLog(@"创建播放器过程中发生错误，错误信息：%@",error.localizedDescription);
            return nil;
        }
    }
    return _audioPlayer;
}

-(void)audioPowerChange:(NSTimer *)timer{
    CGFloat power = [self.audioRecorder audioPower];
    self.progress.progress = power;
}

- (IBAction)recorde:(UIButton *)sender {
    if (!sender.selected) {
        timer.fireDate = [NSDate distantPast];
        [self.audioRecorder startRecord];
        
    }else{
        [self.audioRecorder stopRecorde];
        timer.fireDate = [NSDate distantFuture];
    }
    sender.selected = !sender.selected;
}
- (IBAction)play:(UIButton *)sender {
    [self.audioPlayer play];
}

@end
