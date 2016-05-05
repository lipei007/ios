//
//  LXYLockBoard.h
//  Lock
//
//  Created by emerys on 15/8/29.
//  Copyright (c) 2015年 Emerys. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    JKLockBoardStatusNormal,
    JKLockBoardStatusSelected,
    JKLockBoardStatusWarning
} JKLockBoardStatus;
@protocol JKLockBoardDelegate;

@interface JKLockBoard : UIView

@property (nonatomic,assign) JKLockBoardStatus status;
@property (nonatomic,strong) id<JKLockBoardDelegate> delegate;

@end

@protocol JKLockBoardDelegate <NSObject>

-(JKLockBoardStatus)handlePassWord:(NSString *)password;

@end
