//
//  JKCacheSlider.m
//  moviePlayer
//
//  Created by emerys on 15/12/6.
//  Copyright © 2015年 Emerys. All rights reserved.
//

#import "JKCacheSlider.h"

#define OFFSET 2

@interface JKCacheSlider()

@property (nonatomic,strong) UIProgressView *middleProgress;

@end

@implementation JKCacheSlider


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self loadSubView];
        self.cacheValue = 0;
    }
    return self;
}

+ (instancetype)cacheSliderWithFrame:(CGRect)frame{
    JKCacheSlider *cacheSlider = [[JKCacheSlider alloc] initWithFrame:frame];
    cacheSlider.minimumValue = 0.0f;
    cacheSlider.maximumValue = 1.0f;
    cacheSlider.cacheValue = 0.0f;
    cacheSlider.slipCube = [UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(10, 10)];
    
    cacheSlider.minimumTrackTintColor = [UIColor whiteColor];
    cacheSlider.maximumTrackTintColor = [UIColor clearColor];
    cacheSlider.middleProgress.trackTintColor = [UIColor lightGrayColor];
    cacheSlider.middleProgress.progressTintColor = [UIColor darkGrayColor];
    
    return cacheSlider;
}

- (UIProgressView *)middleProgress{
    if (!_middleProgress) {
        CGRect frame = self.bounds;
        frame.origin.x += OFFSET;
        frame.size.width -= OFFSET * 2;
        _middleProgress = [[UIProgressView alloc] initWithFrame:frame];
        _middleProgress.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
        _middleProgress.trackTintColor = [UIColor clearColor];
        _middleProgress.progressTintColor = [UIColor clearColor];
        _middleProgress.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _middleProgress;
}

- (void)loadSubView{
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.middleProgress];
    [self sendSubviewToBack:self.middleProgress];
}

- (void)setCacheValue:(double)cacheValue{
    _cacheValue = cacheValue;
    self.middleProgress.progress = cacheValue;
}

- (void)setSlipCube:(UIImage *)slipCube{
    _slipCube = slipCube;
    [self setThumbImage:slipCube forState:UIControlStateNormal];
}

-(void)setMinimumTrackTintColor:(UIColor *)minimumTrackTintColor middleTrackTintColor:(UIColor *)middleTrackTintColor maximumTrackTintColor:(UIColor *)maximumTrackTintColor{
    self.minimumTrackTintColor = minimumTrackTintColor;
    self.maximumTrackTintColor = [UIColor clearColor];
    self.middleProgress.trackTintColor = maximumTrackTintColor;
    self.middleProgress.progressTintColor = middleTrackTintColor;
}


@end
