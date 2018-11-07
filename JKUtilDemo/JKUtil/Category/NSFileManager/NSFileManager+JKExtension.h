//
//  NSFileManager+JKExtension.h
//  JKUtilDemo
//
//  Created by Jack on 2018/11/6.
//  Copyright © 2018年 Emerys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (JKExtension)

- (void)jk_move:(NSString *)src to:(NSString *)dest;

@end
