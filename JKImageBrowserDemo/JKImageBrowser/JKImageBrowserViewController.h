//
//  JKImageBrowserViewController.h
//  JKImageBrowserDemo
//
//  Created by emerys on 16/5/10.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKImageCache.h"

@interface JKImageBrowserViewController : UIView


@property (nonatomic,strong) UIView *imageContainer;
@property (nonatomic,assign) NSInteger touchedImageIndex;


- (instancetype)initWithFrame:(CGRect)frame imageCache:(JKImageCache *)cache;

- (void)show;

@end
