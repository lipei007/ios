//
//  DynamicChangeIvar.m
//  JKRunTimeDemo
//
//  Created by emerys on 16/5/7.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import "DynamicChangeIvar.h"
#import "JKPerson.h"
#import <objc/runtime.h>

@implementation DynamicChangeIvar

- (void)change{
    JKPerson *p = [[JKPerson alloc] init];
    
    // 更改年龄
    unsigned int count;
    // 获取所有成员变量
    Ivar *ivars = class_copyIvarList([p class], &count);
    // 遍历成员变量查找age
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char *ivar_name = ivar_getName(ivar);
        NSString *name = [NSString stringWithUTF8String:ivar_name];
        if ([name isEqualToString:@"_age"]) {
            // 修改年龄
            object_setIvar(p, ivar, @(16));
            break;
        }
    }
    
    NSLog(@"%@",p);
}

@end
