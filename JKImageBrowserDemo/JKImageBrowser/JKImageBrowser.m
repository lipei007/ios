//
//  JKImageBrowser.m
//  JKImageBrowserDemo
//
//  Created by emerys on 16/5/11.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import "JKImageBrowser.h"

@interface JKImageBrowser ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong) UIScrollView *zoomScrollView;
@property (nonatomic,strong) UIImageView *zoomImageView;
@property (nonatomic,assign) CGFloat totalScale;

@end

@implementation JKImageBrowser

+ (instancetype)browserWithFrame:(CGRect)frame image:(UIImage *)image{
    JKImageBrowser *browser = [[JKImageBrowser alloc] initWithFrame:frame];
    browser.image = image;
    browser.totalScale = 1.0f;
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
        
        _zoomScrollView.minimumZoomScale = 0.5;
        _zoomScrollView.maximumZoomScale = 2;
        
        self.zoomImageView.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
        [_zoomScrollView addSubview:self.zoomImageView];
        
        // 旋转手势(现在旋转后，缩放会将其复原)
//        UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateImage:)];
//        rotation.delegate = self;
//        [_zoomScrollView addGestureRecognizer:rotation];
        
    }
    return _zoomScrollView;
}

- (void)hideWithCenterScaleAnimation:(BOOL)centerAnimation {
    if (centerAnimation) {
        [UIView animateWithDuration:0.4 animations:^{
            self.zoomImageView.transform = CGAffineTransformScale(self.zoomImageView.transform, 0.2, 0.2);
        } completion:^(BOOL finished) {
            if (self.hideBlock) {
                self.hideBlock();
            }
        }];
    } else {
//        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        CGRect tmpRect = [self.imageContainer convertRect:self.imageContainer.bounds toView:self.imageContainer.window];

        [UIView animateWithDuration:0.4 animations:^{
            self.zoomImageView.frame = tmpRect;
        } completion:^(BOOL finished) {
            if (self.hideBlock) {
                self.hideBlock();
            }
        }];
    }
}

#pragma mark - gesture

- (void)rotateImage:(UIRotationGestureRecognizer *)rotation {
    CGFloat angle = rotation.rotation;
    angle = angle > 0 ? M_PI_2 : -M_PI_2;
    self.zoomImageView.transform = CGAffineTransformRotate(self.zoomImageView.transform, angle);
    rotation.rotation = 0;
}

#pragma mark UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}


#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return scrollView.subviews.lastObject;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGFloat x = scrollView.contentSize.width < CGRectGetWidth(scrollView.frame) ? CGRectGetWidth(scrollView.frame) * 0.5 : scrollView.contentSize.width * 0.5;
    CGFloat y = scrollView.contentSize.height < CGRectGetHeight(scrollView.frame) ? CGRectGetHeight(scrollView.frame) * 0.5 : scrollView.contentSize.height * 0.5;
    self.zoomImageView.center = CGPointMake(x, y);
}


@end
