//
//  RequestUrlPlayVideoHelper.m
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/4.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "RequestUrlPlayVideoHelper.h"
#import "VideoPlayer.h"

@implementation RequestUrlPlayVideoHelper

+ (instancetype)shareRequestUrlPlayVideoHelper{
    static RequestUrlPlayVideoHelper *requestUrlPlayVideoHelper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        requestUrlPlayVideoHelper = [[RequestUrlPlayVideoHelper alloc]init];
    });
    return requestUrlPlayVideoHelper;
}

- (void)requestUrlPlayVideoWithVid:(NSString *)vid andController:(UIViewController *)viewController{
    [[CDHttpHelper defaultCDHttpHelper] get:[videoDetailUrlString stringByAppendingString:vid] params:nil success:^(id responseObj) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObj options:(NSJSONReadingAllowFragments) error:nil];
        NSString *urlString = dic[@"result"][@"items"][@"1000"][@"transcode"][@"urls"][0];
        [[VideoPlayer shareVideoPlayer] playWithUrlString:urlString andTarget:viewController];
        
    } failure:^(NSError *error) {
        
    }];
}

@end
