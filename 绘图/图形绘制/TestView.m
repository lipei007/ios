//
//  TestView.m
//  图形绘制
//
//  Created by Emerys on 7/30/15.
//  Copyright (c) 2015 Emerys. All rights reserved.
//

#import "TestView.h"
#import "DrawView.h"
#import "Pen.h"


@implementation TestView


-(void)drawRect:(CGRect)rect{
    
    
    
    UIView *tab = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, 20)];
    tab.backgroundColor = [UIColor orangeColor];
    
    
        //屏幕宽度375
        //tab 上如果有五色可选,则每个颜色占宽度75
        //5 65 5 5 65 5
    CGFloat buttonWidth = 65;
    for(int i = 0; i < 5; i++){
        UIButton *button = [[UIButton alloc] initWithFrame:
                            CGRectMake(5 + i * (buttonWidth + 10), 
                                       0, 
                                       buttonWidth, 
                                       rect.size.height)];
        button.backgroundColor = [UIColor colorWithRed:0.5 * i 
                                                 green:0.1 * i  
                                                  blue:0.2 * i
                                                 alpha:1];
        [button addTarget:self 
                   action:@selector(setColor:) 
         forControlEvents:UIControlEventTouchUpInside];
        
        [tab addSubview:button];
        
        
    }
    
    
    [self addSubview:tab];
    
    
        //DrawView *dw = [[DrawView alloc] init];
    DrawView *dw = [DrawView sharedDrawView];
    dw.frame = CGRectMake(0, 20, rect.size.width, rect.size.height-20);
    dw.backgroundColor = [UIColor grayColor];
    
    [self addSubview:dw];
    
    
}


-(void)setColor:(UIButton *)btn{
        //NSLog(@"啊～换颜色了。。。。");
    
        //UIColor *temColor;
    DrawView *dv = [DrawView sharedDrawView];
    Pen *pen = [Pen sharedPen];
    
    dv.change = YES;
    dv.colorGoAway = pen.color;
        //temColor = pen.color;
    
    dv.indexOfColorChange = dv.dots.count;
    pen.color = btn.backgroundColor;
    
    [dv.dic setObject:dv.colorGoAway forKey:
                    [NSString stringWithFormat:@"%li",dv.indexOfColorChange]];
        //NSLog(@"%@",dv.dic);
}


@end
