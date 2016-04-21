//
//  GetDocumentsPathHelper.h
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/7.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetDocumentsPathHelper : NSObject

+ (instancetype)shareGetDocumentsPathHelper;

- (NSString *)getDocumentsPath;

@end
