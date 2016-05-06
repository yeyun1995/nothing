//
//  SongInfo.m
//  DoubanFM
//
//  Created by lk on 16/5/3.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "SongInfo.h"
static SongInfo *currentSong;
static int currentSongindex;
@implementation SongInfo
+(instancetype)currentSong
{
    if (!currentSong)
    {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            currentSong =[SongInfo new];
        });
    }
    return currentSong;
}
+(void)setCurrentSong:(SongInfo *)songInfo
{
    currentSong =songInfo;
}
+(NSInteger)currentSongIndex
{
    return currentSongindex;
}
+(void)setCurrentSongIndex:(int)songIndex
{
    currentSongindex =songIndex;
}
@end
