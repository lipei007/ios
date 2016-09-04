//
//  JKCarousel.m
//  JKCarouselDemo
//
//  Created by emerys on 16/5/9.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import "JKCarouselScrollView.h"
#import "UIScrollView+JKContentImage.h"

#define w ([UIScreen mainScreen].bounds.size.width)

@interface JKCarouselScrollView ()<UIScrollViewDelegate>
   
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,assign) NSTimeInterval duration;
@property (nonatomic,strong) NSArray<UIImage *> *contents;
@property (nonatomic,assign) BOOL draging;

@end

@implementation JKCarouselScrollView

+ (instancetype)carouselWithFrame:(CGRect)frame duration:(NSTimeInterval)duration contents:(NSArray<UIImage *> *)contents{
    
    JKCarouselScrollView *carousel = [[JKCarouselScrollView alloc] initWithFrame:frame];
    carousel.showsVerticalScrollIndicator = NO;
    carousel.showsHorizontalScrollIndicator = NO;
    carousel.pagingEnabled = YES;
    __weak typeof(carousel) weakCarousel = carousel;
    carousel.delegate = weakCarousel;
    
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
    
    carousel.contentSize = CGSizeMake(w * mArray.count , 0);
    
    for (int i = 0; i < mArray.count; i++) {
    
        UIImage *img = [mArray objectAtIndex:i];
        UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
        imgView.frame = CGRectMake(w * i, 0, w, frame.size.height);
        [carousel addSubview:imgView];

    }
    
    if (contents.count > 1) {
        carousel.contentOffset = CGPointMake(w, 0);
    }
    
    carousel.duration = duration;
    carousel.contents = contents;
    
    return carousel;
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
    __block CGPoint offset = self.contentOffset;
    offset.x += w;
    [UIView animateWithDuration:0.8 animations:^{
        self.contentOffset = offset;
    }completion:^(BOOL finished) {
        NSInteger index = offset.x / w;
        if (self.contents.count > 1) {
            if (index == 0) {
                offset.x = w * self.contents.count;
            } else if (index == self.contents.count + 1) {
                offset.x = w;
            }
            self.contentOffset = offset;
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
        self.pageControl.backgroundColor = [UIColor redColor];
    }
}

#pragma mark - scrolllView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset = self.contentOffset;
    NSInteger index = offset.x / w;
    if (self.contents.count > 1 && self.draging) {
        if (index == 0) {
            offset.x = w * self.contents.count;
        } else if (index == self.contents.count + 1) {
            offset.x = w;
        }
        self.contentOffset = offset;
    }
    
    if (self.showsPageIndicator) {
        self.pageControl.currentPage = offset.x / w - 1;
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


@end
