//
//  DrawView.m
//  图形绘制
//
//  Created by Emerys on 7/30/15.
//  Copyright (c) 2015 Emerys. All rights reserved.
//

#import "DrawView.h"
#import "Dot.h"
#import "Pen.h"

@interface DrawView ()


@end


@implementation DrawView

@synthesize dots = dots;
@synthesize dic = dic;

+(DrawView *)sharedDrawView{
    static DrawView *dv = nil;
    if (dv == nil) {
        dv = [[DrawView alloc] init];
        dv.colorGoAway = [UIColor blueColor];
        dv.indexOfColorChange = 0;
        dv.change = NO;
        
        if(nil == dv.dots) {
            dv.dots = [NSMutableArray array];
        }
        
        if (dv.dic == nil) {
            dv.dic = [NSMutableDictionary dictionary];
        }


        
    }
    return dv;
}

//-(NSMutableArray *)dots {
//    
//    if(nil == dots) {
//        dots = [NSMutableArray array];
//    }
//    return dots;
//}
//
//-(NSMutableDictionary *)dic{
//    if (dic == nil) {
//        dic = [NSMutableDictionary dictionary];
//    }
//    return dic;
//}
//
//-(BOOL)change{
//    _change = NO;
//    return _change;
//}
   
- (void)drawRect:(CGRect)rect {
    
    Pen *pen = [Pen sharedPen];
    UIColor *penColor = pen.color;
    
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(ctx, penColor.CGColor);
//    for(Dot *dot in dots) {
//        CGContextAddArc(ctx, dot.x, dot.y, 5.0f, 0.0f, 2.0f * M_PI, YES);
//        CGContextFillPath(ctx);
//    }
    
    
    if (_change) {
            //创建一个数组用于保存dic中的key,用于遍历dic
        NSArray *temp = [dic allKeys];
            //对key排序，确保从小到大
        NSMutableArray *keyArray = [NSMutableArray arrayWithArray:
                                                            [temp arraySort]];        
            //NSLog(@"%@",keyArray);
        
        NSInteger idx = 0;
        for (NSInteger i = 0; i < keyArray.count; i++) {
            UIColor *color = [dic objectForKey:keyArray[i]];
            NSInteger index = [keyArray[i] integerValue];
            
            
            for (NSInteger j = idx; j < index; j++) {
                Dot *dot = dots[j];
                CGContextSetFillColorWithColor(ctx, color.CGColor);
                CGContextAddArc(ctx, dot.x, dot.y, 2.0f, 0.0f, 2.0f * M_PI, YES);
                CGContextFillPath(ctx);
                
            }
            idx = index;
            
        }//for
         //最后一个颜色的点,即当前颜色
        idx = [keyArray[keyArray.count-1] integerValue];
        UIColor *color = pen.color;
        for (NSInteger i = idx; i < dots.count; i++) {
                //NSLog(@"%li－－－－%@",i,color);
            Dot *dot = dots[i];
            CGContextSetFillColorWithColor(ctx, color.CGColor);
            CGContextAddArc(ctx, dot.x, dot.y, 2.0f, 0.0f, 2.0f * M_PI, YES);
            CGContextFillPath(ctx);

        }
        
        
        
    }else{
        CGContextSetFillColorWithColor(ctx, penColor.CGColor);
        for(Dot *dot in dots) {
            CGContextAddArc(ctx, dot.x, dot.y, 2.0f, 0.0f, 2.0f * M_PI, YES);
            CGContextFillPath(ctx);
        }

        
    }
}
    

- (void)dealloc {
    dots = nil;
}
 
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    Dot *dot = [[Dot alloc] init] ;
    dot.x = location.x;
    dot.y = location.y;
        //[self.dots removeAllObjects];
    [self.dots addObject:dot];
    [self setNeedsDisplay];
        //NSLog(@"%lu",dots.count);
}
  
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    Dot *dot = [[Dot alloc] init] ;
    dot.x = location.x;
    dot.y = location.y;
    [self.dots addObject:dot];
    [self setNeedsDisplay];
        //NSLog(@"%lu",dots.count);
}
  


@end
