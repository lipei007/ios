//
//  JKCacheSlider.h
//  moviePlayer
//
//  Created by emerys on 15/12/6.
//  Copyright © 2015年 Emerys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+ColorImage.h"


@interface JKCacheSlider : UISlider

// the cacheValue is between 0 and 1.0,also there is minimumValue 0 and maximumValue 1
@property (nonatomic,assign) double cacheValue;

// default is a image with size {10,10} and white color,if you need, you can import UIImage+ColorImage.h to set a image with size and color;
@property (nonatomic,strong) UIImage *slipCube;

/**
 *  @author Jack Lee, 16-04-21 09:04:34
 *
 *  @brief 设置进度条颜色
 *
 *  @param minimumTrackTintColor 播放进度条颜色，默认为白色
 *  @param middleTrackTintColor  缓冲进度条颜色，默认为浅灰色
 *  @param maximumTrackTintColor 背景色，默认为深灰色
 */
- (void)setMinimumTrackTintColor:(UIColor *)minimumTrackTintColor middleTrackTintColor:(UIColor *)middleTrackTintColor maximumTrackTintColor:(UIColor *)maximumTrackTintColor;

+ (instancetype)cacheSliderWithFrame:(CGRect)frame;


@end
