//
//  BAVPlayerViewController.m
//  BPlayer
//
//  Created by 120v on 2017/4/10.
//  Copyright © 2017年 120v. All rights reserved.
//

#import "BAVPlayerViewController.h"

@interface BAVPlayerViewController ()<AVPlayerViewControllerDelegate>

@property (nonatomic, strong) AVAudioSession *audioSession;

@end

@implementation BAVPlayerViewController


-(void)awakeFromNib{
    [super awakeFromNib];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //1.网络视频的url
    NSString *playString = @"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4";
    //视频播放的url
    NSURL *playerURL = [NSURL URLWithString:playString];
    
    //2.本地视频的url，
    /*此处不能使用：URLWithString:"" 方法来获取url实例*/
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"movie.mov" ofType:nil];
//    NSURL *url = [NSURL fileURLWithPath:path];

    
    //通过AVPlayerItem创建AVPlayer
    self.player = [AVPlayer playerWithURL:playerURL];
    
    [self.player play];
    
    self.audioSession = [AVAudioSession sharedInstance];
    [self.audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    
}


//将要开始画中画时调用的方法
- (void)playerViewControllerWillStartPictureInPicture:(AVPlayerViewController *)playerViewController{
    NSLog(@"%s",__func__);
}
//已经开始画中画时调用的方法
- (void)playerViewControllerDidStartPictureInPicture:(AVPlayerViewController *)playerViewController{
    NSLog(@"%s",__func__);
}
//开始画中画失败调用的方法
- (void)playerViewController:(AVPlayerViewController *)playerViewController failedToStartPictureInPictureWithError:(NSError *)error{
    NSLog(@"%s",__func__);
}
//将要停止画中画时调用的方法
- (void)playerViewControllerWillStopPictureInPicture:(AVPlayerViewController *)playerViewController{
    NSLog(@"%s",__func__);
}
//已经停止画中画时调用的方法
- (void)playerViewControllerDidStopPictureInPicture:(AVPlayerViewController *)playerViewController{
    NSLog(@"%s",__func__);
}
//是否在开始画中画时自动将当前的播放界面dismiss掉 返回YES则自动dismiss 返回NO则不会自动dismiss
- (BOOL)playerViewControllerShouldAutomaticallyDismissAtPictureInPictureStart:(AVPlayerViewController *)playerViewController{
    return YES;
}
//用户点击还原按钮 从画中画模式还原回app内嵌模式时调用的方法
- (void)playerViewController:(AVPlayerViewController *)playerViewController restoreUserInterfaceForPictureInPictureStopWithCompletionHandler:(void (^)(BOOL restored))completionHandler{
    NSLog(@"%s",__func__);
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*AVPlayerViewController属性说明
 

//是否显示视频播放控制控件
@property (nonatomic) BOOL showsPlaybackControls;
//设置视频播放界面的尺寸缩放选项
/*
 可以设置的值及意义如下：
 AVLayerVideoGravityResizeAspect   不进行比例缩放 以宽高中长的一边充满为基准
 AVLayerVideoGravityResizeAspectFill 不进行比例缩放 以宽高中短的一边充满为基准
 AVLayerVideoGravityResize     进行缩放充满屏幕
 */

/*
@property (nonatomic, copy) NSString *videoGravity;
//获取是否已经准备好开始播放
@property (nonatomic, readonly, getter = isReadyForDisplay) BOOL readyForDisplay;
//获取视频播放界面的尺寸
@property (nonatomic, readonly) CGRect videoBounds;
//视频播放器的视图 自定义的控件可以添加在其上
@property (nonatomic, readonly, nullable) UIView *contentOverlayView;
//画中画代理 iOS9后可用
@property (nonatomic, weak, nullable) id <AVPlayerViewControllerDelegate> delegate NS_AVAILABLE_IOS(9_0);
//是否支持画中画 iOS9后可用 默认支持
@property (nonatomic) BOOL allo

*/

@end
