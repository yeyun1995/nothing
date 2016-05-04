//
//  SongInfo.h
//  DoubanFM
//
//  Created by lk on 16/5/3.
//  Copyright © 2016年 lk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SongInfo : NSObject
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,copy)NSString *sid;
@property(nonatomic,copy)NSString *url;
@property(nonatomic,copy)NSString *length;
+(instancetype)currentSong;
+(NSInteger)currentSongIndex;
+(void)setCurrentSong:(SongInfo *)songInfo;
+(void)setCurrentSongIndex:(int)songIndex;
@end
