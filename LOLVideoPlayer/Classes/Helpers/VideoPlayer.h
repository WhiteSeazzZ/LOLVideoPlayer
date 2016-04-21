//
//  VideoPlayer.h
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/2.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface VideoPlayer : NSObject

@property (nonatomic,strong)AVPlayerViewController *moviePlayer;

+ (instancetype)shareVideoPlayer;

- (void)playWithUrlString:(NSString *)urlString andTarget:(UIViewController *)viewController;

@end
