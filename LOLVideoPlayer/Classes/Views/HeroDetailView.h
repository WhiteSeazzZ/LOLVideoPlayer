//
//  HeroDetailView.h
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/7.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeroDetailView : UIView

@property (nonatomic,strong)UIScrollView *pageScrollView;

@property (nonatomic,strong)UIImageView *heroImageView;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *heroTypeLabel;
@property (nonatomic,strong)UILabel *valueLabel;

@property (nonatomic,strong)UILabel *skillTitleLabel;

@property (nonatomic,strong)UILabel *skillDetailLabel;

@property (nonatomic,strong)UILabel *bestCooperateTitleLabel;

@property (nonatomic,strong)UIView *cooperateView;

@property (nonatomic,strong)UIImageView *cooperate1ImageView;
@property (nonatomic,strong)UILabel *cooperate1DesLabel;
@property (nonatomic,strong)UIImageView *cooperate2ImageView;
@property (nonatomic,strong)UILabel *cooperate2DesLabel;

@property (nonatomic,strong)UILabel *bestRestrainTitleLabel;

@property (nonatomic,strong)UIView *restrainView;

@property (nonatomic,strong)UIImageView *restrain1ImageView;
@property (nonatomic,strong)UILabel *restrain1DesLabel;
@property (nonatomic,strong)UIImageView *restrain2ImageView;
@property (nonatomic,strong)UILabel *restrain2DesLabel;

@property (nonatomic,strong)UILabel *useTitleLabel;
@property (nonatomic,strong)UILabel *useLabel;

@property (nonatomic,strong)UILabel *replyTitleLabel;
@property (nonatomic,strong)UILabel *replyLabel;

@property (nonatomic,strong)UIView *heroDataView;

@property (nonatomic,strong)UILabel *levelLabel;
@property (nonatomic,strong)UISlider *levelSlider;

@property (nonatomic,strong)UILabel *rangeLabel;
@property (nonatomic,strong)UILabel *moveSpeedLabel;
@property (nonatomic,strong)UILabel *attackBaseLabel;
@property (nonatomic,strong)UILabel *armorLabel;
@property (nonatomic,strong)UILabel *manaLabel;
@property (nonatomic,strong)UILabel *healthLabel;
@property (nonatomic,strong)UILabel *criticalChanceLabel;
@property (nonatomic,strong)UILabel *manaRegenLabel;
@property (nonatomic,strong)UILabel *healthRegenLabel;
@property (nonatomic,strong)UILabel *magicResistLabel;

@property (nonatomic,strong)UILabel *desLabel;





@end
