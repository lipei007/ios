//
//  NSString+JKValidate.m
//  JKUtilDemo
//
//  Created by Jack on 2018/10/12.
//  Copyright © 2018年 Emerys. All rights reserved.
//

#import "NSString+JKValidate.h"

@implementation NSString (JKValidate)

- (BOOL)isPhoneNumber {
    
    // 手机号
    NSString * MOBILE = @"^(0[0-9]{2,3})?([2-9][0-9]{6,7})+(-[0-9]{1,4})?$|(^(13[0-9]|15[0|3|6|7|8|9]|18[8|9])\\d{8}$)";
    
    // 固话、小灵通
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",PHS];
    
    BOOL isMobile = [regextestmobile evaluateWithObject:self];
    BOOL isPHS = [regextestphs evaluateWithObject:self];

    return isMobile || isPHS;
}

- (BOOL)isEmailAddress {
    
    NSString *emailRegex =@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:self];
    
}

- (BOOL)isNumber {
    
    if (self.length == 0) {
        return NO;
    }
    
    NSString *numberRegx = @"[0-9]*";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",numberRegx];
    
    return [predicate evaluateWithObject:self];
}

- (BOOL)isInteger {
  
    if (self.length == 0) {
        return NO;
    }
    
    NSString *intergerRegx = @"^(-?(0|[1-9][0-9]*))$";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",intergerRegx];
    
    return [predicate evaluateWithObject:self];
}

- (BOOL)isDecimal {
    
    if (self.length == 0) {
        return NO;
    }
    
    NSString *regx = @"^(-?\\d+)(\\.\\d+)?$";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regx];
    
    return [predicate evaluateWithObject:self];
}

@end
