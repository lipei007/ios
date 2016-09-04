//
//  JKCarouselCell.h
//  Carousel
//
//  Created by emerys on 16/9/4.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKCommon.h"

#define CELLIdentifier @"carouselCell"

typedef void(^imageContainerClickBlock)(NSInteger idex);

@interface JKCarouselCell : UICollectionViewCell


@property (nonatomic,strong) UIImageView *imageContainer;

@property (nonatomic,strong) UIImage *content;
@property (nonatomic,assign) NSInteger contentIndex;


@property (nonatomic,copy) imageContainerClickBlock clickBlock;


@end
