//
//  NSData+JKImageType.m
//  chat
//
//  Created by emerys on 16/3/11.
//  Copyright © 2016年 Emerys. All rights reserved.
//

#import "NSData+JKImageType.h"

@implementation NSData (JKImageType)

-(JKIMAGETYPE)imageType{
    if (self.length > 4) {
        const unsigned char *byte = self.bytes;
        // jpeg/jpg
        // ff d8
        if (byte[0] == 0xff && byte[1] == 0xd8 && byte[2] == 0xff) {
            return JKIMAGETYPEJPG;
        }
        // png
        // 89 50 4e 47
        if (byte[0] == 0x89 && byte[1] == 0x50 && byte[2] == 0x4e && byte[3] == 0x47) {
            return JKIMAGETYPEPNG;
        }
        // bmp
        // 42 4D
        if (byte[0] == 0x42 && byte[1] == 0x4d) {
            return JKIMAGETYPEBMP;
        }
        
        // gif
        // GIF比对[47][49][46]与第五个字符39(37)
        if (byte[0] == 0x47 && byte[1] == 0x49 && byte[2] == 0x46 && (byte[4] == 0x39 || byte[4] == 0x37)) {
            return JKIMAGETYPEGIF;
        }
        
        return JKIMAGETYPEUNKNOW;
    }
    return JKIMAGETYPEUNKNOW;
}

@end
