//
//  RequestUrlPlayVideoHelper.h
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/4.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestUrlPlayVideoHelper : NSObject

+ (instancetype)shareRequestUrlPlayVideoHelper;
- (void)requestUrlPlayVideoWithVid:(NSString *)vid andController:(UIViewController *)viewController;

@end
