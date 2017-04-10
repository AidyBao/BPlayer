//
//  BPlayer.m
//  BPlayer
//
//  Created by 120v on 2017/4/7.
//  Copyright © 2017年 120v. All rights reserved.
//

#import "BPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface BPlayer()

@property (nonatomic,strong) AVPlayer *player;//播放器对象

@property (strong, nonatomic) AVPlayerItem *playerItem;

@end

@implementation BPlayer


- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self setupPlayer];
        
        [self addNotification];
        
        //获取player的播放进度
        [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
            float current = CMTimeGetSeconds(time);
            NSLog(@"当前已经播放%f",current);
            
        }];
    }
    
    return self;
}

#pragma mark - 私有方法
- (void)setupPlayer{
    //创建播放器层
    AVPlayerLayer *playerLayer = [[AVPlayerLayer alloc]init];
    playerLayer.frame = self.bounds;
    playerLayer.player = self.player;
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;//视频填充模式
    [self.layer addSublayer:playerLayer];
}

/**
 *  初始化播放器
 *
 *  @return 播放器对象
 */
- (AVPlayer *)player{
    if (!_player) {
        _player=[[AVPlayer alloc]init];
    }
    return _player;
}

#pragma mark -  外部接口
- (void)m_playWithURL:(NSURL *)url {
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:url];
    if (self.playerItem) {
        [self.playerItem removeObserver:self forKeyPath:@"status"];
        [self.playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    }
    self.playerItem = playerItem;
    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [self.playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)m_play {
    [self.player replaceCurrentItemWithPlayerItem:self.playerItem];
    [self.player play];
}

- (void)m_pause {
    [self.player pause];
}


#pragma mark - 通知
/**
 *  添加播放器通知
 */
- (void)addNotification{
    //给AVPlayerItem添加播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
    //添加进入后台和前台的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
    
}

- (void)applicationDidEnterBackground:(NSNotification *)notification {
    //暂停
    [self.player pause];
}

- (void)applicationWillEnterForeground:(NSNotification *)notification {
    //播放
    [self.player play];
}

+ (void)removeNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 *  播放完成通知
 *
 *  @param notification 通知对象
 */
- (void)playbackFinished:(NSNotification *)notification{
    NSLog(@"视频播放完成.");
    AVPlayerItem * playerItem = [notification object];
    
    //重复播放的关键代码（设置时间为0，然后重新播放）
    [playerItem seekToTime:kCMTimeZero];
    [self.player play];
    
    
}

#pragma mark - 监控

/**
 *  给AVPlayerItem添加监控
 *
 *  @param playerItem AVPlayerItem对象
 */
- (void)addObserverToPlayerItem:(AVPlayerItem *)playerItem{
    //监控状态属性，注意AVPlayer也有一个status属性，通过监控它的status也可以获得播放状态
    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    //监控网络加载情况属性
    [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
}

/**
 *  通过KVO监控播放器状态
 *
 *  @param keyPath 监控属性
 *  @param object  监视器
 *  @param change  状态改变
 *  @param context 上下文
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    AVPlayerItem *playerItem=object;
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerStatus status= [[change objectForKey:@"new"] intValue];
        if(status==AVPlayerStatusReadyToPlay){
            NSLog(@"正在播放...，视频总长度:%.2f",CMTimeGetSeconds(playerItem.duration));
        }
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]){
        NSArray *array=playerItem.loadedTimeRanges;
        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];//本次缓冲时间范围
        float startSeconds = CMTimeGetSeconds(timeRange.start);
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        NSTimeInterval totalBuffer = startSeconds + durationSeconds;//缓冲总长度
        NSLog(@"共缓冲：%.2f",totalBuffer);
    }
}

- (void)removeObserverFromPlayerItem:(AVPlayerItem *)playerItem{
    [playerItem removeObserver:self forKeyPath:@"status"];
    [playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
}


@end
