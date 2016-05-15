//
//  JKImageBrowserRootView.m
//  JKImageBrowserDemo
//
//  Created by emerys on 16/5/10.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import "JKImageBrowserRootView.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"


@interface JKImageBrowserRootView ()<UIScrollViewDelegate,UIActionSheetDelegate>

@property (nonatomic,strong) NSArray *images;
@property (nonatomic,strong) UIImage *operationButtonImage;
@property (nonatomic,strong) UILabel *indexLabel;
@property (nonatomic,strong) UIButton *operationButton;
@property (nonatomic,strong) UIScrollView *contentScrollView;
@property (nonatomic,assign) NSUInteger currentImageIndex;


@end

@implementation JKImageBrowserRootView

+ (instancetype)browserRootViewWithFrame:(CGRect)frame images:(NSArray *)source currentImageIndex:(NSInteger)index operationButtonImage:(UIImage *)image {
    JKImageBrowserRootView *rootView = [[JKImageBrowserRootView alloc] initWithFrame:frame];
    rootView.operationButtonImage = image;
    rootView.images = source;
    rootView.currentImageIndex = index;
    [rootView setupUserInterface];
    
    return rootView;
}

- (void)setupUserInterface {
    [self addSubview:self.contentScrollView];
    [self addSubview:self.indexLabel];
    [self addSubview:self.operationButton];
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self updateIndex];
    self.indexLabel.frame = CGRectMake((self.bounds.size.width - 100) / 2, 40, 100, 20);
    
    self.operationButton.frame = CGRectMake(self.bounds.size.width - 70, self.bounds.size.height - 70, 50, 50);
}

- (UILabel *)indexLabel {
    if (!_indexLabel) {
        _indexLabel = [[UILabel alloc] init];
        _indexLabel.textAlignment = NSTextAlignmentCenter;
        _indexLabel.textColor = [UIColor whiteColor];
        _indexLabel.font = [UIFont systemFontOfSize:15.0f];
        _indexLabel.backgroundColor = [UIColor clearColor];
    }
    return _indexLabel;
}

- (UIButton *)operationButton {
    if (!_operationButton) {
        _operationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _operationButton.backgroundColor = [UIColor clearColor];
        [_operationButton addTarget:self action:@selector(operationButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        if (self.operationButtonImage) {
            [_operationButton setImage:self.operationButtonImage forState:UIControlStateNormal];
            [_operationButton setImage:self.operationButtonImage forState:UIControlStateHighlighted];
        } else {
            [_operationButton setTitle:@"选择" forState:UIControlStateNormal];
            [_operationButton setTitle:@"选择" forState:UIControlStateHighlighted];
            [_operationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_operationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
            _operationButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        }
    }
    return _operationButton;
}

- (UIScrollView *)contentScrollView {
    if (!_contentScrollView) {
        _contentScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _contentScrollView.showsVerticalScrollIndicator = NO;
        _contentScrollView.showsHorizontalScrollIndicator = NO;
        _contentScrollView.pagingEnabled = YES;
        _contentScrollView.contentSize = CGSizeMake(self.bounds.size.width * self.images.count, self.bounds.size.height);
        _contentScrollView.delegate = self;
        
        for (int i = 0; i < self.images.count; i++) {
            UIImage *img = [self.images objectAtIndex:i];
            JKImageBrowser *browser = [JKImageBrowser browserWithFrame:CGRectMake(self.bounds.size.width * i, 0, self.bounds.size.width, self.bounds.size.height) image:img];
            [_contentScrollView addSubview:browser];
        }
     
        _contentScrollView.contentOffset = CGPointMake(self.bounds.size.width * self.currentImageIndex, 0);
       
       
    }
    
    return _contentScrollView;
}

- (void)updateIndex {
    self.indexLabel.text = [NSString stringWithFormat:@"%li/%li",self.currentImageIndex + 1,self.images.count];
}

- (void)scaleAnimationToHideWithStartIndex:(NSInteger)index {
    JKImageBrowser *browser = [self.contentScrollView.subviews objectAtIndex:self.currentImageIndex];
    browser.imageContainer = self.imageContainer;
    browser.hideBlock = self.hideBlock;
    [browser hideWithCenterScaleAnimation:index != self.currentImageIndex];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / self.bounds.size.width;
    self.currentImageIndex = index;
    [self updateIndex];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    for (JKImageBrowser *browser in scrollView.subviews) {
        if (browser.zooming) {
            [browser clearZoomState];
        }
    }
}

#pragma mark - buttonClick

- (void)operationButtonClicked:(UIButton *)sender{
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"保存到相册", nil];
    sheet.delegate = self;
    
    [sheet showInView:self];
    
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"actionSheet click %li",buttonIndex);
}

- (void)actionSheetCancel:(UIActionSheet *)actionSheet{
    NSLog(@"actionSheet cancel");
}

#pragma clang diagnostic pop

@end
