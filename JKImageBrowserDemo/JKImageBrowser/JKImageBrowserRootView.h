//
//  JKImageBrowserRootView.h
//  JKImageBrowserDemo
//
//  Created by emerys on 16/5/10.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKImageBrowser.h"


@interface JKImageBrowserRootView : UIView

@property (nonatomic,strong) UIView *imageContainer;
@property (nonatomic,copy) hideAnimationFinishBlock hideBlock;

+ (instancetype)browserRootViewWithFrame:(CGRect)frame images:(NSArray *)source currentImageIndex:(NSInteger)index operationButtonImage:(UIImage *)image;

- (void)scaleAnimationToHideWithStartIndex:(NSInteger)index;

@end
