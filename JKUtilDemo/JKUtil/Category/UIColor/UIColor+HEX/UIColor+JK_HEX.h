//
//  UIColor+JK_HEX.h
//  chemistry2048
//
//  Created by emerys on 16/4/19.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (JK_HEX)

+ (instancetype)colorWithHEX:(NSInteger)hex;

+ (instancetype)colorWithHEXString:(NSString *)hexString;

@end
