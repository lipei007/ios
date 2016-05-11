//
//  JKImageBrowserViewController.m
//  JKImageBrowserDemo
//
//  Created by emerys on 16/5/10.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import "JKImageBrowserViewController.h"
#import "JKImageBrowserRootView.h"


@interface JKImageBrowserViewController ()

@property (nonatomic,strong) JKImageBrowserRootView *rootView;///<根视图
@property (nonatomic,strong) JKImageCache *imageCache;///<图片缓存(数据源)

@end

@implementation JKImageBrowserViewController

- (instancetype)initWithFrame:(CGRect)frame imageCache:(JKImageCache *)cache {
    if ([super initWithFrame:frame]) {
        self.imageCache = cache;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTohide:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (JKImageBrowserRootView *)rootView {
    if (!_rootView) {
        _rootView = [JKImageBrowserRootView browserRootViewWithFrame:self.bounds images:self.imageCache.images currentImageIndex:self.touchedImageIndex operationButtonImage:nil];
    }
    return _rootView;
}

- (void)setupUserInterFace {
    [self addSubview:self.rootView];
}

- (void)show {
    [self setupUserInterFace];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    // 80, 300, 250, 170 获取view相对于屏幕的坐标。
    CGRect tmpRect = [self.imageContainer convertRect:self.imageContainer.bounds toView:self.imageContainer.window];
    
    UIImage *image = self.imageCache.images[self.touchedImageIndex];
    UIImageView *tmpIV = [[UIImageView alloc] initWithImage:image];
    tmpIV.frame = tmpRect;
    
    [window addSubview:tmpIV];
    
    CGFloat scale = image.size.width > self.bounds.size.width ? self.bounds.size.width / image.size.width : 1.0f;
    CGFloat w = image.size.width * scale;
    CGFloat h = image.size.height * scale;
    
    tmpRect = CGRectMake((self.bounds.size.width - w) * 0.5, (self.bounds.size.height - h) * 0.5, w, h);
    [UIView animateWithDuration:0.4 animations:^{
        tmpIV.frame = tmpRect;
    } completion:^(BOOL finished) {
        self.backgroundColor = [UIColor blackColor];
        [window addSubview:self];
        [tmpIV removeFromSuperview];
        [window bringSubviewToFront:self];
    }];
    
}

#pragma mark - gesture

- (void)tapTohide:(UITapGestureRecognizer *)tap {
    __weak typeof(self) weakSelf = self;
    self.rootView.hideBlock = ^{
        [UIView animateWithDuration:0.2 animations:^{
            weakSelf.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.4];
        } completion:^(BOOL finished) {
             [weakSelf removeFromSuperview];
        }];
    };
    self.rootView.imageContainer = self.imageContainer;
    [self.rootView scaleAnimationToHideWithStartIndex:self.touchedImageIndex];
}

@end
