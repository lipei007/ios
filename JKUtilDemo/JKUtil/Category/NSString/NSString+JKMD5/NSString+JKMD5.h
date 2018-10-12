//
//  NSString+JKMD5.h
//  JKUtilDemo
//
//  Created by Jack on 2018/10/12.
//  Copyright © 2018年 Emerys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JKMD5)

- (nullable NSString *)md5String;

+ (NSString *)fileMD5:(NSString *)filePath;

@end

