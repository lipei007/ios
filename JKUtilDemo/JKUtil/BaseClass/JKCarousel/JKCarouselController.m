//
//  JKCarouselController.m
//  Carousel
//
//  Created by emerys on 16/9/4.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import "JKCarouselController.h"

#import "JKTimerManager.h"

typedef enum JKScrollDirection {
    JKScrollDirectionLeft,
    JKScrollDirectionRight
}JKScrollDirection;

#define TimerIdentifier @"timer"

#define JKDebugPosition NSLog(@"\nFile:%@ \nLine:%d",[[NSString stringWithUTF8String:__FILE__] lastPathComponent],__LINE__)

@interface JKCarouselController ()<UIScrollViewDelegate,JKCarouselDragDelegate>

@property (nonatomic,strong) JKCarouselView *carouselView;

@property (nonatomic,strong) NSArray *contents;

@property (nonatomic,strong) JKTimerManager *timerManager;

@property (nonatomic,assign) NSTimeInterval timeInterval;

@property (nonatomic,assign) JKScrollDirection direction;

@property (nonatomic,assign) NSInteger currentPage;

@property (nonatomic,copy) imageContainerClickBlock block;

@property (nonatomic,assign) BOOL scroll; // 解决左滑出错

//@property (nonatomic,assign) BOOL drag; // 左滑pageControl出错

@end

@implementation JKCarouselController

+ (JKCarouselController *)carouselWithFrame:(CGRect)frame contents:(NSArray<UIImage *> *)contents duration:(NSTimeInterval)timeInterval indicatorColor:(UIColor *)indicatorColor currentColor:(UIColor *)currentColor clicked:(imageContainerClickBlock)click{
    
    if (!contents.count) {
        return nil;
    }
    
    JKCarouselController *controller = [[JKCarouselController alloc] init];
    
    controller.timeInterval = timeInterval;
    controller.currentPage = 0;
    controller.contents = contents;
    
    controller.carouselView = [[JKCarouselView alloc] initWithFrame:frame];
    controller.carouselView.pageControl.numberOfPages = contents.count;
    controller.carouselView.pageControl.currentPage = controller.currentPage;
    
//    controller.carouselView.dragDelegate = controller;
    controller.carouselView.carouselView.delegate = controller;
    
    if (indicatorColor) {
        controller.carouselView.pageControl.pageIndicatorTintColor = indicatorColor;
    }
    
    if (currentColor) {
        controller.carouselView.pageControl.currentPageIndicatorTintColor = currentColor;
    }
    
    if (click) {
        controller.block = click;
    }
    
    [controller initialContent];
    
    controller.timerManager = [JKTimerManager sharedTimerManager];
    [controller.timerManager scheduledDispatchTimerWithName:TimerIdentifier timeInterval:timeInterval queue:nil repeats:YES action:^{
       
        dispatch_async(dispatch_get_main_queue(), ^{
           //
            [controller autoScroll];
        });
        
    }];
    
    return controller;
}

- (UIView *)view {
    return self.carouselView;
}



#pragma mark - scroll

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.scroll) {
        NSInteger index = (NSInteger)(scrollView.contentOffset.x / CGRectGetWidth(scrollView.bounds));
        
        switch (index) {
            case 0:{
                if (self.currentPage == 0) {
                    self.currentPage = self.contents.count - 1;
                } else {
                    self.currentPage--;
                }
                
                [self resetContentsAnimate:NO];
            }
                break;
            case 1:{
                
            }
                break;
            case 2:{
                if (self.currentPage == self.contents.count - 1) {
                    self.currentPage = 0;
                } else {
                    self.currentPage++;
                }
                [self resetContentsAnimate:NO];
            }
                break;
                
            default:
                break;
        }
        
        self.carouselView.pageControl.currentPage = self.currentPage;
        self.scroll = NO;
        
    }

}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    JKLogMethodName;
    [self.timerManager cancelTimerWithName:TimerIdentifier];
    self.scroll = YES;
//    self.drag = YES;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (decelerate) {
        [self.timerManager scheduledDispatchTimerWithName:TimerIdentifier timeInterval:self.timeInterval queue:nil repeats:YES action:^{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //
                [self autoScroll];
            });
            
        }];
    }
}

#pragma mark - customer

- (void)initialContent {
    UIScrollView *scrollView = self.carouselView.carouselView;
    
    UIImage *img = nil;
    NSInteger imgIdex = 0;
    
    for (int i = 0; i < 3; i++) {
        switch (i) {
            case 0:{
                if (self.currentPage == 0) {
                    imgIdex = self.contents.count - 1;
                } else {
                    imgIdex = self.currentPage - 1;
                }
                
            }
                break;
            case 1:{
                imgIdex = self.currentPage;
            }
                break;
            case 2:{
                if (self.currentPage == self.contents.count - 1) {
                    imgIdex = 0;
                } else {
                    imgIdex = self.currentPage + 1;
                }
                
            }
                break;
                
            default:
                break;
        }
        
        img = [self.contents objectAtIndex:imgIdex];
        JKCarouselCell *cell = [scrollView viewWithTag:1024 + i];
        cell.content = img;
        cell.contentIndex = imgIdex;
        
        cell.clickBlock = self.block;
        
        
    }
    
    scrollView.contentOffset = CGPointMake(CGRectGetWidth(scrollView.bounds), 0);
    self.carouselView.pageControl.currentPage = self.currentPage;
}

- (void)resetContentsAnimate:(BOOL)animated {
    
    [self initialContent];
    
}

- (void)autoScroll {
    UIScrollView *scrollView = self.carouselView.carouselView;
    
    NSInteger index = (NSInteger)(scrollView.contentOffset.x / CGRectGetWidth(scrollView.bounds));
    
    [UIView setAnimationsEnabled:YES];
    
    scrollView.delegate = nil;
    
    self.scroll = YES;
    
    [UIView animateWithDuration:self.timeInterval / 7 animations:^{
        if (index == 2) {
            scrollView.contentOffset = CGPointMake(0, 0);
        } else {
            
            scrollView.contentOffset = CGPointMake((index + 1) * CGRectGetWidth(scrollView.bounds), 0);
        }
    } completion:^(BOOL finished) {
        scrollView.delegate = self;
        [self scrollViewDidEndDecelerating:scrollView];
    }];
    
    
}

#pragma mark - Drag

- (void)dragCarouselDirection:(UISwipeGestureRecognizerDirection)direction {
    switch (direction) {
        case UISwipeGestureRecognizerDirectionLeft:{
            if (self.currentPage == 0) {
                self.currentPage = self.contents.count - 1;
            } else {
                self.currentPage--;
            }
            [self resetContentsAnimate:YES];
        }
            break;
        case UISwipeGestureRecognizerDirectionRight: {
            if (self.currentPage == self.contents.count - 1) {
                self.currentPage = 0;
            } else {
                self.currentPage++;
            }
            
            [self resetContentsAnimate:YES];
        }
            break;
            
        default:
            break;
    }

}

@end
