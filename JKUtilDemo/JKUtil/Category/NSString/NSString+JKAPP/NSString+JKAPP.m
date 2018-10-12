//
//  NSString+JKAPP.m
//  JKUtilDemo
//
//  Created by Jack on 2018/10/12.
//  Copyright © 2018年 Emerys. All rights reserved.
//

#import "NSString+JKAPP.h"

@implementation NSString (JKAPP)

+ (NSDictionary *)appInfoDic {
    return [[NSBundle mainBundle] infoDictionary];
}

+ (NSString *)appName {
    NSString* name =[self.appInfoDic objectForKey:@"CFBundleDisplayName"];
    return name;
}

+ (NSString *)appVer {
    NSString* version =[self.appInfoDic objectForKey:@"CFBundleShortVersionString"];
    return version;
}

+ (NSString *)appBuild {
    NSString* build =[self.appInfoDic objectForKey:@"CFBundleVersion"];
    return build;
}

+ (NSString *)appIdentifier {
    NSString *bundleID = [self.appInfoDic objectForKey:@"CFBundleIdentifier"];
    return bundleID;
}

+ (NSString *)appBundle {
    NSString *bundleName = [self.appInfoDic objectForKey:@"CFBundleName"];
    return bundleName;
}

@end
