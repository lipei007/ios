//
//  JKTimer.m
//  JKUtilDemo
//
//  Created by Jack on 8/1/16.
//  Copyright © 2016 Emerys. All rights reserved.
//

#import "JKTimerManager.h"

@interface JKTimerManager ()

@property (nonatomic,strong) NSMutableDictionary *timerContainer;

@end

@implementation JKTimerManager

+ (instancetype)sharedTimerManager {
    static JKTimerManager *manager = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        manager = [[JKTimerManager alloc] init];
    });
    
    return manager;
}

- (NSMutableDictionary *)timerContainer {
    if (!_timerContainer) {
        _timerContainer = [NSMutableDictionary dictionary];
    }
    return _timerContainer;
}

- (void)scheduledDispatchTimerWithName:(NSString *)name
                          timeInterval:(NSTimeInterval)timerInterval
                                 queue:(dispatch_queue_t)queue
                               repeats:(BOOL)repeats
                                action:(dispatch_block_t)action {
    if (name == nil)
        return;
    if (queue == nil)
        queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t timer = [self.timerContainer objectForKey:name];
    if (!timer) {
        timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_resume(timer);
        [self.timerContainer setObject:timer forKey:name];
    }
    
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, timerInterval * NSEC_PER_SEC), timerInterval * NSEC_PER_SEC, 0.1 * NSEC_PER_SEC);
    __weak typeof(self) weakSelf = self;
    dispatch_source_set_event_handler(timer, ^{
        if (action) {
            action();
            if (!repeats) {
                [weakSelf cancelTimerWithName:name];
            }
        }
    });
    
}

- (void)cancelTimerWithName:(NSString *)name {
    dispatch_source_t timer = [self.timerContainer objectForKey:name];
    if (!timer) {
        return;
    }
    
    [self.timerContainer removeObjectForKey:name];
    dispatch_source_cancel(timer);
}

- (void)cancelAllTimer {
    for (NSString *name in self.timerContainer.allKeys) {
        [self cancelTimerWithName:name];
    }
}

@end
