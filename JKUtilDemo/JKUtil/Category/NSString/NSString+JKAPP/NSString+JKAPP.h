//
//  NSString+JKAPP.h
//  JKUtilDemo
//
//  Created by Jack on 2018/10/12.
//  Copyright © 2018年 Emerys. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (JKAPP)

#pragma mark - APP Info

@property (class,nonatomic,strong,readonly) NSDictionary *appInfoDic;
@property (class,nonatomic,copy,readonly) NSString *appName;
@property (class,nonatomic,copy,readonly) NSString *appVer;
@property (class,nonatomic,copy,readonly) NSString *appBuild;
@property (class,nonatomic,copy,readonly) NSString *appIdentifier;
@property (class,nonatomic,copy,readonly) NSString *appBundle;

#pragma mark - Path

@property (class,nonatomic,copy,readonly) NSString *bundlePath;
@property (class,nonatomic,copy,readonly) NSString *libraryDir;
@property (class,nonatomic,copy,readonly) NSString *cacheDir;
@property (class,nonatomic,copy,readonly) NSString *documentDir;
@property (class,nonatomic,copy,readonly) NSString *tmpDir;

@end

