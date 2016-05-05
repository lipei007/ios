//
//  UIColor+JK_HEX.m
//  chemistry2048
//
//  Created by emerys on 16/4/19.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import "UIColor+JK_HEX.h"

@implementation UIColor (JK_HEX)

+ (instancetype)colorWithHEX:(NSInteger)hex{
    return [UIColor colorWithRed:((hex & 0xff0000) >> 16) / 255.0 green:((hex & 0xff00) >> 8) / 255.0 blue:(hex & 0xff) / 255.0 alpha:1];
}

+ (instancetype)colorWithHEXString:(NSString *)hexString{
    if ([hexString hasPrefix:@"#"]) {
        hexString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@"0x"];
    }
    
    if (![hexString hasPrefix:@"0x"]) {
        return nil;
    }
    
    NSInteger hex = strtoul([hexString UTF8String],0,16);
    return [self colorWithHEX:hex];
}

@end
