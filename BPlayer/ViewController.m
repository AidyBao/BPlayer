//
//  ViewController.m
//  BPlayer
//
//  Created by 120v on 2017/4/7.
//  Copyright © 2017年 120v. All rights reserved.
//

#import "ViewController.h"

#import "BPlayer.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@property (nonatomic, strong)BPlayer *bPlayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BPlayer *bPlayer = [[BPlayer alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 250)];
    self.bPlayer = bPlayer;
    bPlayer.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:bPlayer];
    
    [self.bPlayer m_playWithURL:[NSURL URLWithString:@"http://znf.oss-cn-shanghai.aliyuncs.com/course/znf2017031401/znf2017031401001.mp4"]];

    

}


- (IBAction)playAction:(UIButton *)sender {
    [self.bPlayer m_play];
}


- (IBAction)stopAction:(UIButton *)sender {
    [self.bPlayer m_pause];
}


-(void)dealloc{
    [BPlayer removeNotification];
}



@end
