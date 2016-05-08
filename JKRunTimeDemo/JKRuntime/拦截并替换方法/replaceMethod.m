//
//  replaceMethod.m
//  JKRunTimeDemo
//
//  Created by emerys on 16/5/7.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import "replaceMethod.h"
#import <objc/runtime.h>
#import "JKPerson.h"

@implementation replaceMethod

- (void)replace{
    static dispatch_once_t tocken;
    dispatch_once(&tocken, ^{
        JKPerson *p = [[JKPerson alloc] init];
        
        Class originCls = [p class];
        Class curCls = [self class];
        
        SEL originSel = @selector(scold:);
        SEL curSel = @selector(myScold:);
        
        Method originM = class_getInstanceMethod(originCls,originSel);
        Method curM = class_getInstanceMethod(curCls, curSel);
        
        BOOL ok = class_addMethod(originCls, curSel, (IMP)method_getImplementation(curM), method_getTypeEncoding(curM));
        if (ok) {
            class_replaceMethod(originCls, originSel, (IMP)method_getImplementation(curM), method_getTypeEncoding(curM));
            class_replaceMethod(originCls, curSel, (IMP)method_getImplementation(originM), method_getTypeEncoding(originM));
        }else{
            method_exchangeImplementations(originM, curM);
        }

    });
}

- (void)myScold:(NSString *)msg{
    printf("hahahahha 拦截替换了");
}

@end
