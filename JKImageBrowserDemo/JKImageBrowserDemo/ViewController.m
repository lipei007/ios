//
//  ViewController.m
//  JKImageBrowserDemo
//
//  Created by emerys on 16/5/10.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import "ViewController.h"
#import "JKImageBrowserViewController.h"

@interface ViewController ()<UIScrollViewDelegate>
{
    UIButton *iv;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImage *img = [UIImage imageNamed:@"002.jpeg"];
    iv = [UIButton buttonWithType:UIButtonTypeCustom];
    [iv setBackgroundImage:img forState:UIControlStateNormal];
    iv.frame = CGRectMake(100, 500, 250, 170);
    iv.backgroundColor = [UIColor redColor];
    [self.view addSubview:iv];
    [iv addTarget:self action:@selector(scanImage:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
}

- (NSArray *)loadImages {
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 1; i <= 6; i++) {
        NSString *imgName = [NSString stringWithFormat:@"00%d.jpeg",i];
        [arr addObject:[UIImage imageNamed:imgName]];
    }
    return arr;
}

- (void)scanImage:(UIButton *)sender {
    
    JKImageCache *cache = [[JKImageCache alloc] init];
    cache.images = [self loadImages];
    JKImageBrowserViewController *vc = [[JKImageBrowserViewController alloc] initWithFrame:self.view.bounds imageCache:cache];
    vc.imageContainer = sender;
    vc.touchedImageIndex = 1;
    
    [vc show];
}


@end
