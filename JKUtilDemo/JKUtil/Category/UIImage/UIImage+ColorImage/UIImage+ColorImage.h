//
//  UIImage+ColorImage.h
//  chemistry2048
//
//  Created by emerys on 16/4/1.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ColorImage)

/**
 *  @author Jack Lee, 16-04-01 19:04:02
 *
 *  @brief 生成一个颜色为color的image对象
 *
 *  @param color image颜色
 */
+ (instancetype)imageWithColor:(UIColor *)color;

+ (instancetype)imageWithColor:(UIColor *)color size:(CGSize)size;

@end
