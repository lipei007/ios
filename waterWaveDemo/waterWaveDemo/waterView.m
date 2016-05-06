//
//  waterView.m
//  waterWaveDemo
//
//  Created by emerys on 15/10/22.
//  Copyright © 2015年 Emerys. All rights reserved.
//

#import "waterView.h"

#define colorFromRGB(var) [UIColor colorWithRed:((var & 0xff0000) >> 16) / 255.0 green:((var & 0xff00) >> 8) / 255.0 blue:(var & 0xff) / 255.0 alpha:1]

@interface waterView ()

@property (nonatomic,strong) NSTimer *timer;

@end

@implementation waterView

-(NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    }
    return _timer;
}

-(void)timerAction:(NSTimer *)timer{
    NSInteger pulsingCount = 5; //  脉冲个数
    double animationDuration = 3; // 每个脉冲持续时间
    
    CGRect rect = self.bounds;
    
    for (int i = 0; i < pulsingCount; i++) {
        CALayer * pulsingLayer = [CALayer layer];
        pulsingLayer.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
        pulsingLayer.borderColor = colorFromRGB(0xffffff).CGColor;
        pulsingLayer.borderWidth = 1;
        pulsingLayer.cornerRadius = rect.size.height / 2;
        
        CAMediaTimingFunction * easeInCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]; // 控制变化速度
        
        // 将一个layer的不同的动画效果组合起来
        CAAnimationGroup * animationGroup = [CAAnimationGroup animation];
        animationGroup.fillMode = kCAFillModeBackwards;
        NSArray *time = @[@0,@(1.0/7),@(5.0/14),@(9.0/14),@1];
        animationGroup.beginTime = CACurrentMediaTime() + [time[i] floatValue] * animationDuration;
        animationGroup.duration = animationDuration;
        animationGroup.repeatCount = 0; // HUGE = MAXFLOAT
        animationGroup.timingFunction = easeInCurve;
        
        CABasicAnimation * scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.fromValue = @1.0;
        scaleAnimation.toValue = @(271/131.0);
        
        // 关键帧动画
        CAKeyframeAnimation * opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];// 控制不透明度
        
        opacityAnimation.values = @[@1, @0.8, @0.6, @0.4, @0.2,@1]; // 不透明度节点
        opacityAnimation.keyTimes = @[@0, @(1.0/7), @(5.0/14), @(9.0/14), @1];// 指定每个节点路径的时间
        
        animationGroup.animations = @[scaleAnimation, opacityAnimation];
        [pulsingLayer addAnimation:animationGroup forKey:@"plulsing"];
        
        [self.layer addSublayer:pulsingLayer];
        [self setNeedsDisplay];
    }
    
    

}

-(void)beginAnimation{
    self.timer.fireDate = [NSDate distantPast];
}

-(void)stop{
    [self.timer invalidate];
    self.timer.fireDate = [NSDate distantFuture];
}

-(void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    CGContextFillRect(context, rect);
}



@end
