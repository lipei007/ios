//
//  JKImageBrowserViewController.m
//  JKImageBrowserDemo
//
//  Created by emerys on 16/5/10.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import "JKImageBrowserViewController.h"
#import "JKImageBrowserRootView.h"


@interface JKImageBrowserViewController ()

@property (nonatomic,strong) JKImageBrowserRootView *rootView;///<根视图


@end

@implementation JKImageBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUserInterFace];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (JKImageBrowserRootView *)rootView {
    if (!_rootView) {
        _rootView = [JKImageBrowserRootView browserRootViewWithFrame:self.view.bounds images:self.imageCache.images operationButtonImage:nil];
    }
    return _rootView;
}

- (void)setupUserInterFace {
    [self.view addSubview:self.rootView];
}

@end
