//
//  changeMethod.m
//  JKRunTimeDemo
//
//  Created by emerys on 16/5/7.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import "exchangeMethod.h"
#import <objc/runtime.h>
#import "JKPerson.h"

@implementation exchangeMethod

- (void)dynamicExchangeMethod{
    JKPerson *p = [[JKPerson alloc] init];
    
    Method m1 = class_getInstanceMethod([p class], @selector(say));
    Method m2 = class_getInstanceMethod([p class], @selector(fight));
    
    method_exchangeImplementations(m1, m2);
 
    printf("perform_Say     ");
    [p performSelector:@selector(say)];
    printf("perform_Fight     ");
    [p performSelector:@selector(fight)];
    
}

@end
