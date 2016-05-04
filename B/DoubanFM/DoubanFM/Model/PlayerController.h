//
//  PlayerController.h
//  DoubanFM
//
//  Created by lk on 16/5/4.
//  Copyright © 2016年 lk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "DFMPlaylist.h"
#import "ProtocolClass.h"
#import "AppDelegate.h"
#import "NetworkManager.h"
@interface PlayerController :MPMoviePlayerController
@property id<DoubanDelegate> songInfoDelegate;
@property(nonatomic)DFMPlaylist *playList;
+(instancetype)sharedInstance;

-(instancetype)init;
-(void)startPlay;

-(void)pauseSong;
-(void)restartSong;
-(void)likeSong;
-(void)dislikeSong;
-(void)deleteSong;
-(void)skipSong;
@end
