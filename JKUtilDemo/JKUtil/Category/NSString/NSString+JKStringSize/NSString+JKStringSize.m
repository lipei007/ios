//
//  NSString+JKStringSize.m
//  chat
//
//  Created by emerys on 16/3/10.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import "NSString+JKStringSize.h"

@implementation NSString (JKStringSize)


-(CGSize)sizeWithSize:(CGSize)size font:(UIFont *)font{
    NSDictionary *attribute = @{NSFontAttributeName: font};
    
    CGSize resSize = [self boundingRectWithSize:size
                                             options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                          attributes:attribute
                                             context:nil].size;
    
    return resSize;
}

@end
