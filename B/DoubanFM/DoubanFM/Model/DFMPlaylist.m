//
//  DFMPlaylist.m
//  DoubanFM
//
//  Created by lk on 16/5/4.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "DFMPlaylist.h"
#import "SongInfo.h"
@implementation DFMPlaylist
+(NSDictionary *)objectClassInArray
{
    return @{
             @"song":NSStringFromClass([SongInfo class]),
             };
}
@end
