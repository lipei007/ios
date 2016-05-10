//
//  JKImageBrowser.m
//  JKImageBrowserDemo
//
//  Created by emerys on 16/5/11.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import "JKImageBrowser.h"

@interface JKImageBrowser ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong) UIScrollView *zoomScrollView;
@property (nonatomic,strong) UIImageView *zoomImageView;

@end

@implementation JKImageBrowser

+ (instancetype)browserWithFrame:(CGRect)frame image:(UIImage *)image{
    JKImageBrowser *browser = [[JKImageBrowser alloc] initWithFrame:frame];
    browser.image = image;
    
    [browser setupUserInterface];
    
    return browser;
}

- (void)setupUserInterface{
    [self addSubview:self.zoomScrollView];
}

- (UIImageView *)zoomImageView {
    if (!_zoomImageView) {
        CGFloat scale = self.image.size.width > self.bounds.size.width ? self.bounds.size.width / self.image.size.width : 1.0f;
        CGFloat w = self.image.size.width * scale;
        CGFloat h = self.image.size.height * scale;
        
        _zoomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
        _zoomImageView.userInteractionEnabled = YES;
        _zoomImageView.image = self.image;
        
        UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewPinch:)];
        [_zoomImageView addGestureRecognizer:pinch];
    }
    return _zoomImageView;
}

- (UIScrollView *)zoomScrollView {
    if (!_zoomScrollView) {
        CGFloat scale = self.image.size.width > self.bounds.size.width ? self.bounds.size.width / self.image.size.width : 1.0f;
        CGFloat w = self.image.size.width * scale;
        CGFloat h = self.image.size.height * scale;
        
        _zoomScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _zoomScrollView.showsHorizontalScrollIndicator = NO;
        _zoomScrollView.showsVerticalScrollIndicator = NO;
        _zoomScrollView.pagingEnabled = NO;
        _zoomScrollView.backgroundColor = [UIColor clearColor];
        _zoomScrollView.delegate = self;
        _zoomScrollView.contentSize = CGSizeMake(w, h);
        
        self.zoomImageView.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
        [_zoomScrollView addSubview:self.zoomImageView];

    }
    return _zoomScrollView;
}

#pragma mark - pinch
- (void)imageViewPinch:(UIPinchGestureRecognizer *)pinch{
    self.zoomImageView.transform = CGAffineTransformScale(self.zoomImageView.transform, pinch.scale, pinch.scale);
    CGSize siz = self.zoomScrollView.contentSize;
    self.zoomScrollView.contentSize = CGSizeMake(siz.width * pinch.scale, siz.height * pinch.scale);
    
    CGFloat x = siz.width * pinch.scale < self.bounds.size.width ? self.bounds.size.width * 0.5 : siz.width * pinch.scale * 0.5;
    CGFloat y = siz.height * pinch.scale < self.bounds.size.height ? self.bounds.size.height * 0.5 : siz.height * pinch.scale * 0.5;
    self.zoomImageView.center = CGPointMake(x, y);
    
    pinch.scale = 1;
}


@end
