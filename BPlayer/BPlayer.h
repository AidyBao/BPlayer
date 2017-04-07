//
//  BPlayer.h
//  BPlayer
//
//  Created by 120v on 2017/4/7.
//  Copyright © 2017年 120v. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPlayer : UIView

/**
 设置播放信息
 
 @param url 视频播放地址
 */
- (void)m_playWithURL:(NSURL *)url;

/**
 播放
 */
- (void)m_play;

/**
 暂停
 */
- (void)m_pause;

/**
 移除通知
 */
+ (void)removeNotification;


@end
