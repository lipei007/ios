//
//  JKPerson.m
//  JKRunTimeDemo
//
//  Created by emerys on 16/5/7.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import "JKPerson.h"

@implementation JKPerson

- (instancetype)init{
    if (self = [super init]) {
        self.name = @"miaomiao";
        self.age = @(20);
    }
    return self;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"%@ %li",self.name,self.age.integerValue];
}

- (void)say{
    printf("say\n");
}

- (void)fight{
    printf("fight\n");
}

- (void)scold:(NSString *)msg{
    NSLog(@"scold:%@",msg);
}

@end
