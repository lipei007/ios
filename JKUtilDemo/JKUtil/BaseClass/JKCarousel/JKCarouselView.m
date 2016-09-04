//
//  JKCarouselView.m
//  Carousel
//
//  Created by emerys on 16/9/4.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import "JKCarouselView.h"



@implementation JKCarouselView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.carouselView];
        [self addSubview:self.pageControl];
        
        UISwipeGestureRecognizer *left_swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dragContent:)];
        left_swipe.direction = UISwipeGestureRecognizerDirectionLeft;
        
        UISwipeGestureRecognizer *right_swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dragContent:)];
        right_swipe.direction = UISwipeGestureRecognizerDirectionRight;
        
        [self addGestureRecognizer:left_swipe];
        [self addGestureRecognizer:right_swipe];
        
    }
    return self;
}

- (UIScrollView *)carouselView {
    if (!_carouselView) {
        
        // 创建
        _carouselView = [[UIScrollView alloc] initWithFrame:self.bounds];
        
        //
        _carouselView.pagingEnabled = YES;
        _carouselView.showsVerticalScrollIndicator = NO;
        _carouselView.showsHorizontalScrollIndicator = NO;
        
        CGFloat w = CGRectGetWidth(self.bounds);
        CGFloat h = CGRectGetHeight(self.bounds);
        
        for (int i = 0; i < 3; i++) {
            
            JKCarouselCell *cell = [[JKCarouselCell alloc] initWithFrame:CGRectMake(i * w, 0, w, h)];
            cell.imageContainer.backgroundColor = JKRandomColor;
            cell.tag = 1024 + i;
            
            [_carouselView addSubview:cell];
        }
        
        _carouselView.contentSize =  CGSizeMake(CGRectGetWidth(self.bounds) * 3, 0);
        
    }
    return _carouselView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.bounds) - 20, JK_ScreenWidth, 10)];
        _pageControl.pageIndicatorTintColor = [UIColor darkGrayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor lightGrayColor];
        _pageControl.currentPage = 0;
        _pageControl.userInteractionEnabled = NO;
    }
    return _pageControl;
}

- (void)dragContent:(UISwipeGestureRecognizer *)regonizer {
    
    if (self.dragDelegate && [self.dragDelegate respondsToSelector:@selector(dragCarouselDirection:)]) {
        [self.dragDelegate dragCarouselDirection:regonizer.direction];
    }
    
}


@end
