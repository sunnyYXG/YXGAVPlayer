//
//  YXGAVPlayer.h
//  YXGAVPlayer
//
//  Created by sunny_FX on 2017/6/17.
//  Copyright © 2017年 YXG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol YXGAVPlayerDelegate <NSObject>
/**
 *  author  苑心刚 QQ:505228831
 *
 *  @param currentTime 当前时间
 *  @param totalTime   总共时间
 *  @param progress    歌曲进度
 *  @param tapCount    点击次数
 */
-(void)getSongCurrentTime:(NSString *)currentTime andTotalTime:(NSString *)totalTime andProgress:(CGFloat)progress andTapCount:(NSInteger)tapCount;
@end

@interface YXGAVPlayer :  UIView
@property(nonatomic,retain)UIImageView *playerImage;//player的背景图片


/**
 *  songDelegate
 */
@property(nonatomic,retain)id<YXGAVPlayerDelegate>delegate;
/**
 *  volume 0.0~1.0
 */
@property(nonatomic,assign)CGFloat volume;
/**
 *  初始化YXGAVPlayer
 *
 *  @param frame  AVPlayerLayer的frame
 *  @param urlArr 歌曲网址的数组
 *  @param urlArr 歌曲背景图片网址的数组
 *
 *  @return   YXGAVPlayer
 */
-(instancetype)initWithFrame:(CGRect)frame
               andSongUrlArr:(NSArray *)urlArr
             andSongImageArr:(NSArray *)imageArr;
/**
 *  开始播放
 */
-(void)startPlay;
/**
 *  暂停播放
 */
-(void)puasePlay;
/**
 *  播放下一首
 */
-(void)nextSong;
/**
 *  播放上一首
 */
-(void)lastSong;



@end
