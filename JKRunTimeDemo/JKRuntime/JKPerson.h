//
//  JKPerson.h
//  JKRunTimeDemo
//
//  Created by emerys on 16/5/7.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+JKCoder.h"
#import "NSObject+JKKVCExtension.h"

@interface JKPerson : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign) NSNumber *age;

- (void)scold:(NSString *)msg;

@end
