//
//  NSArray+sortArray.m
//  图形绘制
//
//  Created by Emerys on 7/31/15.
//  Copyright (c) 2015 Emerys. All rights reserved.
//

#import "NSArray+sortArray.h"

@implementation NSArray (sortArray)


-(NSArray *)arraySort{
    
    NSMutableArray *ma = [NSMutableArray arrayWithArray:self];
    
    for (NSInteger i = 1; i < ma.count; i++) {
        for (NSInteger j = 0; j < ma.count - i; j++) {
            
            NSString *front = [ma objectAtIndex:j];
            NSString *back = [ma objectAtIndex:j+1];
            
            if ([front integerValue] > [back integerValue]) {
                [ma exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
    }
    
    return ma;
    
}

@end
