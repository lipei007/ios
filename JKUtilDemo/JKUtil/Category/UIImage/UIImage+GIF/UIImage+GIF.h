//
//  UIImage+GIF.h
//  JKText
//
//  Created by emerys on 16/4/19.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (GIF)

/**
 *  @author Jack Lee, 16-04-19 16:04:20
 *
 *  @brief 创建一个gif的图片实例
 *
 *  @param data gif图片二进制数据
 *
 *  @return gif图像实例
 */
+ (instancetype)gifImageWithData:(NSData *)data;


@end
