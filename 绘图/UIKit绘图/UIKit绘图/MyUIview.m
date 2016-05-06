//
//  MyUIview.m
//  UIKit绘图
//
//  Created by Emerys on 7/29/15.
//  Copyright (c) 2015 Emerys. All rights reserved.
//

#import "MyUIview.h"


@implementation MyUIview

- (void) drawRect: (CGRect) rect{
    
    //使用UIKit UIKit在Cocoa为我们提供的当前上下文中完成绘图任务
    //UIBezierPath* p = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0,0,100,100)];
    //UIBezierPath *p = [UIBezierPath bezierPathWithArcCenter:CGPointMake(100, 100) radius:20 startAngle:0 endAngle:M_PI_2 clockwise:YES];//clockwise 顺时针
    
//    UIBezierPath *p;
//    p = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(50, 50, 100, 100) cornerRadius:30];//创建绘制路径，并不会绘制任何内容
//    [[UIColor blueColor] setFill];//设置画笔颜色
//    
//    [p fill];//向路径发送fill消息，图像才会被绘制
    
    //使用Core Graphics 绘图
//    //获取上下文
//    CGContextRef con = UIGraphicsGetCurrentContext();
//    //设置图形绘制路径
//    CGContextAddEllipseInRect(con, CGRectMake(50,50,200,80));
//    //设置图形填充颜色
//    CGContextSetFillColorWithColor(con, [UIColor blueColor].CGColor);
//    //开始绘制
//    CGContextFillPath(con);
 
    
    //平移
    UIImage *img = [UIImage imageNamed:@"mars.jpg"];//@"smiles_01_07.png"
    CGSize imgSize = img.size;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(2 * imgSize.width, imgSize.height), NO, 0);
                                                 
    [img drawAtPoint:CGPointMake(0, 0)];
    [img drawAtPoint:CGPointMake(imgSize.width, 0)];
    
    UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    UIImageView* iv = [[UIImageView alloc] initWithImage:im];
    
    [self.window.rootViewController.view addSubview: iv];
    
    iv.center = self.window.center;
    
    //缩放
//    //取得图像
//    UIImage *img = [UIImage imageNamed:@"mars.jpg"];
//    //取得图像大小
//    CGSize imgSize = img.size;
//    
//    //第一个参数表示所要创建的图片的尺寸；第二个参数用来指定所生成图片的背景是否为不透明，如上我们使用YES而不是NO，则我们得到的图片背景将会是黑色，显然这不是我想要的；第三个参数指定生成图片的缩放因子，这个缩放因子与UIImage的scale属性所指的含义是一致的。传入0则表示让图片的缩放因子根据屏幕的分辨率而变化，所以我们得到的图片不管是在单分辨率还是视网膜屏上看起来都会很好。
//    UIGraphicsBeginImageContextWithOptions(CGSizeMake(2 * imgSize.width,  2 * imgSize.height), NO, 0);
//    
//    //绘制底层大图形
//    [img drawInRect:CGRectMake(0, 0, imgSize.width * 2, imgSize.height * 2)];
//    //绘制顶层下图形
//    [img drawInRect:CGRectMake(imgSize.width * 0.75,imgSize.height * 0.75, imgSize.width / 2, imgSize.height / 2)];
//    //获取绘制的图像，返回UIImage对象
//    UIImage *im = UIGraphicsGetImageFromCurrentImageContext();
//    //关闭上下文
//    UIGraphicsEndImageContext();
//    //创建uiimageview 对象，使用绘制的图像作为image
//    UIImageView *iv = [[UIImageView alloc] initWithImage:im];
//    //将uiimageview对象添加到根视图显示。
//    [self.window.rootViewController.view addSubview:iv];
//    //设置视图中心在屏幕中心
//    iv.center = self.window.center;
    
    
    //裁减
//    UIImage *img = [UIImage imageNamed:@"mars.jpg"];
//    CGSize sz = img.size;
//    
//    UIGraphicsBeginImageContextWithOptions(CGSizeMake(sz.width / 2, sz.height), NO, 0);
//    
//    [img drawAtPoint:CGPointMake(-sz.width/2, 0)];
//    
//    UIImage *im = UIGraphicsGetImageFromCurrentImageContext();
//    
//    UIGraphicsEndImageContext();
//    
//    UIImageView *iv = [[UIImageView alloc] initWithImage:im];
//    [self.window.rootViewController.view addSubview:iv];
//    iv.center = self.window.center;
    
    
    
}

@end


