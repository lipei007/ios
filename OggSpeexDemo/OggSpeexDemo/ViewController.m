//
//  ViewController.m
//  OggSpeexDemo
//
//  Created by emerys on 16/4/21.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import "ViewController.h"
#import "RecorderManager.h"
#import "PlayerManager.h"

@interface ViewController ()<PlayingDelegate,RecordingDelegate>

@property (weak, nonatomic) IBOutlet UIProgressView *meterLevel;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *recordButton;

@property (nonatomic,copy)  NSString *filePath;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.meterLevel.progress = 0.0f;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)recordButtonClicked:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        // 录音
        [RecorderManager sharedManager].delegate = self;
        [RecorderManager sharedManager].saveName = @"0001"; // 保存的文件名，没有的话会默认生成
        [[RecorderManager sharedManager] startRecording];

    } else {
        // 停止录音
        [[RecorderManager sharedManager] stopRecording];
        CGFloat recordTimeInterval = [[RecorderManager sharedManager] recordedTimeInterval]; // 录制时间,录制完成后才能获取时间
        NSLog(@"recordTimeInterval:%f",recordTimeInterval);
        

    }
}

- (IBAction)playButtonClicked:(UIButton *)sender {
    if (self.filePath) {
        sender.selected = !sender.selected;
        if (sender.selected) {
            // 播放
            [[PlayerManager sharedManager] playAudioWithFileName:self.filePath delegate:self];
            
            if ([PlayerManager sharedManager].avAudioPlayer) { // mp3文件
                NSLog(@"sound duration:%f",[PlayerManager sharedManager].avAudioPlayer.duration);
            } else { // spx文件
                NSLog(@"da o");
            }
        } else {
            // 停止播放
            [[PlayerManager sharedManager] stopPlaying];
        }
    }
}

#pragma mark - Recording & Playing Delegate

- (void)recordingFinishedWithFileName:(NSString *)filePath time:(NSTimeInterval)interval {
    self.filePath = filePath;
    self.recordButton.selected = NO;
    self.meterLevel.progress = 0;
}

- (void)recordingTimeout {
    NSLog(@"录音超时");
    self.meterLevel.progress = 0;
}

- (void)recordingStopped {
    NSLog(@"录音停止");
    self.meterLevel.progress = 0;
}

- (void)recordingFailed:(NSString *)failureInfoString {
    NSLog(@"录音失败");
    self.meterLevel.progress = 0;
}

// 监控声波
- (void)levelMeterChanged:(float)levelMeter {
    self.meterLevel.progress = levelMeter;
}

- (void)playingStoped {
    self.playButton.selected = NO;
    self.meterLevel.progress = 0;
}

@end
