//
//  MusicModel.h
//  音乐播放器
//
//  Created by emerys on 15/9/12.
//  Copyright (c) 2015年 Emerys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicModel : NSObject<NSCoding>

@property (nonatomic,copy) NSString *musicName;

@property (nonatomic,assign) BOOL isLoved;

@property (nonatomic,assign) BOOL isDownload;

@end
