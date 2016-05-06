//
//  DrawPath.m
//  myDraw
//
//  Created by Emerys on 7/31/15.
//  Copyright (c) 2015 Emerys. All rights reserved.
//

#import "DrawPath.h"

@implementation DrawPath

-(void)drawRect:(CGRect)rect{
    
//    UIBezierPath *bezier;
//    
////    bezier = [UIBezierPath bezierPathWithArcCenter:self.center radius:50 startAngle:0 endAngle:M_2_PI clockwise:NO];
////    
////    bezier = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.center.x, self.center.y, 100, 100)];
//    
//    bezier = [UIBezierPath bezierPath];
//    [bezier moveToPoint:self.center];
//    [bezier addCurveToPoint:self.center controlPoint1:CGPointMake(100, 100) controlPoint2:CGPointMake(300, 300)];
//    [bezier addLineToPoint:CGPointMake(100, 100)];
//    [bezier addCurveToPoint:CGPointMake(100, 100) controlPoint1:CGPointMake(200, 150) controlPoint2:CGPointMake(100, 150)];
//    
//    [[UIColor redColor] setStroke];//设置绘边颜色
//                    //[[UIColor blackColor] setFill];//设置填充颜色
//    
//    [bezier stroke];//绘边
//                    //[bezier fill];//完全填充整个图形
    
    
    
    
        /*--------------------------------------*/
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint(ctx, 100, 50);
    
        //CGContextRotateCTM(ctx, M_PI_2);
    
    CGContextAddEllipseInRect(ctx, CGRectMake(100, 50, 50, 80));
    
    CGContextSetStrokeColorWithColor(ctx, [UIColor greenColor].CGColor);
    
        //CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    
    CGContextStrokePath(ctx);
    
    
    
    
}

@end
