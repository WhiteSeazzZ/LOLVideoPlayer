//
//  VideoDetailViewController.h
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/4.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoAndEventView.h"

@interface VideoDetailViewController : UIViewController

@property (nonatomic,strong)VideoAndEventView *videoAndEventView;
@property (nonatomic,copy)NSString *tag;

@end