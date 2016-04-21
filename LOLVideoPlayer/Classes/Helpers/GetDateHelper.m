//
//  GetDateHelper.m
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/2.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "GetDateHelper.h"

@implementation GetDateHelper

+ (instancetype)shareGetDateHelper{
    static GetDateHelper *getDateHelper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        getDateHelper = [[GetDateHelper alloc]init];
    });
    return getDateHelper;
}
//解析从网络获取到的时间
- (NSString *)getDateWithTimeString:(NSString *)string{
    //将string转换为整型
    NSInteger time = [string integerValue];
    //当时的时间
    NSDate *oldDate = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM月dd日 HH:mm:ss"];
    //转化为字符串
    NSString *oldStr = [formatter stringFromDate:oldDate];
    //获取日
    NSString *oldDay = [oldStr substringWithRange:NSMakeRange(oldStr.length - 11, 2)];
    //现在时间
    NSDate *nowDate = [NSDate date];
    NSString *nowStr = [formatter stringFromDate:nowDate];
    //今天
    NSString *nowDay = [nowStr substringWithRange:NSMakeRange(nowStr.length - 11, 2)];
    //取出间隔时间
    NSTimeInterval timeInterval = [nowDate timeIntervalSinceDate:oldDate];
    if (timeInterval / 60 < 60) {
        return [@"" stringByAppendingFormat:@"%.f分钟前",timeInterval / 60];
    }else if ([nowDay integerValue] - [oldDay integerValue] == 0){
        return [@"今天" stringByAppendingFormat:@"%@",[oldStr substringWithRange:NSMakeRange(oldStr.length - 8, 5)]];
    }else{
        return [oldStr substringWithRange:NSMakeRange(5, 12)];
    }
    
}

@end
