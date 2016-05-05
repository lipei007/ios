//
//  LXYtest.m
//  Lock
//
//  Created by emerys on 15/8/31.
//  Copyright (c) 2015年 Emerys. All rights reserved.
//

#import "JKTest.h"

@interface JKTest ()
{
    CGPoint start;
    CGPoint end;
}
@end

@implementation JKTest


-(instancetype)init{
    if (self = [super init]) {
        UIPanGestureRecognizer *p = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                            action:@selector(pan:)];
        [self addGestureRecognizer:p];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)pan:(UIPanGestureRecognizer*)p{
 
    if (p.state == UIGestureRecognizerStateBegan) {
        start = [p locationInView:self];
        end = [p locationInView:self];
    }
    else{
        end = [p locationInView:self];
    }
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.strokeColor = [UIColor redColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.lineWidth = 2.0f;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:start];
    [path addLineToPoint:end];
    layer.path = path.CGPath;
    [self.layer addSublayer:layer];
    [self.layer setNeedsDisplay];
    
}

@end
