//
//  DownLoadHelper.h
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/8.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownLoadHelper : NSObject

@property (nonatomic,strong)NSMutableArray *allDownLoadingArray;
@property (nonatomic,strong)NSMutableArray *allDownLoadedArray;

+ (instancetype)shareDownLoadHelper;

@end
