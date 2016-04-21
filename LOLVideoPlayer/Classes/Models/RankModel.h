//
//  RankModel.h
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/6.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RankModel : NSObject

@property (nonatomic,copy)NSString *nameCN;
@property (nonatomic,copy)NSString *nameUS;
@property (nonatomic,assign)CGFloat presentRate;
@property (nonatomic,copy)NSString *titleCN;
@property (nonatomic,assign)NSInteger totalPresent;
@property (nonatomic,assign)CGFloat winRate;

@end
