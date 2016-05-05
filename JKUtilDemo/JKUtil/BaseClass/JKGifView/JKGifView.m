//
//  JKGifView.m
//  gifView
//
//  Created by emerys on 16/3/25.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import "JKGifView.h"
#import <CoreGraphics/CoreGraphics.h>

@implementation JKGifView

- (id)initWithFrame:(CGRect)frame filePath:(NSString *)_filePath{
    self = [super initWithFrame:frame];
    if (self) {
        gifProperties = [[NSDictionary dictionaryWithObject:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCGImagePropertyGIFLoopCount]
                                                     forKey:(NSString *)kCGImagePropertyGIFDictionary] retain];
        gif = CGImageSourceCreateWithURL((CFURLRef)[NSURL fileURLWithPath:_filePath], (CFDictionaryRef)gifProperties);
        count =CGImageSourceGetCount(gif);
        timer = [NSTimer scheduledTimerWithTimeInterval:0.04 target:self selector:@selector(play) userInfo:nil repeats:YES];
        [timer fire];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame data:(NSData *)_data{
    self = [super initWithFrame:frame];
    if (self) {
        gifProperties = [[NSDictionary dictionaryWithObject:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCGImagePropertyGIFLoopCount]
                                                     forKey:(NSString *)kCGImagePropertyGIFDictionary] retain];
        gif = CGImageSourceCreateWithData((CFDataRef)_data, (CFDictionaryRef)gifProperties);
        count =CGImageSourceGetCount(gif);
        timer = [NSTimer scheduledTimerWithTimeInterval:0.04 target:self selector:@selector(play) userInfo:nil repeats:YES];
        [timer fire];
    }
    return self;
}
-(void)play
{
    index ++;
    index = index%count;
    CGImageRef ref = CGImageSourceCreateImageAtIndex(gif, index, (CFDictionaryRef)gifProperties);
    self.layer.contents = (__bridge id)ref;
    CFRelease(ref);
}
-(void)removeFromSuperview
{
    NSLog(@"removeFromSuperview");
    [timer invalidate];
    timer = nil;
    [super removeFromSuperview];
}
- (void)dealloc {
    NSLog(@"dealloc");
    CFRelease(gif);
    [gifProperties release];
    [super dealloc];
}

@end
