//
//  UIImage+JKSize.m
//  AHCResidentClient
//
//  Created by emerys on 16/4/7.
//  Copyright © 2016年 arrcen. All rights reserved.
//

#import "UIImage+JKSize.h"

@implementation UIImage (JKSize)


+ (UIImage *)image:(UIImage *)image scaleToSize:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaleImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaleImg;
}

@end
