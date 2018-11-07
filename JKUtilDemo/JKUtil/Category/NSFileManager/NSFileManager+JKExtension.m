//
//  NSFileManager+JKExtension.m
//  JKUtilDemo
//
//  Created by Jack on 2018/11/6.
//  Copyright © 2018年 Emerys. All rights reserved.
//

#import "NSFileManager+JKExtension.h"

@implementation NSFileManager (JKExtension)

- (void)jk_moveFile:(NSString *)filePath toFolder:(NSString *)folder {
    
    NSFileManager *fm = self;
    BOOL isDir = NO;
    if ([fm fileExistsAtPath:filePath isDirectory:&isDir] && !isDir) {
        
        BOOL fIsDir = NO;
        if ([fm fileExistsAtPath:folder isDirectory:&fIsDir] && fIsDir) {
            
        } else {
            NSError *err = nil;
            [fm createDirectoryAtPath:folder withIntermediateDirectories:YES attributes:nil error:&err];
            if (err) {
                NSLog(@"create folder error: %@",err);
                return;
            }
        }
        
        NSString *to = [folder stringByAppendingPathComponent:filePath.lastPathComponent];
        
        NSError *err = nil;
        [fm moveItemAtPath:filePath toPath:to error:&err];
        if (err) {
            NSLog(@"move file error: %@",err);
        }
    }
}

- (void)jk_moveFolder:(NSString *)srcfolder toFolder:(NSString *)destFolder {
    
    NSFileManager *fm = self;
    BOOL isDir = NO;
    if ([fm fileExistsAtPath:srcfolder isDirectory:&isDir] && isDir) {
        
        NSString *dest = [destFolder stringByAppendingPathComponent:srcfolder.lastPathComponent];
        isDir = NO;
        if ([fm fileExistsAtPath:dest isDirectory:&isDir] && isDir) {
            
        } else {
            NSError *err = nil;
            [fm createDirectoryAtPath:dest withIntermediateDirectories:YES attributes:nil error:&err];
            if (err) {
                NSLog(@"create folder error: %@",err);
                return;
            }
        }
        
        NSArray<NSString *> *contents = [fm contentsOfDirectoryAtPath:srcfolder error:nil];
        if (contents.count > 0) {
            
            [contents enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                NSString *path = [srcfolder stringByAppendingPathComponent:obj];
                
                BOOL fileIsDir = NO;
                if ([fm fileExistsAtPath:path isDirectory:&fileIsDir]) {
                    
                    if (fileIsDir) {
                        
                        [self jk_moveFolder:path toFolder:dest];
                        
                    } else {
                        [self jk_moveFile:path toFolder:dest];
                    }
                    
                }
            }];
            
        }
    }
}

- (void)jk_move:(NSString *)src to:(NSString *)dest {
    
    BOOL isDir = NO;
    if ([self fileExistsAtPath:src isDirectory:&isDir]) {
        
        if (isDir) {
            
            [self jk_moveFolder:src toFolder:dest];
            
        } else {
            
            [self jk_moveFile:src toFolder:dest];
        }
    }
}

@end
