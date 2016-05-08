//
//  NSObject+JKCoder.m
//  JKRunTimeDemo
//
//  Created by emerys on 16/5/7.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import "NSObject+JKCoder.h"
#import <objc/runtime.h>

@implementation NSObject (JKCoder)

- (void)encodeWithCoder:(NSCoder *)aCoder{
    unsigned int count;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        
        const char *ivarUTF8Name = ivar_getName(ivar);
        NSString *ivarName = [NSString stringWithUTF8String:ivarUTF8Name];
        
        id value = object_getIvar(self, ivar);
        
        [aCoder encodeObject:value forKey:ivarName];
    }
    free(ivars);
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [self init]) {
        unsigned int count;
        Ivar *ivars = class_copyIvarList([self class], &count);
        for (int i = 0; i < count; i++) {
            Ivar ivar = ivars[i];
            
            const char *ivarUTF8Name = ivar_getName(ivar);
            NSString *ivarName = [NSString stringWithUTF8String:ivarUTF8Name];
            
            id value = [aDecoder decodeObjectForKey:ivarName];
            
            [self setValue:value forKey:ivarName];
        }
        free(ivars);
    }
    return self;
}

@end
