//
//  ViewController.m
//  JKCheckDeviceDemo
//
//  Created by emerys on 16/5/8.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import "ViewController.h"
#import "UIDevice+JKCheckDeviece.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    BOOL available = [UIDevice cameraAvailable];
    if (available) {
        printf("yes\n");
    } else {
        printf("no\n");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
