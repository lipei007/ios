//
//  needDelegate.m
//  视图动画
//
//  Created by Emerys on 8/1/15.
//  Copyright (c) 2015 Emerys. All rights reserved.
//

#import "needDelegate.h"

@implementation needDelegate

-(instancetype)initWithFrame:(CGRect)frame{//调用init方法，默认会来到此方法
    self = [super initWithFrame:frame];
    if (self) {
        
            //图层显示时，不会自动重绘。需要调用setNeedDisplay标记为需要重绘
        [self.layer setNeedsDisplay];
            
        [self.layer setContentsScale:[UIScreen mainScreen].scale];
        
    }
    return self;
}


-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    
        //在UIKit中绘制新的图形，必须将旧上下文入栈保存，否则将显示一片黑，绝对不是你想要的结果
    UIGraphicsPushContext(ctx);
    
        /*重新绘制背景色，当使用drawLayer:inContext:方法进行自定义绘图时，
         *大部分自动图层设置（backgroundColor 和 cornerRadius）会被忽略。
         *他的任务就是绘制图形。
         */
    [[UIColor whiteColor] set];//设置当前上下文的颜色（fill、stroke）
    
    UIRectFill(layer.bounds);//
    
        //字体大小
    UIFont *font = [UIFont systemFontOfSize:30];
        //字体颜色
    UIColor *color = [UIColor redColor];
        
        //左对齐、居中对齐、右对齐
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    [style setAlignment:NSTextAlignmentCenter];
    
    NSDictionary *attribs = @{NSFontAttributeName:font,
                              NSForegroundColorAttributeName:color,
                              NSParagraphStyleAttributeName:style};
        //定义一个被设置了颜色、位置、字体大小的字符串
    NSAttributedString *
    text = [[NSAttributedString alloc] 
            initWithString:@"pushing the sun" attributes:attribs];
    
    [text drawInRect:CGRectInset([layer bounds], 10, 100)];
    
        //绘制完之后，将旧的上下文出栈
    UIGraphicsPopContext();
 
}

@end
