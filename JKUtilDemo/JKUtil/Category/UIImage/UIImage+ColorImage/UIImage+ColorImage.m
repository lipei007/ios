//
//  UIImage+ColorImage.m
//  chemistry2048
//
//  Created by emerys on 16/4/1.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import "UIImage+ColorImage.h"

@implementation UIImage (ColorImage)

+(instancetype)imageWithColor:(UIColor *)color{
    return [self imageWithColor:color size:CGSizeMake(1, 1)];
}

+ (instancetype)imageWithColor:(UIColor *)color size:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(ctx, CGRectMake(0, 0, size.width, size.height));
    CGContextSetFillColorWithColor(ctx, color.CGColor);
    CGContextFillPath(ctx);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
