//
//  EquipDetailModel.m
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/5.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "EquipDetailModel.h"

@implementation EquipDetailModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"description"]) {
        [self setValue:value forKey:@"descriptions"];
    }
    if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"Id"];
    }
}

@end
