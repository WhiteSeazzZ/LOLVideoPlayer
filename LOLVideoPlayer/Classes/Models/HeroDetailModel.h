//
//  HeroDetail.h
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/7.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeroDetailModel : NSObject

@property (nonatomic,copy)NSString *armorBase;
@property (nonatomic,copy)NSString *armorLevel;
@property (nonatomic,copy)NSString *attackBase;
@property (nonatomic,copy)NSString *attackLevel;
@property (nonatomic,copy)NSString *criticalChanceBase;
@property (nonatomic,copy)NSString *criticalChanceLevel;
@property (nonatomic,copy)NSString *descriptions;
@property (nonatomic,copy)NSString *displayName;
@property (nonatomic,strong)NSArray *hate;
@property (nonatomic,copy)NSString *healthBase;
@property (nonatomic,copy)NSString *healthLevel;
@property (nonatomic,copy)NSString *healthRegenBase;
@property (nonatomic,copy)NSString *healthRegenLevel;

@property (nonatomic,copy)NSString *iconPath;
@property (nonatomic,copy)NSString *Id;

@property (nonatomic,strong)NSArray *like;

@property (nonatomic,copy)NSString *magicResistBase;
@property (nonatomic,copy)NSString *magicResistLevel;
@property (nonatomic,copy)NSString *manaBase;
@property (nonatomic,copy)NSString *manaLevel;
@property (nonatomic,copy)NSString *manaRegenBase;
@property (nonatomic,copy)NSString *manaRegenLevel;
@property (nonatomic,copy)NSString *moveSpeed;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *opponentTips;
@property (nonatomic,copy)NSString *portraitPath;

@property (nonatomic,copy)NSString *price;
@property (nonatomic,copy)NSString *range;
@property (nonatomic,copy)NSString *ratingAttack;
@property (nonatomic,copy)NSString *ratingDefense;

@property (nonatomic,copy)NSString *ratingDifficulty;
@property (nonatomic,copy)NSString *ratingMagic;
@property (nonatomic,copy)NSString *tips;
@property (nonatomic,copy)NSString *tags;
@property (nonatomic,copy)NSString *title;


@end
