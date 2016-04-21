//
//  Topic.h
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/2.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopicModel : NSObject

@property (nonatomic,copy)NSString *content;
@property (nonatomic,copy)NSString *photo;
@property (nonatomic,strong)NSMutableArray *news;

@end
