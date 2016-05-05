//
//  UIView+JKImage.m
//  JKUtilDemo
//
//  Created by emerys on 16/4/21.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import "UIView+JKImage.h"

@implementation UIView (JKImage)

- (UIImage *)jk_image{
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, self.layer.contentsScale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    return img;
}

@end
