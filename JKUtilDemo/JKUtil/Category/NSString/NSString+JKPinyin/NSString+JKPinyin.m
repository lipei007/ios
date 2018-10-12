//
//  NSString+JKPinyin.m
//  JKUtilDemo
//
//  Created by Jack on 2018/10/12.
//  Copyright © 2018年 Emerys. All rights reserved.
//

#import "NSString+JKPinyin.h"

@implementation NSString (JKPinyin)

- (NSString *)chinesePinyinWithCase:(JKStringCase)stringCase Diacritics:(BOOL)diacritics {
    
    NSMutableString *str = [NSMutableString stringWithString:self];
    
    //带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    
    if (!diacritics) {
        //不带声调的拼音
        CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    }
    
    NSString *pinyin = str;
    switch (stringCase) {
        case JKStringCaseLower: {
            pinyin = str.lowercaseString;
        }
            break;
        case JKStringCaseUpper: {
            pinyin = str.uppercaseString;
        }
            break;
        case JKStringCaseCapitalized: {
            pinyin = str.capitalizedString;
        }
            break;
        default:
            break;
    }
    return pinyin;
}

@end
