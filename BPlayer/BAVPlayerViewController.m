//
//  BAVPlayerViewController.m
//  BPlayer
//
//  Created by 120v on 2017/4/10.
//  Copyright © 2017年 120v. All rights reserved.
//

#import "BAVPlayerViewController.h"

@interface BAVPlayerViewController ()

@end

@implementation BAVPlayerViewController


-(void)awakeFromNib{
    [super awakeFromNib];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *playString = @"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4";
    
    //视频播放的url
    NSURL *playerURL = [NSURL URLWithString:playString];
    
    //AVPlayerItem 视频的一些信息  创建AVPlayer使用的
    AVPlayerItem *item = [[AVPlayerItem alloc]initWithURL:playerURL];
    
    //通过AVPlayerItem创建AVPlayer
    self.player = [[AVPlayer alloc]initWithPlayerItem:item];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
