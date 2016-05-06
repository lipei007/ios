//
//  DrawImage.m
//  myDraw
//
//  Created by Emerys on 7/31/15.
//  Copyright (c) 2015 Emerys. All rights reserved.
//

#import "DrawImage.h"

@implementation DrawImage

-(void)drawRect:(CGRect)rect{
    
    UIImage *image = [UIImage imageNamed:@"ball.png"];
    CGSize size = image.size;

    CGRect rec = CGRectMake(50, 50, size.width, size.height);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextDrawImage(ctx, rec, image.CGImage);
//    CGContextRestoreGState(ctx);
    
//    UIGraphicsBeginImageContext(CGSizeMake(2 * size.width, size.height));
//    
//    [image drawAtPoint:CGPointMake(0, 0)];
//    [image drawAtPoint:CGPointMake(size.width, 0)];
//    
//    UIImage *im = UIGraphicsGetImageFromCurrentImageContext();
//    
//    UIGraphicsEndImageContext();
//    UIImageView *iv = [[UIImageView alloc] initWithImage:im];
//    
//    [self addSubview:iv];

}


@end
