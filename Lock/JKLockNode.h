//
//  LXYLockNode.h
//  Lock
//
//  Created by emerys on 15/8/28.
//  Copyright (c) 2015年 Emerys. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    JKLockNodeStatusNormal,
    JKLockNodeStatusSelected,
    JKLockNodeStatusWarning
} JKLockNodeStatus;

@interface JKLockNode : UIView

@property (nonatomic,assign) JKLockNodeStatus status;

@end
