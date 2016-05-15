//
//  ViewController.m
//  JKScrollInsetZoom
//
//  Created by emerys on 16/5/15.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic,strong) UIView *contentView;

@property (nonatomic,strong) UILabel *zoomLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.zoomLabel];
    [self.view addSubview:self.scrollView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height + 1);
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
     
        [_scrollView addSubview:self.contentView];
    }
    return _scrollView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:self.view.bounds];
        _contentView.backgroundColor = [UIColor redColor];
    }
    return _contentView;
}

- (UILabel *)zoomLabel {
    if (!_zoomLabel) {
        _zoomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 0)];
        _zoomLabel.textAlignment = NSTextAlignmentCenter;
        _zoomLabel.font = [UIFont systemFontOfSize:11.0f];
        _zoomLabel.text = @"Z";
    }
    return _zoomLabel;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    NSLog(@"%f",offset.y);
    
    if (offset.y < 0) {
        self.zoomLabel.frame = CGRectMake(0, 0, self.view.bounds.size.width, fabs(offset.y));
        self.zoomLabel.font = [UIFont systemFontOfSize:11.0f + fabs(offset.y)];
    }
    
    
}

@end
