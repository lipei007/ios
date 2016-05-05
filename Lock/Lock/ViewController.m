//
//  ViewController.m
//  Lock
//
//  Created by emerys on 15/8/28.
//  Copyright (c) 2015年 Emerys. All rights reserved.
//

#import "ViewController.h"
#import "JKSetPassWord.h"
#import "JKVerifiedPassWord.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    
    UIButton *set = [[UIButton alloc] init];
    set.frame = CGRectMake(100, 175, 80, 30);
    [set setTitle:@"设置密码" forState:UIControlStateNormal];
    [set setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [set addTarget:self action:@selector(set:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:set];
    
    UIButton *veritify = [[UIButton alloc] init];
    veritify.frame = CGRectMake(200, 175, 80, 30);
    [veritify setTitle:@"解锁" forState:UIControlStateNormal];
    [veritify setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [veritify addTarget:self action:@selector(veritify:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:veritify];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)set:(UIButton *)sender{
    JKSetPassWord *setPassWord = [[JKSetPassWord alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:setPassWord];
}

-(void)veritify:(UIButton *)sender{
    JKVerifiedPassWord *veri = [[JKVerifiedPassWord alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:veri];
}

@end
