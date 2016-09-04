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
#import "UIScrollView+JKContentImage.h"


#define w ([UIScreen mainScreen].bounds.size.width)

@interface ViewController ()
{
    JKCarouselView *carouselView;
}
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
    
    carouselView = [JKCarouselView carouselWithFrame:CGRectMake(0, 50, w, 200) duration:8.0 contents:marray withTapAction:^(UIImage *img){
        NSLog(@"img:%li",[marray indexOfObject:img]);
    }];
    carouselView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:carouselView];
    carouselView.showsPageIndicator = YES;
    [carouselView scroll];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    UIImage *img = [carouselView.carousel jk_contentImageWithSavePath:@"/Users/emerys/Documents/img/s.png"];
    if (img) {
        NSData *data = UIImagePNGRepresentation(img);
        [data writeToFile:@"/Users/emerys/Documents/img/shot.png" atomically:NO];
    } else {
        NSLog(@"error");
    }
}

@end
