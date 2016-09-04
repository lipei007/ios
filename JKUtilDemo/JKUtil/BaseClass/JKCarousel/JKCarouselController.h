//
//  JKCarouselController.h
//  Carousel
//
//  Created by emerys on 16/9/4.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKCarouselView.h"

@interface JKCarouselController : NSObject

@property (nonatomic,strong,readonly) UIView *view;

+ (JKCarouselController *)carouselWithFrame:(CGRect) frame
                                   contents:(NSArray<UIImage *> *)contents
                                   duration:(NSTimeInterval)timeInterval
                             indicatorColor:(UIColor *)indicatorColor
                               currentColor:(UIColor *)currentColor
                                    clicked:(imageContainerClickBlock)click;


@end
