//
//  Pen.m
//  图形绘制
//
//  Created by Emerys on 7/30/15.
//  Copyright (c) 2015 Emerys. All rights reserved.
//

#import "Pen.h"

@implementation Pen

+(Pen *)sharedPen{
    static Pen *p = nil;
    if (p == nil) {
        p = [[Pen alloc] init];
        p.color = [UIColor blueColor];
    }
    return p;
}

@end
