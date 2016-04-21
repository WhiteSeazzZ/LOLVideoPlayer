//
//  HeroDetail.m
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/7.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "HeroDetailModel.h"

@implementation HeroDetailModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"description"]) {
        self.descriptions = value;
    }
    if ([key isEqualToString:@"id"]) {
        self.Id = value;
    }
}

@end
