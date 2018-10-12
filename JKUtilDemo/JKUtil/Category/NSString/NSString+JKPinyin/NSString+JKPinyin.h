//
//  NSString+JKPinyin.h
//  JKUtilDemo
//
//  Created by Jack on 2018/10/12.
//  Copyright © 2018年 Emerys. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, JKStringCase) {
    JKStringCaseNone = 0, // 不转换
    JKStringCaseLower = 1, // 小写
    JKStringCaseUpper = 2, // 大写
    JKStringCaseCapitalized = 3 // 首字母大写
};

@interface NSString (JKPinyin)

/**
 * @brief 汉子转拼音
 * @param stringCase 大小写选项
 * @param diacritics 是否带声调
 */

- (NSString *)chinesePinyinWithCase:(JKStringCase)stringCase Diacritics:(BOOL)diacritics;

@end
