//
//  UIScrollView+JKContentImage.m
//  JKCarouselDemo
//
//  Created by emerys on 16/5/17.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import "UIScrollView+JKContentImage.h"

@implementation UIScrollView (JKContentImage)

- (UIImage *)jk_contentImage {
    UIImage *image = [self spliceImageWithDictionary:[self imagesWithPositions]];
    
    return image;
}

- (UIImage *)jk_contentImageWithSavePath:(NSString *)savePath {
    UIImage *image = [self jk_contentImage];
    [self saveImage:image toPath:savePath];
    return image;
}

- (UIImage *)screenShotImageWithSize:(CGSize)size {
    CGFloat scale = [UIScreen mainScreen].scale;
    UIGraphicsBeginImageContextWithOptions(size, YES, scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
//    NSString *da = [NSString stringWithFormat:@"/Users/emerys/Documents/img/%d.png",arc4random_uniform(1000)];
//    [self saveImage:image toPath:da];
    
    return image;
}

- (NSDictionary *)imagesWithPositions {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    CGSize contentSize = self.contentSize;
    CGPoint curPoint = self.contentOffset;
    
    if (contentSize.height < height) {
        contentSize.height = height;
    }
    
    if (contentSize.width < width) {
        contentSize.width = width;
    }
    
    if (contentSize.width <= width && contentSize.height <= height) {
        UIImage *image = [self screenShotImageWithSize:self.bounds.size];
        dic[NSStringFromCGPoint(CGPointMake(0, 0))] = image;
        return dic;
    } else {
        CGPoint offsetP = CGPointMake(0, 0);
        while (true) {
            NSString *pString = NSStringFromCGPoint(offsetP);
            UIImage *image = [self screenShotImageWithSize:self.bounds.size];
            dic[pString] = image;
            
            if (contentSize.width - (offsetP.x + width) < width && contentSize.width - (offsetP.x + width) > 0) {
                offsetP.x += contentSize.width - (offsetP.x + width);
            } else if (contentSize.width - (offsetP.x + width) == 0){
                if (contentSize.height - (offsetP.y + height) == 0) {
                    self.contentOffset = curPoint;
                    return dic;
//                    break;
                } else if (contentSize.height - (offsetP.y + height) < height && contentSize.height - (offsetP.y + height) > 0) {
                    offsetP.y += contentSize.height - (offsetP.y + height);
                } else {
                    offsetP.y += height;
                }
               
            } else {
                offsetP.x += width;
            }
        }
        
//        return dic;
    }
    return nil;
}

- (UIImage *)spliceImageWithDictionary:(NSDictionary *)dictionary {
    
    if (dictionary) {
        CGFloat width = self.bounds.size.width;
        CGFloat height = self.bounds.size.height;
        CGFloat scale = [UIScreen mainScreen].scale;
        CGSize size = self.contentSize;
        if (size.width < width && size.height < height) {
            size = CGSizeMake(width, height);
        }
//        NSArray *keys = dictionary.allKeys;
        UIGraphicsBeginImageContextWithOptions(size, NO, scale);
        
        [dictionary enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull key, UIImage * _Nonnull obj, BOOL * _Nonnull stop) {
            CGPoint point = CGPointFromString(key);
            CGRect rect = (CGRect){0,0,width,height};
            rect.origin = point;
            CGContextRef ctx = UIGraphicsGetCurrentContext();
            CGContextDrawImage(ctx, rect, [obj CGImage]);
//            [obj drawAtPoint:point];
        }];
        
        UIImage *contentImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return contentImage;
    }
    
    return nil;
}

- (void)saveImage:(UIImage *)image toPath:(NSString *)path {
    if (path && image) {
        NSLog(@"save to %@",path);
        NSData *data = UIImagePNGRepresentation(image);
        [data writeToFile:path atomically:NO];
    }
}


@end
