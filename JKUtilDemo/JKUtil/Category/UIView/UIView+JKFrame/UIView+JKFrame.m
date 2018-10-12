//
//  UIView+JKFrame.m
//  JKUtilDemo
//
//  Created by Jack on 2018/10/12.
//  Copyright © 2018年 Emerys. All rights reserved.
//

#import "UIView+JKFrame.h"

@implementation UIView (JKFrame)

- (void)setJk_x:(CGFloat)jk_x {
    CGRect frame = self.frame;
    frame.origin.x = jk_x;
    self.frame = frame;
}

- (CGFloat)jk_x {
    return self.frame.origin.x;
}

- (void)setJk_y:(CGFloat)jk_y {
    CGRect frame = self.frame;
    frame.origin.y = jk_y;
    self.frame = frame;
}

- (CGFloat)jk_y {
    return self.frame.origin.y;
}

- (void)setJk_width:(CGFloat)jk_width {
    CGRect frame = self.frame;
    frame.size.width = jk_width;
    self.frame = frame;
}

- (CGFloat)jk_width {
    return self.frame.size.width;
}

- (void)setJk_height:(CGFloat)jk_height {
    CGRect frame = self.frame;
    frame.size.height = jk_height;
    self.frame = frame;
}

- (CGFloat)jk_height {
    return self.frame.size.height;
}

- (void)setJk_right:(CGFloat)jk_right {
    self.jk_x = jk_right - self.jk_width;
}

- (CGFloat)jk_right {
    return self.jk_x + self.jk_width;
}

- (void)setJk_bottom:(CGFloat)jk_bottom {
    self.jk_y = jk_bottom - self.jk_height;
}

- (CGFloat)jk_bottom {
    return self.jk_y + self.jk_height;
}

- (void)setJk_cornerRadius:(CGFloat)cornerRadius {
    
    self.layer.cornerRadius = cornerRadius;
    if (cornerRadius) {
        self.layer.masksToBounds = YES;
    } else {
        self.layer.masksToBounds = NO;
    }
}

- (CGFloat)jk_cornerRadius {
    return self.layer.cornerRadius;
}

@end
