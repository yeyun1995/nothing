//
//  PlayerController.m
//  DoubanFM
//
//  Created by lk on 16/5/4.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "PlayerController.h"

@interface PlayerController ()
{
    AppDelegate *appDelegate;
    NetworkManager *networkManager;
}
@end

@implementation PlayerController
-(instancetype)init
{
    if (self= [super init])
    {
        appDelegate=[[UIApplication sharedApplication]delegate];
        networkManager=[NetworkManager new];
        
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(startPlay) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(initSongInformation) name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
    return self;
}
+(instancetype)sharedInstance
{
    static PlayerController *shareInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        shareInstance=[self new];
    });
    return shareInstance;
}
-(void)startPlay
{
   
}
-(void)pauseSong
{
    [self pause];
}
-(void)restartSong
{
    [self play];
}
-(void)likeSong
{
    [networkManager loadPlayListWithtype:@""];
}
-(void)dislikeSong
{
    [networkManager loadPlayListWithtype:@""];
    
}
-(void)deleteSong
{
    [networkManager loadPlayListWithtype:@""];
}
-(void)skipSong
{
    [networkManager loadPlayListWithtype:@""];
}
@end
