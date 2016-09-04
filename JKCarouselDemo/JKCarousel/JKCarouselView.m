//
//  JKCarouselView.m
//  JKCarouselDemo
//
//  Created by emerys on 16/5/9.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import "JKCarouselView.h"
#import "UIScrollView+JKContentImage.h"

#define w ([UIScreen mainScreen].bounds.size.width)

@interface JKCarouselView ()<UIScrollViewDelegate>

@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,assign) NSTimeInterval duration;
@property (nonatomic,strong) NSArray<UIImage *> *contents;
@property (nonatomic,assign) BOOL draging;
@property (nonatomic,copy)   tapAction tapAction;

@end

@implementation JKCarouselView


+ (instancetype)carouselWithFrame:(CGRect)frame duration:(NSTimeInterval)duration contents:(NSArray<UIImage *> *)contents withTapAction:(tapAction)action{
    
    JKCarouselView *carouselView = [[JKCarouselView alloc] initWithFrame:frame];
    carouselView.carousel = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    carouselView.carousel.showsVerticalScrollIndicator = NO;
    carouselView.carousel.showsHorizontalScrollIndicator = NO;
    carouselView.carousel.pagingEnabled = YES;
    carouselView.carousel.delegate = carouselView;
    
    // last 0 1 2 3 4 ...last 0
    NSMutableArray *mArray = [NSMutableArray array];
    if (contents.count > 1) {
        for (int i = 0; i < contents.count + 2; i++) {
            UIImage *img;
            if (i == 0) {
                img = [contents objectAtIndex:contents.count -1];
            } else if (i > 0 && i < contents.count + 1) {
                img = [contents objectAtIndex:i - 1];
            } else if (i == contents.count + 1) {
                img = [contents objectAtIndex:0];
            }
            [mArray addObject:img];
        }
    } else {
        [mArray addObjectsFromArray:contents];
    }
    
    carouselView.carousel.contentSize = CGSizeMake(w * mArray.count , 0);
    
    for (int i = 0; i < mArray.count; i++) {
        
        UIImage *img = [mArray objectAtIndex:i];
        UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
        imgView.frame = CGRectMake(w * i, 0, w, frame.size.height);
        [carouselView.carousel addSubview:imgView];
        
        imgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:carouselView action:@selector(tapCarouselImage:)];
        tapGesture.numberOfTapsRequired = 1;
        [imgView addGestureRecognizer:tapGesture];
    }
    
    if (contents.count > 1) {
        carouselView.carousel.contentOffset = CGPointMake(w, 0);
    }
    
    carouselView.duration = duration;
    carouselView.contents = contents;
    carouselView.tapAction = action;
    
    [carouselView addSubview:carouselView.carousel];
    
    return carouselView;
}

- (void)scroll{
    if (self.contents.count > 1) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:_duration target:self selector:@selector(goNext:) userInfo:nil repeats:YES];
    }
}

- (void)endScroll{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)goNext:(NSTimer *)timer{
    __block CGPoint offset = self.carousel.contentOffset;
    offset.x += w;
    [UIView animateWithDuration:0.8 animations:^{
        self.carousel.contentOffset = offset;
    }completion:^(BOOL finished) {
        NSInteger index = offset.x / w;
        if (self.contents.count > 1) {
            if (index == 0) {
                offset.x = w * self.contents.count;
            } else if (index == self.contents.count + 1) {
                offset.x = w;
            }
            self.carousel.contentOffset = offset;
        }
    }];
}

#pragma mark - pageControl
- (void)setShowsPageIndicator:(BOOL)showsPageIndicator{
    _showsPageIndicator = showsPageIndicator;
    if (_showsPageIndicator) {
        CGFloat x = 0;
        CGFloat y = self.bounds.size.height - 20;
        CGFloat width = w;
        CGFloat height = 10;
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(x, y, width, height)];
        self.pageControl.numberOfPages = self.contents.count;
        self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        self.pageControl.currentPageIndicatorTintColor = [UIColor darkGrayColor];
        [self addSubview:self.pageControl];
        [self bringSubviewToFront:self.pageControl];
    }
}

#pragma mark - scrolllView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset = self.carousel.contentOffset;
    NSInteger index = offset.x / w;
    if (self.contents.count > 1 && self.draging) {
        if (index == 0) {
            offset.x = w * self.contents.count;
        } else if (index == self.contents.count + 1) {
            offset.x = w;
        }
        self.carousel.contentOffset = offset;
    }
    
    if (self.showsPageIndicator && self.contents.count > 1) {
        NSInteger idx = offset.x / w;
        if (idx == 0) {
            self.pageControl.currentPage = self.contents.count - 1;
        } else if (idx == self.contents.count + 1) {
            self.pageControl.currentPage = 0;
        } else {
            self.pageControl.currentPage = idx - 1;
        }
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    self.draging = YES;
    if (self.timer)
        [self endScroll];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    self.draging = NO;
    if (decelerate)
        [self scroll];
}

#pragma mark - gesture

- (void)tapCarouselImage:(UITapGestureRecognizer *)tap{
    CGPoint offset = self.carousel.contentOffset;
    NSInteger index = offset.x / w;
    NSInteger idx;
    if (index == 0) {
         idx = self.contents.count - 1;
    } else if (index == self.contents.count + 1) {
         idx = 0;
    } else {
        idx = index - 1;
    }
    
    if (self.tapAction) {
        self.tapAction([self.contents objectAtIndex:idx]);
    }
}


@end
