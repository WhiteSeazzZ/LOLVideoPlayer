//
//  ReturnRowHeightHelper.m
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/2.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "ReturnRowHeightHelper.h"

@implementation ReturnRowHeightHelper

+ (instancetype)shareReturnRowHeightHelper{
    static ReturnRowHeightHelper *returnRowHeightHelper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        returnRowHeightHelper = [[ReturnRowHeightHelper alloc]init];
    });
    return returnRowHeightHelper;
}
//自适应高度 返回高度
- (CGFloat)returnSubTitleHeight:(NSString *)string andFontSize:(NSInteger)fontSize{
    CGRect temp = [string boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 21 - 100, 1000) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    return temp.size.height;
}

@end
