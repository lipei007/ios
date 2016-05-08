//
//  NSObject+JKKVCExtension.m
//  JKRunTimeDemo
//
//  Created by emerys on 16/5/7.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import "NSObject+JKKVCExtension.h"
#import <objc/runtime.h>

@implementation NSObject (JKKVCExtension)

+ (id)jk_objectWithDictionary:(NSDictionary *)dictionary{
    Class cls = [self class];
    id object = [[cls alloc] init];
    
    unsigned int count;
//    Ivar *ivars = class_copyIvarList([object class], &count);
    
    objc_property_t *properties = class_copyPropertyList([object class], &count);
    
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        
        // 属性名称
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        
        NSString *propertyAttribute = [NSString stringWithUTF8String:property_getAttributes(property)]; // T@"NSString",C,N,V_name
        // 解析属性类型
        NSString *tmpType = [[propertyAttribute componentsSeparatedByString:@","] firstObject];
        NSInteger len = tmpType.length;
        NSString *propertyType = [tmpType substringWithRange:NSMakeRange(3, len - 4)];
       
        id value = [dictionary objectForKey:propertyName];
        // 字典
        if ([value isKindOfClass:[NSDictionary class]]) {
            Class modelClass = NSClassFromString(propertyType);
            
            value = [modelClass jk_objectWithDictionary:value];
        }
        
        // 数组
        if ([value isKindOfClass:[NSArray class]]) {
            NSArray *array = (NSArray *)value;
            NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:[array count]];
            for (int j = 0; j < array.count; j++) {
                id obj = array[j];
                if ([obj isKindOfClass:[NSDictionary class]]) {
                    Class modelClass = NSClassFromString(propertyType);
                    
                    obj = [modelClass jk_objectWithDictionary:value];
                }
                [mArray addObject:obj];
            }
            value = mArray;
        }
        
        [object setValue:value forKey:propertyName];
    }
    
    return object;
}


@end
