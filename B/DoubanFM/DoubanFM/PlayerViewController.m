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

#import <MASConstraintMaker.h>
#import <MASLayoutConstraint.h>
#import <Masonry/Masonry.h>

#import <UIImageView+WebCache.h>
#import "ChannelInfo.h"
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
    //写个约束
    [self P_configConstrains];
    //加载播放list
    [self P_loadPlayList];
    
    [PlayerController sharedInstance].songInfoDelegate= self;
    timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
}
//视图将要加载
-(void)viewDidAppear:(BOOL)animated
{
    self.albumCoverImage.layer.cornerRadius=self.albumCoverImage.bounds.size.width/2.0;
    self.albumCoverImage.layer.masksToBounds=YES;
    [super viewDidAppear:animated];
    [self initSongInformation];
}
//视图将要消失
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[UIApplication sharedApplication]endReceivingRemoteControlEvents];
    [self resignFirstResponder];
}
//暂停按钮
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
//换歌按钮
-(void)skipButtonDidtapped:(UIButton *)sender
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
//喜爱按钮
-(void)likeButtonDidtapped:(UIButton*)sender
{
    if (![SongInfo currentSong]) {
        
    }
}
//删除按钮
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
//更新进度条
-(void)updateProgress
{
    int currentTimeMinutes = (unsigned)[PlayerController sharedInstance].currentPlaybackTime/60;
    int currentTimeSeconds = (unsigned)[PlayerController sharedInstance].currentPlaybackTime%60;
    NSMutableString *currentTimeString;
    //歌曲图片旋转
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
//添加子视图
-(void)P_addSubViews
{
    NSArray *subViews = @[_channelTitleLabel,_albumCoverImage,_albumCoverMaskImage,_timerProgressBar,_timerLabel,_songTitleLabel,_songArtistLabel,_pausebutton,_likeButton,_deletebutton,_skipButton];
  [subViews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *  stop)
    {
        [self.view addSubview:view];
    }];
}
//配置约束
-(void)P_configConstrains
{
    UIView *superView =self.view;
    [self.channelTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView).offset(15);
        make.right.equalTo(superView).offset(-15);
        make.height.mas_equalTo(@40);
    }];
    UIView __block *lastView =nil;
    [@[self.channelTitleLabel,self.albumCoverImage,self.timerProgressBar,]enumerateObjectsUsingBlock:^(UIView  *view, NSUInteger idx, BOOL * stop)
    {
     [view mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(lastView ? lastView.mas_bottom :superView.mas_top).offset(30);
     }];
        lastView=view;
    }];
    lastView =nil;
    [@[self.pausebutton,self.likeButton,self.deletebutton,self.skipButton,]enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *  stop)
     {
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(superView.mas_bottom).offset(-15);
            make.height.equalTo(lastView ? lastView.mas_right : superView.mas_left).offset(30);
        }];
         lastView=view;
     }];
    [self.skipButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(superView.mas_right).offset(-30);
        make.size.equalTo(@[self.pausebutton,self.likeButton,self.deletebutton]);
    }];
    lastView=nil;
    [@[self.songArtistLabel,self.songTitleLabel,self.timerLabel,self.timerProgressBar]enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *  stop) {
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView).offset(15);
            make.right.equalTo(superView).offset(-15);
            make.bottom.equalTo(lastView ? lastView.mas_top : self.pausebutton.mas_top).offset(-15);
        }];
        lastView=view;
    }];
    [self.songArtistLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@[self.songTitleLabel,self.timerLabel]);
    }];
    [self.albumCoverImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(superView);
        make.left.equalTo(superView).offset(20);
        make.right.equalTo(superView).offset(-20);
        make.width.equalTo(self.albumCoverImage.mas_height);
    }];
    
    
}
//加载播放表
-(void)P_loadPlayList
{
    [[NetworkManager sharefInstancd]loadPlayListWithtype:@""];
}
//配置播放信息
-(void)configPlayingInfo
{
    if (NSClassFromString(@""))
    {
        if ([SongInfo currentSong].title!=nil)
        {
            NSMutableDictionary *dict = [NSMutableDictionary new];
            [dict setObject:[SongInfo currentSong].title forKey:MPMediaItemPropertyTitle];
            [dict setObject:[SongInfo currentSong].artist forKey:MPMediaItemPropertyAlbumArtist];
            UIImage *tempImage = _albumCoverImage.image;
            if (tempImage!=nil)
            {
                [dict setObject:[[MPMediaItemArtwork alloc]initWithImage:tempImage] forKey:MPMediaItemPropertyArtwork];
            }
            [dict setObject:[NSNumber numberWithFloat:[[SongInfo currentSong].length floatValue]] forKey:MPMediaItemPropertyPlaybackDuration];
            [[MPNowPlayingInfoCenter defaultCenter]setNowPlayingInfo:dict];
        }
    }
}
//初始化歌曲信息
-(void)initSongInformation
{
    isPlaying=YES;
    if (![self isFirstResponder])
    {
        [[UIApplication sharedApplication]beginReceivingRemoteControlEvents];
        [self becomeFirstResponder];
    }
    __weak __typeof(self) weakSelf =self;
    self.albumCoverImage.image=nil;
    [self.albumCoverImage sd_setImageWithURL:[NSURL URLWithString:[SongInfo currentSong].picture] placeholderImage:nil  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        __strong __typeof(weakSelf)strongSelf=weakSelf;
        strongSelf.albumCoverImage.transform=CGAffineTransformMakeRotation(0.0);
    }];
    self.songArtistLabel.text=[SongInfo currentSong].artist;
    self.songTitleLabel.text=[SongInfo currentSong].title;
    self.channelTitleLabel.text =[NSString stringWithFormat:@"%@",[ChannelInfo currentChannel].name];
    int TotalTimeSencond = [[SongInfo currentSong].length intValue]%60;
    int TotalTimeMinutes =[[SongInfo currentSong].length intValue]/60;
    if (TotalTimeSencond<10)
    {
        totaltimeString =[NSMutableString stringWithFormat:@"%d:%d",TotalTimeMinutes,TotalTimeSencond];
        
    }
    else
    {
        totaltimeString =[NSMutableString stringWithFormat:@"%d:%d",TotalTimeMinutes,TotalTimeSencond];
    }
    if (![[SongInfo currentSong].like intValue])
    {
        [self.likeButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        
    }
    else
    {
        [self.likeButton setBackgroundImage:[UIImage imageNamed:@""] forState: UIControlStateNormal];
        
    }
    [timer setFireDate:[NSDate date]];
    [self configPlayingInfo];
}
//歌名频道的LABEL
-(UILabel *)channelTitleLabel
{
    if (!_channelTitleLabel)
    {
        UILabel *label =[UILabel new];
        label.backgroundColor =[UIColor clearColor];
        label.font=[UIFont systemFontOfSize:24.0f];
        label.textAlignment= NSTextAlignmentCenter;
        label.textColor=[UIColor redColor];
        _channelTitleLabel=label;
    }
    return _channelTitleLabel;
}
//播放时的照片
-(UIImageView *)albumCoverImage
{
    if (!_albumCoverImage)
    {
        UIImageView *imageView = [UIImageView new];
        _albumCoverImage=imageView;
    }
    return _albumCoverImage;
}
//暂停时的照片
-(UIImageView *)albumCoverMaskImage
{
    if (!_albumCoverMaskImage)
    {
        UIImageView *imageView =[UIImageView new];
        imageView.image =[UIImage imageNamed:@""];
        imageView.contentMode=UIViewContentModeScaleAspectFill;
       
        imageView.userInteractionEnabled=YES;
        UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pauseButtonDidTapped:)];
        [singleTap setNumberOfTapsRequired:1];
        [imageView addGestureRecognizer:singleTap];
        
        _albumCoverMaskImage=imageView;
    }
    return _albumCoverMaskImage;
}
//进度条
-(UIProgressView *)timerProgressBar
{
    if (!_timerProgressBar)
    {
        _timerProgressBar =[UIProgressView new];
        _timerProgressBar.progressTintColor=[UIColor blackColor];
        
    }
    return _timerProgressBar;
}
//歌名信息 的LABEL
-(UILabel *)songArtistLabel
{
    if (!_songArtistLabel)
    {
        UILabel *label =[UILabel new];
        label.backgroundColor =[UIColor clearColor];
        label.font =[UIFont systemFontOfSize:15.0f];
        label.textAlignment=NSTextAlignmentCenter;
        label.textColor=[UIColor blueColor];
        _songArtistLabel=label;
    }
    return _songArtistLabel;
}
-(UILabel*)songTitleLabel
{
    if (!_songTitleLabel)
    {
        UILabel *label =[UILabel new];
        label.backgroundColor =[UIColor brownColor];
        label.font =[UIFont systemFontOfSize:22.0f];
        label.textAlignment=NSTextAlignmentCenter;
        label.textColor=[UIColor blueColor];
        _songTitleLabel=label;
    }
    return _songTitleLabel;
}
-(void)remoteControlReceivedWithEvent:(UIEvent *)event
{
    if (event.type ==UIEventTypeRemoteControl)
    {
        switch (event.subtype)
        {
            case UIEventSubtypeRemoteControlPause:
                case UIEventSubtypeRemoteControlPlay:
                [self pauseButtonDidTapped:nil];
                break;
                case UIEventSubtypeRemoteControlNextTrack:
                [self skipButtonDidtapped:nil];
                break;
                
            default:
                break;
        }
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
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
