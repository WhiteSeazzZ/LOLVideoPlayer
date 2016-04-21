//
//  VideoPlayer.m
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/2.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "VideoPlayer.h"

@implementation VideoPlayer

+ (instancetype)shareVideoPlayer{
    static VideoPlayer *videoPlayer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        videoPlayer = [[VideoPlayer alloc]init];
        videoPlayer.moviePlayer = [[AVPlayerViewController alloc]init];
    });
    return videoPlayer;
}

- (void)playWithUrlString:(NSString *)urlString andTarget:(UIViewController *)viewController{
    
    
    
    self.moviePlayer.player = [[AVPlayer alloc]initWithURL:[NSURL URLWithString:urlString]];
    //打开就为播放状态
    [self.moviePlayer.player play];
    [viewController presentViewController:self.moviePlayer animated:YES completion:nil];
}

@end
