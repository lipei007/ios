//
//  NSString+JKValidate.h
//  JKUtilDemo
//
//  Created by Jack on 2018/10/12.
//  Copyright © 2018年 Emerys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JKValidate)

@property (nonatomic,assign,readonly) BOOL isPhoneNumber;
@property (nonatomic,assign,readonly) BOOL isEmailAddress;
@property (nonatomic,assign,readonly) BOOL isNumber;
@property (nonatomic,assign,readonly) BOOL isInteger;
@property (nonatomic,assign,readonly) BOOL isDecimal;

@end

