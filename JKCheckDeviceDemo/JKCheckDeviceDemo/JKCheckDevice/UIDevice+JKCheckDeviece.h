//
//  UIDevice+JKCheckDeviece.h
//  JKCheckDeviceDemo
//
//  Created by emerys on 16/5/8.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import <UIKit/UIKit.h>

/**检测设备及判断功能*/
@interface UIDevice (JKCheckDeviece)

/**
 *  @author Jack Lee, 16-05-08 14:05:53
 *
 *  @brief 检测麦克风是否可用
 *
 *  @return yes／no
 */
+ (BOOL)microPhoneAvailable;
/**
 *  @author Jack Lee, 16-05-08 14:05:51
 *
 *  @brief 摄像头是否可用
 *
 *  @return yes／no
 */
+ (BOOL)cameraAvailable;
/**
 *  @author Jack Lee, 16-05-08 14:05:08
 *
 *  @brief 前置摄像头是否可用
 *
 *  @return yes／no
 */
+ (BOOL)frontCameraAvailable;
/**
 *  @author Jack Lee, 16-05-08 14:05:08
 *
 *  @brief 后置摄像头是否可用
 *
 *  @return yes／no
 */
+ (BOOL)rearCameraVailable;

/**
 *  @author Jack Lee, 16-05-08 14:05:36
 *
 *  @brief  是否支持视频录像
 *
 *  @return yes／no
 */
+ (BOOL)videoCameraAvailable;
/**
 *  @author Jack Lee, 16-05-08 14:05:53
 *
 *  @brief 照片库是否为空
 *
 *  @return yes／no
 */
+ (BOOL)photoLibraryIsEmpty;
/**
 *  @author Jack Lee, 16-05-08 14:05:56
 *
 *  @brief 闪光灯是否存在
 *
 *  @return yes／no
 */
+ (BOOL)cameraFlashAvailable;
/**
 *  @author Jack Lee, 16-05-08 14:05:59
 *
 *  @brief 检测陀螺仪是否存在
 *
 *  @return yes／no
 */
+ (BOOL)gyroscopeAvailable;
/**
 *  @author Jack Lee, 16-05-08 14:05:03
 *
 *  @brief 指南针是否可用
 *
 *  @return yes／no
 */
+ (BOOL)headingAvailable;
/**
 *  @author Jack Lee, 16-05-08 14:05:06
 *
 *  @brief 是否具备震动功能,没有提供检测功能。
 *
 *  @return yes／no
 */
+ (BOOL)vabriteAvailable;
/**
 *  @author Jack Lee, 16-05-08 14:05:08
 *
 *  @brief 检测拨打电话功能，iPod touch不能拨打电话
 *
 *  @return yes／no
 */
+ (BOOL)canMakePhoneCalls;

@end
