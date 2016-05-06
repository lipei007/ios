//
//  ViewController.m
//  视图动画
//
//  Created by Emerys on 7/31/15.
//  Copyright (c) 2015 Emerys. All rights reserved.
//

#import "ViewController.h"
#import "Circle.h"
#import <QuartzCore/QuartzCore.h>
#import "needDelegate.h"

@interface ViewController ()



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /******************图层直接在content属性绘制******************************/
    UIImage *img = [UIImage imageNamed:@"ball.jpeg"];
    
        //缩放比例匹配屏幕    
        //  缩小同等比例－－－contentsScale
    self.view.layer.contentsScale = [[UIScreen mainScreen] scale];
        //绘制在中央
    self.view.layer.contentsGravity = kCAGravityCenter;
        //以上两行代码要同时使用才能将图像缩放并置于指定位置。
    NSLog(@"----%f",[[UIScreen mainScreen] scale]);
    
    self.view.layer.contents = (id)[img CGImage];
    
    
    
    Circle *circle = [Circle sharedCircle];
    circle.frame = CGRectMake(0, 0, 20, 20);
    circle.center = CGPointMake(100, 20);
    circle.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:circle];
    
    UITapGestureRecognizer *g;
    g = [[UITapGestureRecognizer alloc] 
         initWithTarget:self 
         action:@selector(dropAnimate:)];
    
        //[self.view addGestureRecognizer:g];//点击屏幕任何位置都能响应
    [circle addGestureRecognizer:g];//点击circle所在位置才会响应
    
    
    
//    needDelegate *nd = [[needDelegate alloc] initWithFrame:self.view.bounds];
//        //nd.frame = self.view.bounds;
//    
//    
//    [self.view addSubview:nd];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

    //管理用户交互
-(void)dropAnimate:(UITapGestureRecognizer *)recongnizer{

    Circle *circle = [Circle sharedCircle];
//    [UIView animateWithDuration:3 animations:^{
//        
//        circle.center = CGPointMake(100, 300);
//    }];
    
    
    [UIView animateWithDuration:3 animations:^{
        circle.center = CGPointMake(100, 300);
        recongnizer.enabled = NO;//动画执行过程中不可点击,即点击无响应
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 animations:^{
            circle.center = CGPointMake(250, 300);
        }completion:^(BOOL finished) {
            recongnizer.enabled = YES;
        }];
    }];
}

@end
