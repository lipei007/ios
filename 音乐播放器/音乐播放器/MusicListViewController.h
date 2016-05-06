//
//  MusicListViewController.h
//  音乐播放器
//
//  Created by emerys on 15/9/11.
//  Copyright (c) 2015年 Emerys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicListViewController : UIViewController

@property (nonatomic,copy) void(^playSong)(NSString *songName);
-(void)setData:(NSArray *)data;

@end
