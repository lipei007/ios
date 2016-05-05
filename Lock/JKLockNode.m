//
//  LXYLockNode.m
//  Lock
//
//  Created by emerys on 15/8/28.
//  Copyright (c) 2015年 Emerys. All rights reserved.
//

#import "JKLockNode.h"

@interface JKLockNode ()

@property (nonatomic,strong) CAShapeLayer *inscribedCircleLayer;

@property (nonatomic,strong) CAShapeLayer *kernelLayer;

@property (nonatomic,strong) CAShapeLayer *borderLayer;
@end

@implementation JKLockNode

#pragma mark 懒加载
/**内切圆*/
-(CAShapeLayer *)inscribedCircleLayer{
    if (!_inscribedCircleLayer) {
        _inscribedCircleLayer = [CAShapeLayer layer];
        _inscribedCircleLayer.strokeColor = [UIColor blueColor].CGColor;
        _inscribedCircleLayer.fillColor = [UIColor blackColor].CGColor;
        _inscribedCircleLayer.lineWidth = 1.0f;
    }
    return _inscribedCircleLayer;
}

/**内核*/
-(CAShapeLayer *)kernelLayer{
    if (!_kernelLayer) {
        _kernelLayer = [CAShapeLayer layer];
        _kernelLayer.strokeColor = [UIColor clearColor].CGColor;
        _kernelLayer.fillColor = [UIColor blueColor].CGColor;
        _kernelLayer.lineWidth = 1.0;
    }
    return _kernelLayer;
}
/**边框*/
-(CAShapeLayer *)borderLayer{
    if (!_borderLayer) {
        _borderLayer = [CAShapeLayer layer];
        _borderLayer.fillColor = [UIColor clearColor].CGColor;
        _borderLayer.strokeColor = [UIColor clearColor].CGColor;
        _borderLayer.lineWidth = 1.0f;
    }
    return _borderLayer;
}

#pragma mark 初始化
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.layer setNeedsDisplay];
        self.status = JKLockNodeStatusNormal;
    }
    return self;
}

#pragma mark 设置不同状态layer颜色
-(void)setColorForNormalStatus{
    self.inscribedCircleLayer.strokeColor = [UIColor grayColor].CGColor;
    self.kernelLayer.fillColor = [UIColor clearColor].CGColor;
    [self.layer setNeedsDisplay];
}

-(void)setColorForSelectedStatus{
    self.inscribedCircleLayer.strokeColor = [UIColor blueColor].CGColor;
    self.kernelLayer.fillColor = [UIColor blueColor].CGColor;
    [self.layer setNeedsDisplay];
}

-(void)setColorForWarningStatus{
    self.inscribedCircleLayer.strokeColor = [UIColor redColor].CGColor;
    self.kernelLayer.fillColor = [UIColor redColor].CGColor;
    [self.layer setNeedsDisplay];
}

#pragma mark 设置状态
-(void)setStatus:(JKLockNodeStatus)status{
    _status = status;
    switch (_status) {
        case JKLockNodeStatusNormal:
            [self setColorForNormalStatus];
            break;
        case JKLockNodeStatusSelected:
            [self setColorForSelectedStatus];
            break;
        case JKLockNodeStatusWarning:
            [self setColorForWarningStatus];
            break;
        default:
            break;
    }
}

#pragma mark 绘制
-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    
    self.inscribedCircleLayer.path = [UIBezierPath bezierPathWithOvalInRect:self.bounds].CGPath;
    CGFloat x = CGRectGetMidX(self.bounds);
    CGFloat y = CGRectGetMidY(self.bounds);
    CGFloat r = x < y ? x / 3.0 : y / 3.0;
    self.kernelLayer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(x, y)
                                                           radius:r
                                                       startAngle:0
                                                         endAngle:M_PI * 2
                                                        clockwise:YES].CGPath;
    self.borderLayer.path = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    
    [self.layer addSublayer:self.inscribedCircleLayer];
    [self.layer addSublayer:self.kernelLayer];
    [self.layer addSublayer:self.borderLayer];
    NSLog(@"%s",__func__);

}



@end
