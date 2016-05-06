//
//  ViewController.m
//  UIKit绘图
//
//  Created by Emerys on 15/7/25.
//  Copyright (c) 2015年 Emerys. All rights reserved.
//

#import "ViewController.h"
#import "MyUIview.h"
#import "GraphicView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    
    MyUIview *myView = [[MyUIview alloc] initWithFrame:CGRectMake(0, 0, 400, 800)];
    myView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:myView];
//
//    GraphicView *gv = [[GraphicView alloc] init];
//    gv.frame = self.view.bounds;
//    gv.backgroundColor = [UIColor whiteColor];
//    
//    [gv awakeFromNib];
//    [self.view addSubview:gv];
    


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
