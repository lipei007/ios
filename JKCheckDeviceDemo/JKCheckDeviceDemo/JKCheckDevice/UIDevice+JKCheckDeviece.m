//
//  UIDevice+JKCheckDeviece.m
//  JKCheckDeviceDemo
//
//  Created by emerys on 16/5/8.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import "UIDevice+JKCheckDeviece.h"
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <CoreMotion/CoreMotion.h>
#import <CoreLocation/CoreLocation.h>
#import <AudioToolbox/AudioToolbox.h>

@implementation UIDevice (JKCheckDeviece)

+ (BOOL)microPhoneAvailable{
    // 导入 AVFoundation/AVFoundation.h
    return [AVAudioSession sharedInstance].inputAvailable;
}

+ (BOOL)cameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

+ (BOOL)frontCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

+ (BOOL)rearCameraVailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

+ (BOOL)videoCameraAvailable{

    if (![self cameraAvailable])
        return NO;
    NSArray *sourceType = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    // kUTTypeMovie  将 MobileCoreServices 框架添加到项目中，然后导入：MobileCoreServices/MobileCoreServices.h
    if (![sourceType containsObject:(NSString *)kUTTypeMovie]) {
        return NO;
    }
    return YES;
}

+ (BOOL)photoLibraryIsEmpty{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
}

+ (BOOL)cameraFlashAvailable{
    return [UIImagePickerController isFlashAvailableForCameraDevice:UIImagePickerControllerCameraDeviceRear];
}

+ (BOOL)gyroscopeAvailable{
    // 将 CoreMotion 框架添加进项目中，导入 CoreMotion/CoreMotion.h
    CMMotionManager *motionManager = [[CMMotionManager alloc] init];
    return motionManager.gyroAvailable;
}

+ (BOOL)headingAvailable{
    // 将 CoreLocation 框架添加进项目中 导入 CoreLocation/CoreLocation.h
    return [CLLocationManager headingAvailable];
}

+ (BOOL)vabriteAvailable{
    // 将 AudioToolBox 框架添加进项目中 导入 AudioToolbox/AudioToolbox.h
    //震动
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate); // 支持震动的设备上会震动，不支持就什么都不做
    //AudioServicesPlayAlertSound(kSystemSoundID_Vibrate); // 不支持震动就发出“哔哔哔”的响声
    
    return YES;
}

+ (BOOL)canMakePhoneCalls{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://"]];
}

@end
