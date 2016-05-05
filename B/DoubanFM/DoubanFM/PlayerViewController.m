//
//  PlayerViewController.m
//  DoubanFM
//
//  Created by lk on 16/4/28.
//  Copyright © 2016年 lk. All rights reserved.
//

#import "PlayerViewController.h"
#import <UIKit+AFNetworking.h>
#import "NetworkManager.h"
#import "PlayerController.h"
#import "SongInfo.h"
@interface PlayerViewController ()<DoubanDelegate>
{
    BOOL isPlaying;
    NSTimer *timer;
    NSMutableString *totaltimeString;
}
@property(nonatomic,strong)UILabel *channelTitleLabel;
@property(nonatomic,strong)UIImageView *albumCoverImage;
@property(nonatomic,strong)UIImageView *albumCoverMaskImage;
@property(nonatomic,strong)UIProgressView *timerProgressBar;
@property(nonatomic,strong)UILabel *timerLabel;
@property(nonatomic,strong)UILabel *songTitleLabel;
@property(nonatomic,strong)UILabel *songArtistLabel;

@property(nonatomic,strong)UIButton *pausebutton;
@property(nonatomic,strong)UIButton *likeButton;
@property(nonatomic,strong)UIButton *deletebutton;
@property(nonatomic,strong)UIButton *skipButton;

@end

@implementation PlayerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor colorWithRed:0.155 green:0.839 blue:0.882 alpha:1.000];
    //所有的子视图
    [self P_addSubViews];
    //写个约束 不会
    //加载播发list
    [self P_loadPlayList];
    
    [PlayerController sharedInstance].songInfoDelegate= self;
    timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
}
-(void)viewDidAppear:(BOOL)animated
{
    self.albumCoverImage.layer.cornerRadius=self.albumCoverImage.bounds.size.width/2.0;
    self.albumCoverImage.layer.masksToBounds=YES;
    [super viewDidAppear:animated];
    [self initSongInformation];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[UIApplication sharedApplication]endReceivingRemoteControlEvents];
    [self resignFirstResponder];
}
-(void)pauseButtonDidTapped:(UIButton *)sender
{
    if (isPlaying)
    {
        isPlaying=NO;
        self.albumCoverImage.alpha=0.3f;
        self.albumCoverMaskImage.image=[UIImage imageNamed:@""];
        [[PlayerController sharedInstance]pauseSong];
        [self.pausebutton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [timer setFireDate:[NSDate distantFuture]];
        
    }
    else
    {
        isPlaying=YES;
        self.albumCoverImage.alpha=1.0f;
        self.albumCoverMaskImage.image=[UIImage imageNamed:@""];
        [[PlayerController sharedInstance]restartSong];
        [timer setFireDate:[NSDate date]];
        [self.pausebutton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal ];
        
    }
}
-(void)skioButtonDidtapped:(UIButton *)sender
{
    [timer setFireDate:[NSDate distantFuture]];
    [[PlayerController sharedInstance]pauseSong];
    if (isPlaying ==NO)
    {
        self.albumCoverImage.alpha=1.0f;
        self.albumCoverMaskImage.image=[UIImage imageNamed:@"" ] ;
        
    }
    [[PlayerController sharedInstance]skipSong];
}
-(void)likeButtonDidtapped:(UIButton*)sender
{
    if (![SongInfo currentSong]) {
        
    }
}
-(void)updateProgress
{
    int currentTimeMinutes = (unsigned)[PlayerController sharedInstance].currentPlaybackTime/60;
    int currentTimeSeconds = (unsigned)[PlayerController sharedInstance].currentPlaybackTime%60;
    NSMutableString *currentTimeString;
    self.albumCoverImage.transform=CGAffineTransformRotate(self.albumCoverImage.transform, M_PI /1440);
    if (currentTimeSeconds<10)
    {
        currentTimeString=[NSMutableString stringWithFormat:@"%d:0%d",currentTimeMinutes,currentTimeSeconds];
    }
    else
    {
        currentTimeString
        =[NSMutableString stringWithFormat:@"%d:%d",currentTimeMinutes,currentTimeSeconds];
    }
    NSMutableString *timeLabelString = [NSMutableString stringWithFormat:@"%@/%@",currentTimeString,totaltimeString];
    self.timerLabel.text=timeLabelString;
    self.timerProgressBar.progress=[PlayerController sharedInstance].currentPlaybackTime/[[SongInfo currentSong].length intValue];
}
-(void)deleteButtonTapped:(UIButton* )sender
{
    if (isPlaying==NO)
    {
        isPlaying=YES;
        self.albumCoverImage.alpha=1.0f;
        self.albumCoverMaskImage.image=[UIImage imageNamed:@""];
        [[PlayerController sharedInstance]restartSong];
        [self.pausebutton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal]; 
    }
    [[PlayerController sharedInstance]deleteSong];
}
-(void)P_addSubViews
{
    NSArray *subViews = @[_channelTitleLabel,_albumCoverImage,_albumCoverMaskImage,_timerProgressBar,_timerLabel,_songTitleLabel,_songArtistLabel,_pausebutton,_likeButton,_deletebutton,_skipButton];
  [subViews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *  stop)
    {
        [self.view addSubview:view];
    }];
}
-(void)P_loadPlayList
{
    [[NetworkManager sharefInstancd]loadPlayListWithtype:@""];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
