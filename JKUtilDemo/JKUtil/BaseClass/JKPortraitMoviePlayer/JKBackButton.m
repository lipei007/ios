//
//  JKBackButton.m
//  moviePlayer
//
//  Created by emerys on 15/12/4.
//  Copyright © 2015年 Emerys. All rights reserved.
//

#import "JKBackButton.h"

@interface JKBackButton ()

@property (nonatomic,strong) CAShapeLayer *backRow;

@end

@implementation JKBackButton

-(CAShapeLayer *)backRow{
    if (!_backRow) {
        _backRow = [CAShapeLayer layer];
        _backRow.fillColor = [UIColor clearColor].CGColor;
        _backRow.strokeColor = [UIColor whiteColor].CGColor;
        _backRow.lineWidth = 2.0f;
    }
    return _backRow;
}
/**绘制返回箭头*/
-(void)drawRowInRect:(CGRect)rect{
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGFloat l = rect.size.width < rect.size.height ? rect.size.width : rect.size.height;
    
    CGPoint A = CGPointMake(0.3 * l, 0.5 * l);
    CGPoint B = CGPointMake(0.7 * l, 0.9 * l);
    CGPoint C = CGPointMake(0.7 * l, 0.1 * l);
    
    [path moveToPoint:C];
    [path addLineToPoint:A];
    [path addLineToPoint:B];
    
    self.backRow.path = path.CGPath;
    
    [self.layer addSublayer:self.backRow];
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self drawRowInRect:frame];
    }
    return self;
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self drawRowInRect:frame];
}


@end
