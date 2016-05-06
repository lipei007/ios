//
//  JKAudioRecorder.m
//  AudioRecorder
//
//  Created by emerys on 16/3/31.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import "JKAudioRecorder.h"

@interface JKAudioRecorder ()<AVAudioRecorderDelegate>

@property (nonatomic,strong) AVAudioRecorder *recorder;///<录音机对象

@end

@implementation JKAudioRecorder

-(NSMutableDictionary *)recoderSetting{
    if (!_recoderSetting) {
        _recoderSetting = [NSMutableDictionary dictionary];
        //设置录音格式
        [_recoderSetting setObject:@(kAudioFormatLinearPCM) forKey:AVFormatIDKey];
        //设置录音采样率，8000是电话采样率
        [_recoderSetting setObject:@(8000) forKey:AVSampleRateKey];
        //设置通道,这里采用单声道
        [_recoderSetting setObject:@(1) forKey:AVNumberOfChannelsKey];
        //每个采样点位数,分为8、16、24、32
        [_recoderSetting setObject:@(8) forKey:AVLinearPCMBitDepthKey];
        //是否使用浮点数采样
        [_recoderSetting setObject:@(YES) forKey:AVLinearPCMIsFloatKey];
    }
    return _recoderSetting;
}

-(AVAudioRecorder *)recoder{
    if (!_recorder) {
        //创建录音文件保存路径
        NSURL *url= [NSURL URLWithString:self.savePath];
        //创建录音格式设置
        NSDictionary *setting= self.recoderSetting;
        //创建录音机
        NSError *error=nil;
        _recorder =[[AVAudioRecorder alloc]initWithURL:url settings:setting error:&error];
        _recorder.delegate=self;
        _recorder.meteringEnabled=YES;//如果要监控声波则必须设置为YES
        [_recorder prepareToRecord];// 创建缓冲区
        if (error) {
            NSLog(@"创建录音机对象时发生错误，错误信息：%@",error.localizedDescription);
            return nil;
        }
    }
    return _recorder;
}
-(float)audioPower{
    [self.recorder updateMeters];//更新测量值
    float power= [self.recorder averagePowerForChannel:0];//取得第一个通道的音频，注意音频强度范围时-160到0
    
    return (1.0/160.0)*(power+160.0);
}
#pragma mark - method
-(instancetype)initWithSavePath:(NSString *)path{
    if (self = [super init]) {
        self.savePath = path;
    }
    return self;
}
-(void)startRecord{
    if (![self.recoder isRecording]) {
        [self.recoder record];
    }
}
-(void)pauseRecorde{
    if ([self.recoder isRecording]) {
        [self.recoder pause];
    }
}
-(void)stopRecorde{
    if ([self.recoder isRecording]) {
        [self.recoder stop];
    }
}

#pragma mark - avaudioRecorder delegate
/**
 *  @author Jack Lee, 16-03-31 10:03:09
 *
 *  @brief 完成录音
 *
 *  @param recorder 录音机对象
 *  @param flag     成功与否
 */
-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
    if (flag && self.didfinishRecorder) {
        self.didfinishRecorder();
    }
}
/**
 *  @author Jack Lee, 16-03-31 10:03:36
 *
 *  @brief 录音中断
 *
 *  @param recorder 录音机对象
 */
-(void)audioRecorderBeginInterruption:(AVAudioRecorder *)recorder{
    if (self.recordeInterrupt) {
        self.recordeInterrupt();
    }
}
/**
 *  @author Jack Lee, 16-03-31 10:03:28
 *
 *  @brief 录音编码时发生错误
 *
 *  @param recorder 录音机对象
 *  @param error    错误
 */
-(void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error{
    if (error && self.recorderEncodeError) {
        self.recorderEncodeError(error);
    }
}
/**
 *  @author Jack Lee, 16-03-31 10:03:07
 *
 *  @brief 录音机中断结束
 *
 *  @param recorder 录音机对象
 *  @param flags    结束标记
 */
-(void)audioRecorderEndInterruption:(AVAudioRecorder *)recorder withOptions:(NSUInteger)flags{
    if (self.recordeEndInterrupt) {
        self.recordeEndInterrupt();
    }
}

@end
