//
//  JKShapeImage.m
//  mask
//
//  Created by emerys on 16/3/15.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import "JKShapeImage.h"

@interface JKShapeImage ()
{
    CAShapeLayer *maskLayer;
    CALayer *contentLayer;
}
@end

@implementation JKShapeImage

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //        [self setShapeMask];
    }
    return self;
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
}

-(void)setDirection:(BubbleDirection)direction{
    _direction = direction;
    [self setShapeMask];
}

-(void)setShapeMask{
    maskLayer = [CAShapeLayer layer];
    maskLayer = [CAShapeLayer layer];
    maskLayer.fillColor = [UIColor blackColor].CGColor;
    maskLayer.strokeColor = [UIColor clearColor].CGColor;
    //    maskLayer.lineWidth = 1.0f;
    maskLayer.frame = self.bounds;
    maskLayer.contentsCenter = CGRectMake(0.65, 0.65, 0.2, 0.2);
    maskLayer.contentsScale = [UIScreen mainScreen].scale;                 //非常关键设置自动拉伸的效果且不变形
    
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    
    switch (_direction) {
        case BubbleDirectionLeft:{
            [path moveToPoint:CGPointMake(9, 5)];
            [path addQuadCurveToPoint:CGPointMake(14, 0) controlPoint:CGPointMake(9, 0)];
            [path addLineToPoint:CGPointMake(w - 5, 0)];
            [path addQuadCurveToPoint:CGPointMake(w, 5) controlPoint:CGPointMake(w, 0)];
            [path addLineToPoint:CGPointMake(w, h - 5)];
            [path addQuadCurveToPoint:CGPointMake(w - 5, h) controlPoint:CGPointMake(w, h)];
            [path addLineToPoint:CGPointMake(14, h)];
            [path addQuadCurveToPoint:CGPointMake(9, h - 5) controlPoint:CGPointMake(9, h)];
            [path addLineToPoint:CGPointMake(9, 25)];
            [path addLineToPoint:CGPointMake(0, 20)];
            [path addLineToPoint:CGPointMake(9, 15)];
            [path addLineToPoint:CGPointMake(9, 5)];
        }
            break;
        case BubbleDirectionRight:{
            [path moveToPoint:CGPointMake(0, 5)];
            [path addQuadCurveToPoint:CGPointMake(5, 0) controlPoint:CGPointMake(0, 0)];
            [path addLineToPoint:CGPointMake(w - 14, 0)];
            [path addQuadCurveToPoint:CGPointMake(w - 9, 5) controlPoint:CGPointMake(w - 9, 0)];
            [path addLineToPoint:CGPointMake(w - 9, 15)];
            [path addLineToPoint:CGPointMake(w, 20)];
            [path addLineToPoint:CGPointMake(w - 9, 25)];
            [path addLineToPoint:CGPointMake(w - 9, h - 5)];
            [path addQuadCurveToPoint:CGPointMake(w - 14, h) controlPoint:CGPointMake(w - 9, h)];
            [path addLineToPoint:CGPointMake(5, h)];
            [path addQuadCurveToPoint:CGPointMake(0, h - 5) controlPoint:CGPointMake(0, h)];
            [path addLineToPoint:CGPointMake(0, 5)];
        }
            break;
        default:
            break;
    }
    
    maskLayer.path = path.CGPath;
    
    
    contentLayer = [CALayer layer];
    contentLayer.mask = maskLayer;
    contentLayer.frame = self.bounds;
    [self.layer addSublayer:contentLayer];
    
}

-(void)setImage:(UIImage *)image{
    _image = image;
    contentLayer.contents = (__bridge id)image.CGImage;
}

@end
