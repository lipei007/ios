//
//  DrawView.h
//  图形绘制
//
//  Created by Emerys on 7/30/15.
//  Copyright (c) 2015 Emerys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSArray+sortArray.h"

    //UIColor *penColor = nil;

@interface DrawView : UIView

@property    NSMutableArray *dots;

// dic 存储颜色变化时点的个数（在数组中的位置）和对应的颜色
@property   NSMutableDictionary *dic;
    
@property   UIColor *colorGoAway;

@property NSUInteger indexOfColorChange;

    //change 标志 颜色是否发生改变
@property BOOL change;

+(DrawView *)sharedDrawView;

@end
