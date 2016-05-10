//
//  JKImageBrowserRootView.h
//  JKImageBrowserDemo
//
//  Created by emerys on 16/5/10.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JKImageBrowserRootView : UIView

+ (instancetype)browserRootViewWithFrame:(CGRect)frame images:(NSArray *)source operationButtonImage:(UIImage *)image;

@property (nonatomic,assign) NSUInteger currentImageIndex;



@end
