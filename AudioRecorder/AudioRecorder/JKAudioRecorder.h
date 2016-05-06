//
//  JKAudioRecorder.h
//  AudioRecorder
//
//  Created by emerys on 16/3/31.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface JKAudioRecorder : NSObject

@property (nonatomic,strong) NSMutableDictionary *recoderSetting;///<设置 录音格式;录音采样率(8000是电话采样率);通道(这里采用单声道,每个采样点位数,分为8、16、24、32);是否使用浮点数采样;等等
@property (nonatomic,strong) NSString *savePath;///<录音存放路径,初始化需要指定

@property (nonatomic,assign,readonly) float audioPower;///<音频强度,范围0~1

@property (nonatomic,copy) void(^didfinishRecorder)();///<成功完成录音
@property (nonatomic,copy) void(^recordeInterrupt)();///<发生中断
@property (nonatomic,copy) void(^recorderEncodeError)(NSError *error);///<编码错误
@property (nonatomic,copy) void(^recordeEndInterrupt)();///<中断结束

-(void)startRecord;///<开始录音
-(void)pauseRecorde;///<暂停录音
-(void)stopRecorde;///<结束录音

-(instancetype)initWithSavePath:(NSString *)path;

@end
