//
//  NetworkManager.m
//  DoubanFM
//
//  Created by lk on 16/5/3.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "NetworkManager.h"
#import "AppDelegate.h"
#import <AFNetworking/AFNetworking.h>

#import "SongInfo.h"
#import "PlayerController.h"
#import "ChannelInfo.h"
#define  PLAYLISTURLFORMATSTRING @"http://douban.fm/j/mine/playlist?type=%@&sid=%@&pt=%f&channel=%@&from=mainsite"
@interface NetworkManager(){
    AppDelegate *appDelegate;
    
    AFHTTPRequestOperationManager *manager;
}
@end
@implementation NetworkManager
-(instancetype)init
{
    if (self=[super init])
    {
        appDelegate = [[UIApplication sharedApplication]delegate];
        manager = [AFHTTPRequestOperationManager manager];
    }
    return self;
}
-(void)loadPlayListWithtype:(NSString *)type
{
    NSString *playListURLString = [NSString stringWithFormat:PLAYLISTURLFORMATSTRING,type,[SongInfo currentSong].sid,[PlayerController sharedInstance].currentPlaybackTime,[ChannelInfo currentChannel].ID];
    manager.responseSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:playListURLString parameters:nil success:^(AFHTTPRequestOperation *  operation, id  responseObject)
    {
        DFMPlaylist *playList = [PlayerController sharedInstance].playList;
        NSDictionary *songDictionary = responseObject;
        if ([type isEqualToString:@""])
        {
            [SongInfo setCurrentSongIndex:-1];
        }
        else
        {
            if ([playList.song count]!=0)
            {
                [SongInfo setCurrentSongIndex:0];
               [SongInfo setCurrentSong:[playList.song objectAtIndex:[SongInfo currentSongIndex]]];
                [[PlayerController sharedInstance]setContentURL:[NSURL URLWithString:[SongInfo currentSong].url]];
                [[PlayerController sharedInstance]play];
                
            }
            else
            {
                UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"HeyMan" message:@"红心列表中没有歌曲" preferredStyle: UIAlertControllerStyleAlert];
                
            }
        }
        [self.delegate reloadTableViewData];
    } failure:^(AFHTTPRequestOperation * operation, NSError * error)
    {
        
    }];
}
@end
