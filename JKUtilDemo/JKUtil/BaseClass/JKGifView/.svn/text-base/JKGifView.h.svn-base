//
//  JKGifView.h
//  gifView
//
//  Created by emerys on 16/3/25.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ImageIO/ImageIO.h>

@interface JKGifView : UIView
{
    CGImageSourceRef gif;
    NSDictionary *gifProperties;
    size_t index;
    size_t count;
    NSTimer *timer;
}
- (id)initWithFrame:(CGRect)frame filePath:(NSString *)_filePath;
- (id)initWithFrame:(CGRect)frame data:(NSData *)_data;

@end
