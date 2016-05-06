//
//  ViewController.m
//  waterWaveDemo
//
//  Created by emerys on 15/10/22.
//  Copyright © 2015年 Emerys. All rights reserved.
//

#import "ViewController.h"
#import "waterView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

    self.view.backgroundColor = [UIColor colorWithRed:22 / 255.0 green:163 / 255.0 blue:130 / 255.0 alpha:1];
    waterView *water = [[waterView alloc] initWithFrame:CGRectMake(0, 0, 131, 131)];
    water.backgroundColor = [UIColor clearColor];
    water.center = self.view.center;
    [self.view addSubview:water];
    
    [water beginAnimation];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
