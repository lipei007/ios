//
//  JKCarousel.h
//  JKCarouselDemo
//
//  Created by emerys on 16/5/9.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JKCarouselScrollView : UIScrollView

@property (nonatomic,assign) BOOL showsPageIndicator;

+ (instancetype)carouselWithFrame:(CGRect)frame duration:(NSTimeInterval)duration contents:(NSArray<UIImage *> *)contents;

- (void)scroll;

- (void)endScroll;


@end
