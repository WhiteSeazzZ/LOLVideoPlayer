//
//  ClassifyNavigationDetailModel.h
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/4.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassifyNavigationDetailModel : NSObject

@property (nonatomic,copy)NSString *cover_url;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *upload_time;
@property (nonatomic,copy)NSString *vid;
@property (nonatomic,assign)NSInteger video_length;

@end
