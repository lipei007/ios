//
//  LXYVerifiedPassWord.m
//  Lock
//
//  Created by emerys on 15/8/31.
//  Copyright (c) 2015年 Emerys. All rights reserved.
//

#import "JKVerifiedPassWord.h"

@interface JKVerifiedPassWord ()

@property (nonatomic,copy) NSString *tip;
@property (nonatomic,strong) UILabel *label;

@end

@implementation JKVerifiedPassWord

-(JKLockBoardStatus)handlePassWord:(NSString *)password{
    JKLockBoardStatus result;
    NSString *savedPassWord = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    if (!savedPassWord) {
        self.tip = @"对不起,您没有设置密码,请返回设置";
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.0f];
    }else{
        if ([savedPassWord isEqualToString:password]) {
            result = JKLockBoardStatusSelected;
            self.tip = @"恭喜您,输入正确";
            [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.0f];
        }else{
            result = JKLockBoardStatusWarning;
            self.tip = @"很遗憾,请重新再来";
        }
    }
    return result;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
        self.tip = @"请输入您的口令";
        
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
