//
//  GetDocumentsPathHelper.m
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/7.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "GetDocumentsPathHelper.h"

@implementation GetDocumentsPathHelper

+ (instancetype)shareGetDocumentsPathHelper{
    static GetDocumentsPathHelper *getDocumentsPathHelper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        getDocumentsPathHelper = [[GetDocumentsPathHelper alloc]init];
    });
    return getDocumentsPathHelper;
}

- (NSString *)getDocumentsPath{
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    documentsPath = [documentsPath stringByAppendingPathComponent:@"videoPlayer.sqlite"];
    return documentsPath;
}

@end
