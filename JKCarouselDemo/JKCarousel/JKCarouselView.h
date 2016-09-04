//
//  JKCarouselView.h
//  JKCarouselDemo
//
//  Created by emerys on 16/5/9.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^tapAction)(UIImage *);

@interface JKCarouselView : UIView

@property (nonatomic,assign) BOOL showsPageIndicator;
@property (nonatomic,strong) UIScrollView *carousel;


+ (instancetype)carouselWithFrame:(CGRect)frame duration:(NSTimeInterval)duration contents:(NSArray<UIImage *> *)contents withTapAction:(tapAction)action;

- (void)scroll;

- (void)endScroll;

@end
