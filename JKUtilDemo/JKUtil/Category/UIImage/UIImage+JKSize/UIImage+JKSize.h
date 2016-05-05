//
//  UIImage+JKSize.h
//  AHCResidentClient
//
//  Created by emerys on 16/4/7.
//  Copyright © 2016年 arrcen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JKSize)

/**
 *  @author Jack Lee, 16-04-07 10:04:06
 *
 *  @brief 将image放大缩小到指定大小
 *
 *  @param image 将要缩放到imgae对象
 *  @param size  缩放后的尺寸
 *
 *  @return 缩放后的image对象
 */
+ (UIImage *)image:(UIImage *)image scaleToSize:(CGSize)size;

@end
