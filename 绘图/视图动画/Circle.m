//
//  Circle.m
//  视图动画
//
//  Created by Emerys on 7/31/15.
//  Copyright (c) 2015 Emerys. All rights reserved.
//

#import "Circle.h"

@implementation Circle

+(Circle *)sharedCircle{
    static Circle *circle = nil;
    if (circle == nil) {
        circle = [[Circle alloc] init];
    }
    return circle;
}


-(void)drawRect:(CGRect)rect{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctx, 0, 0);
    
    CGContextAddEllipseInRect(ctx, rect);
    
    CGContextSetFillColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextFillPath(ctx);
    
}

@end
