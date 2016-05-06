//
//  MusicListViewController.m
//  音乐播放器
//
//  Created by emerys on 15/9/11.
//  Copyright (c) 2015年 Emerys. All rights reserved.
//

#import "MusicListViewController.h"

#define WIDTH self.view.bounds.size.width

@interface MusicListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSArray *_data;
}
@end

@implementation MusicListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backImageView.image = [UIImage imageNamed:@"sidebar_bg.jpg"];
    [self.view addSubview:backImageView];
    CGRect frame = self.view.bounds;
//    frame.origin.x = frame.size.width;
    frame.origin.y += 20;
    frame.size.height -= 20;
    
    _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_tableView];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 20)];
    btn.backgroundColor = [UIColor grayColor];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [_tableView setTableHeaderView:btn];
    [btn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)viewDidAppear:(BOOL)animated{
//    
//    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:NO];
//    [UIView animateWithDuration:1.0f animations:^{
//        CGRect frame = _tableView.frame;
//        frame.origin.x = 0;
//        _tableView.frame = frame;
//    }];
//    [super viewDidAppear:animated];
//
//}

-(void)setData:(NSArray *)data{
    _data = data;
    [_tableView reloadData];
}

-(void)goBack:(UIButton *)sender{
    CGRect frame = self.view.frame;
    frame.origin.x = WIDTH;
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:NO];
    [UIView animateWithDuration:1.0f animations:^{
        self.view.frame = frame;
    } completion:^(BOOL finished) {
//        NSNotification *notification = [NSNotification notificationWithName:@"showView" object:nil userInfo:nil];
//        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }];

}

#pragma mark - 数据源

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:@"cell"];
    }
    NSRange range = [_data[indexPath.row] rangeOfString:@"- "];
    cell.textLabel.text = [_data[indexPath.row] substringFromIndex:range.location + 1];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.bounds];
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.7];
    return cell;
}

#pragma mark - 代理回调
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.playSong(_data[indexPath.row]);
}

-(BOOL)prefersStatusBarHidden{
    return NO;
}

@end
