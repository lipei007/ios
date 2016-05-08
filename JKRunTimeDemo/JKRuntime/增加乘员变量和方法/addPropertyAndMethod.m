//
//  addPropertyAndMethod.m
//  JKRunTimeDemo
//
//  Created by emerys on 16/5/7.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import "addPropertyAndMethod.h"
#import "JKPerson.h"
#import <objc/runtime.h>


@implementation addPropertyAndMethod

- (void)addMethod{
    JKPerson *p = [[JKPerson alloc] init];
    
    // 动态增加方法
    class_addMethod([p class], @selector(eat), (IMP)eat, "v@:");
    // IMP 是eat函数的指针
    // "v@:@"，v代表void，无返回值，若返回值为int，则为i；
    // @代表 id sel; : 代表 SEL _cmd;
    // “v@:@@” 意思是，两个参数的没有返回值。
    // 一个Objective-C方法是一个简单的C函数，
    // 它至少包含两个参数—self和_cmd。
    // 所以，我们的实现函数(IMP参数指向的函数)至少需要两个参数
    
    // 调用新增加的方法
    [p performSelector:@selector(eat)];
}

void eat(id self, SEL _cmd){
    printf("新来的\n");
}

- (void)addProperty{
    const char heightKey;
    JKPerson *p = [[JKPerson alloc] init];
    objc_setAssociatedObject(p, &heightKey, @(1.8), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    id value = objc_getAssociatedObject(p, &heightKey);
    
    NSLog(@"动态添加属性 %@",value);
}

- (void)addIVar{
    JKPerson *p = [[JKPerson alloc] init];
    
    class_addIvar([p class], "sex", sizeof(NSString *), 0, "@");
    
    object_setIvar(p, class_getInstanceVariable([p class], "sex"), @"m");
    
    NSString *sex = object_getIvar(p, class_getInstanceVariable([p class], "sex"));
    
    NSLog(@"动态添加成员变量sex:%@",sex);
}

@end
