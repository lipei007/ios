//
//  ViewController.m
//  图形绘制
//
//  Created by Emerys on 7/30/15.
//  Copyright (c) 2015 Emerys. All rights reserved.
//

#import "ViewController.h"
#import "MyView.h"
#import "DrawView.h"
#import "TestView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    MyView *myview = [[MyView alloc] init];
//    myview.frame = self.view.bounds;
//    myview.backgroundColor = [UIColor whiteColor];
//    
//    [self.view addSubview:myview];
    
    
    NSUInteger w = self.view.frame.size.width;
    NSUInteger h = self.view.frame.size.height;
//    NSLog(@"%lu",w);
//    
//    UIView *tab = [[UIView alloc] initWithFrame:CGRectMake(0, 20, w, 20)];
//        //tab.backgroundColor = [UIColor purpleColor];
//    
//    DrawView *dw = [[DrawView alloc] init];
//    dw.frame = CGRectMake(0, 40, w, h-40);
//    dw.backgroundColor = [UIColor grayColor];
//    
//    [self.view addSubview:tab];
//    [self.view addSubview:dw];
    
    TestView *tv = [[TestView alloc] initWithFrame:CGRectMake(0, 20, w, h)];
    [self.view addSubview:tv];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
