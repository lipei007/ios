//
//  MusicModel.m
//  音乐播放器
//
//  Created by emerys on 15/9/12.
//  Copyright (c) 2015年 Emerys. All rights reserved.
//

#import "MusicModel.h"

@implementation MusicModel

-(void)encodeWithCoder:(NSCoder *)aCoder{
    if (aCoder) {
        [aCoder encodeObject:self.musicName forKey:@"musicname"];
        [aCoder encodeObject:@(self.isDownload) forKey:@"download"];
        [aCoder encodeObject:@(self.isLoved) forKey:@"love"];
    }
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        if (aDecoder) {
            self.musicName = [aDecoder decodeObjectForKey:@"musicname"];
            self.isLoved = [(NSNumber *)[aDecoder decodeObjectForKey:@"love"] boolValue];
            self.isDownload = [(NSNumber *)[aDecoder decodeObjectForKey:@"download"] boolValue];
        }
    }
    return self;
}

@end
