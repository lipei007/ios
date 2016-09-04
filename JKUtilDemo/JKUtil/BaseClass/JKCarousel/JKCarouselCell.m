//
//  JKCarouselCell.m
//  Carousel
//
//  Created by emerys on 16/9/4.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import "JKCarouselCell.h"

@implementation JKCarouselCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.imageContainer];
    }
    return self;
}


- (UIImageView *)imageContainer {
    if (!_imageContainer) {
        _imageContainer = [[UIImageView alloc] initWithFrame:self.bounds];
//        [_imageContainer addTarget:self action:@selector(imageClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        _imageContainer.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClicked:)];
        [_imageContainer addGestureRecognizer:tap];
        
    }
    return _imageContainer;
}

- (void)setContent:(UIImage *)content {
    _content = content;
//    [self.imageContainer setBackgroundImage:content forState:UIControlStateNormal];
//    [self.imageContainer setBackgroundImage:content forState:UIControlStateHighlighted];
    self.imageContainer.image = content;
}

- (void)imageClicked:(id)sender {
    if (self.clickBlock) {
        self.clickBlock(self.contentIndex);
    }
    
}

@end
