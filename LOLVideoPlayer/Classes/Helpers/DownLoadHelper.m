//
//  DownLoadHelper.m
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/8.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "DownLoadHelper.h"

@implementation DownLoadHelper

+ (instancetype)shareDownLoadHelper{
    static DownLoadHelper *downLoadHelper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        downLoadHelper = [[DownLoadHelper alloc]init];
        downLoadHelper.allDownLoadingArray = [NSMutableArray array];
        downLoadHelper.allDownLoadedArray = [NSMutableArray array];
    });
    return downLoadHelper;
}

@end
