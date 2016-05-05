//
//  LXYSetPassWord.m
//  Lock
//
//  Created by emerys on 15/8/31.
//  Copyright (c) 2015年 Emerys. All rights reserved.
//

#import "JKSetPassWord.h"

@interface JKSetPassWord ()

@property (nonatomic,copy) NSString *firstPassWord;

@property (nonatomic,copy) NSString *tip;

@property (nonatomic,strong) UILabel *label;

@end

@implementation JKSetPassWord

-(JKLockBoardStatus)handlePassWord:(NSString *)password{
    JKLockBoardStatus result;
    if (!self.firstPassWord) {
        self.firstPassWord = password;
        self.tip = @"请再次输入以确认口令";
        result = JKLockBoardStatusSelected;
    }else{
        if ([self.firstPassWord isEqualToString:password]) {
            NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
            [userInfo setObject:password forKey:@"password"];
            result = JKLockBoardStatusSelected;
            self.tip = @"口令设置成功";
            [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.0f];
        }
        else{
            self.tip = @"与上次输入的口令不匹配,请重新输入";
            result = JKLockBoardStatusWarning;
        }
    }
    return result;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
        self.tip = @"请设置您的口令";
        
        self.label = [[UILabel alloc] init];
        self.label.text = self.tip;
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.textColor = [UIColor whiteColor];
        self.label.frame = CGRectMake(0.125 * self.bounds.size.width,
                                 0.1 * 0.8 * self.bounds.size.height,
                                 0.75 * self.bounds.size.width,
                                 0.05 * self.bounds.size.height);
        [self addSubview:self.label];
        
        CGRect rect = self.frame;
        rect.origin.y = rect.size.height * 0.3;
        rect.size.height = rect.size.height * 0.7;
        JKLockBoard *board = [[JKLockBoard alloc] initWithFrame:rect];
        board.delegate = self;
        [self addSubview:board];
    }
    return self;
}

-(void)setTip:(NSString *)tip{
    _tip = tip;
    self.label.text = _tip;
}

-(void)dismiss{
    [self removeFromSuperview];
}

@end
