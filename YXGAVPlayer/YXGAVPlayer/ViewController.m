//
//  ViewController.m
//  YXGAVPlayer
//
//  Created by sunny_FX on 2017/6/17.
//  Copyright © 2017年 YXG. All rights reserved.
//

#import "ViewController.h"
#import "YXGAVPlayer.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<YXGAVPlayerDelegate>

@property(nonatomic,copy)NSArray *songArr;//歌曲数组
@property(nonatomic,copy)NSArray *songNameArr;//歌曲名称数组
@property(nonatomic,copy)NSArray *songAuthorArr;//歌曲演唱者数组
@property(nonatomic,copy)NSArray *songImageArr;//歌曲图片数组

@property(nonatomic,retain)YXGAVPlayer *player;
@property(nonatomic,retain)UIButton *playBt;//播放\暂停按钮
@property(nonatomic,retain)UIButton *lastBt;//上一首按钮
@property(nonatomic,retain)UIButton *nextBt;//下一首按钮

@property(nonatomic,retain)UILabel *songTime;//歌曲时间
@property(nonatomic,retain)UILabel *songName;//歌曲名称
@property(nonatomic,retain)UILabel *songAuthor;//歌曲演唱者
@property(nonatomic,retain)UIProgressView *progressView;//进度条

@end

@implementation ViewController

#pragma mark---歌曲名称数组
-(NSArray *)songNameArr
{
    _songNameArr=@[@"火星情报局 (《火星情报局》节目主题曲)",@"下一站我是你的依靠",@"世界上不存在的歌(《火锅英雄》电影主题曲)"];
    return _songNameArr;
}
#pragma mark---歌曲流媒体地址
-(NSArray *)songArr
{
    _songArr=@[@"http://image.kaolafm.net/mz/audios/201706/d1779152-bde7-41a0-b9b1-f4cea6e7dc57.mp3",@"http://image.kaolafm.net/mz/audios/201706/880946dd-78f9-4f31-92ee-8d0ad25eb7e6.mp3",@"http://image.kaolafm.net/mz/audios/201706/4ffd0e40-b417-47ae-b81f-bcdeafd88624.mp3"];
    return _songArr;
}
#pragma mark---歌曲演唱者数组
-(NSArray *)songAuthorArr
{
    _songAuthorArr=@[@"华晨宇",@"金志文",@"赵英俊"];
    return _songAuthorArr;
}
#pragma mark---歌曲图片的数组
-(NSArray *)songImageArr
{
    _songImageArr=@[@"http://i.gtimg.cn/music/photo/mid_album_300/W/8/003re5702kSBW8.jpg",@"http://i.gtimg.cn/music/photo/mid_album_300/z/9/002PnERL0JwJz9.jpg",@"photo3.jpg"];
    return _songImageArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor colorWithWhite:0.875 alpha:1.000];
    //添加playerView
    [self addPlayerView];
    //添加歌曲的信息
    [self addSongInformation];
    //添加播放器的控件
    [self addPlayerControls];
}
#pragma mark---添加playerView
-(void)addPlayerView
{
    _player=[[YXGAVPlayer alloc]initWithFrame:CGRectMake(WIDTH/4, HEIGHT/2-WIDTH/4, WIDTH/2, WIDTH/2) andSongUrlArr:self.songArr andSongImageArr:self.songImageArr];
    _player.delegate=self;
    _player.layer.cornerRadius=WIDTH/4;
    _player.layer.masksToBounds=YES;
    _player.backgroundColor=[UIColor yellowColor];
    //设置volume，不设置默认为0.5
    _player.volume=0.8;
    [self.view addSubview:_player];
}
#pragma mark----SZKAVPlayerDelegate代理方法
-(void)getSongCurrentTime:(NSString *)currentTime andTotalTime:(NSString *)totalTime andProgress:(CGFloat)progress andTapCount:(NSInteger)tapCount
{
    //进度条
    [_progressView setProgress:progress];
    //歌曲时间
    _songTime.text=[NSString stringWithFormat:@"%@/%@",currentTime,totalTime];
    //歌曲名称
    _songName.text=self.songNameArr[tapCount];
    //歌曲演唱者
    _songAuthor.text=self.songAuthorArr[tapCount];
}
#pragma makr---添加歌曲的信息
-(void)addSongInformation
{
    //歌曲名称
    _songName=[[UILabel alloc]initWithFrame:CGRectMake(0, 100, WIDTH, 40)];
    _songName.text=self.songNameArr[0];
    _songName.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:_songName];
    //歌曲作者
    _songAuthor=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_songName.frame)+10, WIDTH, 40)];
    _songAuthor.text=self.songAuthorArr[0];
    _songAuthor.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:_songAuthor];
    //歌曲的时间
    _songTime=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_player.frame)+20, WIDTH, 40)];
    _songTime.textAlignment=NSTextAlignmentCenter;
    _songTime.text=@"00:00/00:00";
    [self.view addSubview:_songTime];
}
#pragma mark---添加播放器的播放，下一首，上一首按钮控件
-(void)addPlayerControls
{
    //进度条
    _progressView=[[UIProgressView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_songTime.frame)+20, WIDTH, 10)];
    [self.view addSubview:_progressView];
    //播放\暂停按钮
    _playBt=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH/2-15, CGRectGetMaxY(_progressView.frame)+20, 40, 40)];
    [_playBt setBackgroundImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    [_playBt addTarget:self action:@selector(playBtClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_playBt];
    //上一首
    _lastBt=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMinX(_playBt.frame)-80, CGRectGetMinY(_playBt.frame), 40, 40)];
    [_lastBt setBackgroundImage:[UIImage imageNamed:@"last"] forState:UIControlStateNormal];
    [_lastBt addTarget:self action:@selector(lastBtClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_lastBt];
    //下一首
    _nextBt=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_playBt.frame)+40, CGRectGetMinY(_playBt.frame), 40, 40)];
    [_nextBt setBackgroundImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
    [_nextBt addTarget:self action:@selector(nextBtClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nextBt];
}
#pragma mark---播放暂停按钮点击
-(void)playBtClick:(UIButton *)sender
{
    if (sender.selected==NO) {
        //暂停播放
        [_player puasePlay];
        [_playBt setBackgroundImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        sender.selected=YES;
    }else if(sender.selected==YES){
        //开始播放
        [_player startPlay];
        [_playBt setBackgroundImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
        sender.selected=NO;
    }
}

#pragma mark---上一首按钮点击
-(void)lastBtClick
{
    //暂停
    [_player puasePlay];
    //上一首
    [_player lastSong];
    //改变播放按钮的图片
    [_playBt setBackgroundImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    _playBt.selected=NO;
}
#pragma mark----下一首按钮点击
-(void)nextBtClick
{
    //暂停
    [_player puasePlay];
    //下一首
    [_player nextSong];
    //改变播放按钮的图片
    [_playBt setBackgroundImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    _playBt.selected=NO;
}


@end
