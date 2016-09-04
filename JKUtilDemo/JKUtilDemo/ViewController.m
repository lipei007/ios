//
//  ViewController.m
//  JKUtilDemo
//
//  Created by emerys on 16/4/20.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import "ViewController.h"
#import "JKUtil.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor purpleColor];
    
    JKCacheSlider *cacheSlider = [JKCacheSlider cacheSliderWithFrame:CGRectMake(0, 100, JK_ScreenWidth, 10)];
    cacheSlider.cacheValue = 0.5;
    
    [self.view addSubview:cacheSlider];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
//    JKMoviePlayerPortraitViewController *player = [[JKMoviePlayerPortraitViewController alloc] init];
//    
//    [self presentViewController:player animated:YES completion:nil];
    
    [self.view jk_imageWithSavePath:@"/Users/emerys/Documents/img/shot.png"];
}

@end
