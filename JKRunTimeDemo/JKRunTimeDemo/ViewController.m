//
//  ViewController.m
//  JKRunTimeDemo
//
//  Created by emerys on 16/5/7.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import "ViewController.h"
#import "DynamicChangeIvar.h"
#import "addPropertyAndMethod.h"
#import "exchangeMethod.h"
#import "replaceMethod.h"
#import "JKPerson.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 动态变量控制
    DynamicChangeIvar *dci = [[DynamicChangeIvar alloc] init];
    [dci change];
    
    // 动态增加方法
    addPropertyAndMethod *add = [addPropertyAndMethod new];
    [add addMethod];
    
    // 增加乘员变量
    [add addIVar];
    
    // 动态添加属性
    [add addProperty];
    
    // 交换方法实现
    exchangeMethod *cm = [exchangeMethod new];
    [cm dynamicExchangeMethod];
    
    // 拦截并替换方法
    replaceMethod *re = [replaceMethod new];
    [re replace];
    JKPerson *p = [[JKPerson alloc] init];
    [p scold:@"biu,gan"];
    
    // 自动归解档
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *path = [documents stringByAppendingString:@"/archive.plist"];
    // 归档
//    [NSKeyedArchiver archiveRootObject:p toFile:path];
    
    // 解档
    JKPerson *p1 = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSLog(@"decode:%@",p1);
    
    // 字典转模型
    NSDictionary *dic = @{@"name" : @"wang",@"age" : @(12)};
    JKPerson *p2 = [JKPerson jk_objectWithDictionary:dic];
    NSLog(@"%@",p2);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
