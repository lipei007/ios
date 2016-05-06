//
//  Pen.h
//  图形绘制
//
//  Created by Emerys on 7/30/15.
//  Copyright (c) 2015 Emerys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Pen : UIView

@property UIColor *color;

+(Pen*)sharedPen;

@end
