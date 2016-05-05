//
//  JKShapeImage.h
//  mask
//
//  Created by emerys on 16/3/15.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,BubbleDirection) {
    BubbleDirectionLeft,
    BubbleDirectionRight
};

@interface JKShapeImage : UIView

@property (nonatomic,strong) UIImage *image;

@property (nonatomic,assign) BubbleDirection direction;

@end
