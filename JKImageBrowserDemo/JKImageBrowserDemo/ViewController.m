//
//  ViewController.m
//  JKImageBrowserDemo
//
//  Created by emerys on 16/5/10.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import "ViewController.h"
#import "JKImageBrowserViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    JKImageBrowserViewController *vc = [[JKImageBrowserViewController alloc] init];
    JKImageCache *cache = [[JKImageCache alloc] init];
    cache.images = [self loadImages];
    vc.imageCache = cache;
    
    [self presentViewController:vc animated:YES completion:nil];
}

- (NSArray *)loadImages {
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 1; i <= 6; i++) {
        NSString *imgName = [NSString stringWithFormat:@"00%d.jpeg",i];
        [arr addObject:[UIImage imageNamed:imgName]];
    }
    return arr;
}


@end
