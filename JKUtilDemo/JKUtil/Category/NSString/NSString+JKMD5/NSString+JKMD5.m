//
//  NSString+JKMD5.m
//  JKUtilDemo
//
//  Created by Jack on 2018/10/12.
//  Copyright © 2018年 Emerys. All rights reserved.
//

#import "NSString+JKMD5.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (JKMD5)

- (nullable NSString *)md5String {
    
    const char *cStr = self.UTF8String;
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    NSMutableString *md5Str = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; ++i) {
        [md5Str appendFormat:@"%02x", result[i]];
    }
    return md5Str;
}

+ (NSString *)fileMD5:(NSString *)filePath {
    //生成文件的MD5
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:filePath];
    if( handle == nil ) {
        NSLog(@"文件出错");
        return nil;
    }
    
    CC_MD5_CTX md5;
    CC_MD5_Init(&md5);
    BOOL done = NO;
    while(!done)
    {
        NSData* fileData = [handle readDataOfLength:256];
        CC_MD5_Update(&md5, [fileData bytes], (unsigned int)[fileData length]);
        if( [fileData length] == 0 ) done = YES;
    }
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &md5);
    NSString *fileMD5 = [NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                         digest[0], digest[1],
                         digest[2], digest[3],
                         digest[4], digest[5],
                         digest[6], digest[7],
                         digest[8], digest[9],
                         digest[10], digest[11],
                         digest[12], digest[13],
                         digest[14], digest[15]];
    return fileMD5;
}

@end
