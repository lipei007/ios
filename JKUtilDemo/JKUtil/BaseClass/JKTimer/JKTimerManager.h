//
//  JKTimer.h
//  JKUtilDemo
//
//  Created by Jack on 8/1/16.
//  Copyright © 2016 Emerys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JKTimerManager : NSObject

+ (instancetype)sharedTimerManager;

/**
 *  启动一个timer，默认精度为0.1秒
 *
 *  @param name          timer的名称，作为唯一标识
 *  @param timerInterval 执行的时间间隔
 *  @param queue         timer将被放入的队列，也就是最终action执行的队列。传入nil将自动放到一个子线程队列中
 *  @param repeats       timer是否循环调用
 *  @param action        时间间隔到点时执行的block
 */
- (void)scheduledDispatchTimerWithName:(NSString *)name timeInterval:(NSTimeInterval)timerInterval queue:(dispatch_queue_t)queue repeats:(BOOL)repeats action:(dispatch_block_t)action;

/**
 *  撤销某个timer
 *
 *  @param name timer的名称，唯一标识
 */
- (void)cancelTimerWithName:(NSString *)name;

/**
 *  撤销所有timer 
 */
- (void)cancelAllTimer;

@end
