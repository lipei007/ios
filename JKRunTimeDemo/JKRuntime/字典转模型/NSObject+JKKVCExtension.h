//
//  NSObject+JKKVCExtension.h
//  JKRunTimeDemo
//
//  Created by emerys on 16/5/7.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (JKKVCExtension)
/**
 *  @author Jack Lee, 16-05-07 23:05:21
 *
 *  @brief 字典转模型
 *  @param dictionary 待转的字典数据
 *
 *  @return 模型实例对象
 */
+ (id)jk_objectWithDictionary:(NSDictionary *)dictionary;

@end
