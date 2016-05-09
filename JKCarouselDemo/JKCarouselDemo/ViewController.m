//
//  ViewController.m
//  JKCarouselDemo
//
//  Created by emerys on 16/5/9.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import "ViewController.h"
#import "JKCarouselScrollView.h"
#import "JKCarouselView.h"

#define w ([UIScreen mainScreen].bounds.size.width)

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSMutableArray<UIImage *> *marray = [NSMutableArray arrayWithCapacity:5];
    for (int i = 0; i < 5; i++) {
        NSString *imgName = [NSString stringWithFormat:@"00%d.jpeg",i + 1];
        UIImage *img = [UIImage imageNamed:imgName];
        [marray addObject:img];
    }
    
    JKCarouselView *carousel = [JKCarouselView carouselWithFrame:CGRectMake(0, 50, w, 200) duration:8.0 contents:marray withTapAction:^(UIImage *img){
        NSLog(@"img:%li",[marray indexOfObject:img]);
    }];
    carousel.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:carousel];
    carousel.showsPageIndicator = YES;
    [carousel scroll];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
