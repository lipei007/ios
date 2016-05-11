//
//  JKImageBrowser.h
//  JKImageBrowserDemo
//
//  Created by emerys on 16/5/11.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import <UIKit/UIKit.h>

#define JKLogPoint(var) (NSLog(@"X:%f,  Y:%f",var.x,var.y))
#define JKLogSize(var) (NSLog(@"width:%f,   height:%f",var.width,var.height))
#define JKLogRect(var) (NSLog(@"X:%f,   Y:%f,  width:%f,    height:%f",var.origin.x,var.origin.y,var.size.width,var.size.height))

typedef void(^hideAnimationFinishBlock)(void);

@interface JKImageBrowser : UIView

@property (nonatomic,strong) UIView *imageContainer;

@property (nonatomic,copy) hideAnimationFinishBlock hideBlock;

+ (instancetype)browserWithFrame:(CGRect)frame image:(UIImage *)image;

- (void)hideWithCenterScaleAnimation:(BOOL)centerAnimation;

@end
