//
//  UIImage+GIF.m
//  JKText
//
//  Created by emerys on 16/4/19.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import "UIImage+GIF.h"
#import <ImageIO/ImageIO.h>

@implementation UIImage (GIF)

+ (instancetype)gifImageWithData:(NSData *)data{
    if (!data) {
        return nil;
    }
    UIImage *gifImage;
    
    CGImageSourceRef sourceRef = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    
    NSInteger count = CGImageSourceGetCount(sourceRef);
    
    if (count <= 1) { // 只有一帧
        gifImage = [[UIImage alloc] initWithData:data];
    } else {
        // 数组用于存放图片
        NSMutableArray *images = [NSMutableArray array];
        // GIF持续时间
        NSTimeInterval duration = 0.0f;
        
        for (int i = 0; i < count; i++) {
            // 获取第i帧图片
            CGImageRef image = CGImageSourceCreateImageAtIndex(sourceRef, i, NULL);
            // 时间加上当前帧的持续时间
            duration += [self frameDurationAtIndex:i source:sourceRef];
            
            [images addObject:[UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]];
            
            CGImageRelease(image);
        }
        
        if (!duration) {
            duration = 0.1f * count;
        }
        
        gifImage = [UIImage animatedImageWithImages:images duration:duration];
    }
    
    return gifImage;
}
/**
 *  @author Jack Lee, 16-04-19 16:04:04
 *
 *  @brief 获取图片帧的持续时间
 *
 *  @param index  帧所在索引
 *  @param source 图片源
 *
 *  @return 帧的持续时间
 */
+ (float)frameDurationAtIndex:(NSUInteger)index source:(CGImageSourceRef)source {
    float frameDuration = 0.1f;
    CFDictionaryRef cfFrameProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil);
    NSDictionary *frameProperties = (__bridge NSDictionary *)cfFrameProperties;
    NSDictionary *gifProperties = frameProperties[(NSString *)kCGImagePropertyGIFDictionary];
    
    NSNumber *delayTimeUnclampedProp = gifProperties[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
    if (delayTimeUnclampedProp) {
        frameDuration = [delayTimeUnclampedProp floatValue];
    }
    else {
        
        NSNumber *delayTimeProp = gifProperties[(NSString *)kCGImagePropertyGIFDelayTime];
        if (delayTimeProp) {
            frameDuration = [delayTimeProp floatValue];
        }
    }
    
    if (frameDuration < 0.011f) {
        frameDuration = 0.100f;
    }
    
    CFRelease(cfFrameProperties);
    return frameDuration;
}

@end
