//
//  UIScrollView+JKContentImage.h
//  JKCarouselDemo
//
//  Created by emerys on 16/5/17.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (JKContentImage)

- (UIImage *)jk_contentImage;

- (UIImage *)jk_contentImageWithSavePath:(NSString *)savePath;

@end
