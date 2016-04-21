//
//  GetDateHelper.h
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/2.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetDateHelper : NSObject

+ (instancetype)shareGetDateHelper;
- (NSString *)getDateWithTimeString:(NSString *)string;
@end
