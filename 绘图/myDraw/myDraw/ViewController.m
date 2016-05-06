//
//  ViewController.m
//  myDraw
//
//  Created by Emerys on 7/31/15.
//  Copyright (c) 2015 Emerys. All rights reserved.
//

#import "ViewController.h"
#import "DrawImage.h"
#import "DrawPath.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    DrawImage *di = [[DrawImage alloc] init];
    di.frame = CGRectMake(0, 50, 100, 100);
    di.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:di];
    
//    DrawPath *dp = [[DrawPath alloc] initWithFrame:self.view.bounds];
//    dp.backgroundColor = [UIColor whiteColor];
//    
//    [self.view addSubview:dp];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
