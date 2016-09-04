//
//  JKCarouselView.h
//  Carousel
//
//  Created by emerys on 16/9/4.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKCarouselCell.h"

@protocol JKCarouselDragDelegate <NSObject>

@optional
- (void)dragCarouselDirection:(UISwipeGestureRecognizerDirection)direction;

@end

@interface JKCarouselView : UIView

@property (nonatomic,strong) UIScrollView *carouselView;

@property (nonatomic,strong) UIPageControl *pageControl;

@property (nonatomic,weak) id<JKCarouselDragDelegate> dragDelegate;


@end
