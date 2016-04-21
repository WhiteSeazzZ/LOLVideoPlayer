//
//  HeroDetailView.m
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/7.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "HeroDetailView.h"

#define margin 11.0

@implementation HeroDetailView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
        [self initLayout];
    }
    return self;
}

- (void)initLayout{
    [self addSubview:self.pageScrollView];
    
    
    
}

- (UIScrollView *)pageScrollView{
    if (_pageScrollView == nil) {
        _pageScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 64)];
        [_pageScrollView addSubview:self.heroImageView];
        [_pageScrollView addSubview:self.nameLabel];
        [_pageScrollView addSubview:self.heroTypeLabel];

        [_pageScrollView addSubview:self.valueLabel];
        [_pageScrollView addSubview:self.skillTitleLabel];
        [_pageScrollView addSubview:self.skillDetailLabel];
        [_pageScrollView addSubview:self.bestCooperateTitleLabel];
        [_pageScrollView addSubview:self.cooperateView];
        [_pageScrollView addSubview:self.bestRestrainTitleLabel];
        [_pageScrollView addSubview:self.restrainView];
        [_pageScrollView addSubview:self.useTitleLabel];
        [_pageScrollView addSubview:self.useLabel];
        [_pageScrollView addSubview:self.replyTitleLabel];
        [_pageScrollView addSubview:self.replyLabel];
        [_pageScrollView addSubview:self.heroDataView];
        [_pageScrollView addSubview:self.desLabel];
    }
    return _pageScrollView;
}

-(UIImageView *)heroImageView{
    if (_heroImageView == nil) {
        _heroImageView = [[UIImageView alloc]initWithFrame:CGRectMake(margin, margin, 70, 70)];
        
    }
    return _heroImageView;
}

- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.heroImageView.frame) + margin, CGRectGetMinY(self.heroImageView.frame) + 2, 150, 20)];
    }
    return _nameLabel;
}

- (UILabel *)heroTypeLabel{
    if (_heroTypeLabel == nil) {
        _heroTypeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.heroImageView.frame) + margin, CGRectGetMaxY(self.nameLabel.frame) + 2, 150, 15)];
        _heroTypeLabel.font = [UIFont systemFontOfSize:13];
        _heroTypeLabel.textColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1];
    }
    return _heroTypeLabel;
}

- (UILabel *)valueLabel{
    if (_valueLabel == nil) {
        _valueLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.heroImageView.frame) + margin, CGRectGetMaxY(self.heroTypeLabel.frame) + 2, 140, 15)];
        _valueLabel.font = [UIFont systemFontOfSize:12];
        _valueLabel.textColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1];
    }
    return _valueLabel;
}

- (UILabel *)skillTitleLabel{
    if (_skillTitleLabel == nil) {
        _skillTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(margin, CGRectGetMaxY(self.heroImageView.frame) + 10, 200, 25)];
        _skillTitleLabel.font = [UIFont systemFontOfSize:14];
        _skillTitleLabel.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
        _skillTitleLabel.text = @"技能介绍(点击图标查看详情)";
    }
    return _skillTitleLabel;
}

- (UILabel *)skillDetailLabel{
    if (_skillDetailLabel == nil) {
        _skillDetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(margin, CGRectGetMaxY(self.skillTitleLabel.frame) + 70, self.frame.size.width - margin * 2, 70)];
        _skillDetailLabel.font = [UIFont systemFontOfSize:13];
        _skillDetailLabel.numberOfLines = 0;
        _skillDetailLabel.backgroundColor = [UIColor whiteColor];
        _skillDetailLabel.layer.cornerRadius = 3;
        _skillDetailLabel.layer.masksToBounds = YES;
    }
    return _skillDetailLabel;
}

- (UILabel *)bestCooperateTitleLabel{
    if (_bestCooperateTitleLabel == nil) {
        _bestCooperateTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(margin, CGRectGetMaxY(self.skillDetailLabel.frame) + 10, 70, 20)];
        _bestCooperateTitleLabel.text = @"最佳搭档";
        _bestCooperateTitleLabel.font = [UIFont systemFontOfSize:14];
        _bestCooperateTitleLabel.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
    }
    return _bestCooperateTitleLabel;
}

- (UIView *)cooperateView{
    if (_cooperateView == nil) {
        _cooperateView = [[UIView alloc]initWithFrame:CGRectMake(margin, CGRectGetMaxY(self.bestCooperateTitleLabel.frame), self.frame.size.width - margin * 2, 100)];
        _cooperateView.layer.cornerRadius = 3;
        _cooperateView.layer.masksToBounds = YES;
        [_cooperateView addSubview:self.cooperate1ImageView];
        [_cooperateView addSubview:self.cooperate1DesLabel];
        [_cooperateView addSubview:self.cooperate2ImageView];
        [_cooperateView addSubview:self.cooperate2DesLabel];
        _cooperateView.backgroundColor = [UIColor whiteColor];
        
    }
    return _cooperateView;
}

- (UIImageView *)cooperate1ImageView{
    if (_cooperate1ImageView == nil) {
        _cooperate1ImageView = [[UIImageView alloc]initWithFrame:CGRectMake(margin, margin, 45, 45)];
        _cooperate1ImageView.userInteractionEnabled = YES;
    }
    return _cooperate1ImageView;
}

- (UILabel *)cooperate1DesLabel{
    if (_cooperate1DesLabel == nil) {
        _cooperate1DesLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.cooperate1ImageView.frame) + 5, CGRectGetMinY(self.cooperate1ImageView.frame), self.frame.size.width - margin * 2 - CGRectGetWidth(self.cooperate1ImageView.frame) - 5, 50)];
        _cooperate1DesLabel.font = [UIFont systemFontOfSize:13];
        _cooperate1DesLabel.textColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1];
        _cooperate1DesLabel.numberOfLines = 0;
    }
    return _cooperate1DesLabel;
}

- (UIImageView *)cooperate2ImageView{
    if (_cooperate2ImageView == nil) {
        _cooperate2ImageView = [[UIImageView alloc]initWithFrame:CGRectMake(margin, CGRectGetMaxY(self.cooperate1DesLabel.frame) + 2, 45, 45)];
        _cooperate2ImageView.userInteractionEnabled = YES;
    }
    return _cooperate2ImageView;
}

- (UILabel *)cooperate2DesLabel{
    if (_cooperate2DesLabel == nil) {
        _cooperate2DesLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.cooperate2ImageView.frame) + 5, CGRectGetMinY(self.cooperate2ImageView.frame), CGRectGetWidth(self.cooperate1DesLabel.frame), 50)];
        _cooperate2DesLabel.font = [UIFont systemFontOfSize:13];
        _cooperate2DesLabel.textColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1];
        _cooperate2DesLabel.numberOfLines = 0;
    }
    return _cooperate2DesLabel;
}

- (UILabel *)bestRestrainTitleLabel{
    if (_bestRestrainTitleLabel == nil) {
        _bestRestrainTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(margin, CGRectGetMaxY(self.cooperateView.frame) + margin, 70, 20)];
        _bestRestrainTitleLabel.text = @"最佳克制";
        _bestRestrainTitleLabel.font = [UIFont systemFontOfSize:14];
        _bestRestrainTitleLabel.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
        
    }
    return _bestRestrainTitleLabel;
}

- (UIView *)restrainView{
    if (_restrainView == nil) {
        _restrainView = [[UIView alloc]initWithFrame:CGRectMake(margin, CGRectGetMaxY(self.bestRestrainTitleLabel.frame), self.frame.size.width - margin * 2, 100)];
        [_restrainView addSubview:self.restrain1ImageView];
        [_restrainView addSubview:self.restrain1DesLabel];
        [_restrainView addSubview:self.restrain2ImageView];
        [_restrainView addSubview:self.restrain2DesLabel];
        _restrainView.layer.cornerRadius = 3;
        _restrainView.layer.masksToBounds = YES;
        _restrainView.backgroundColor = [UIColor whiteColor];
    }
    return _restrainView;
}

- (UIImageView *)restrain1ImageView{
    if (_restrain1ImageView == nil) {
        _restrain1ImageView = [[UIImageView alloc]initWithFrame:CGRectMake(margin, margin, 45, 45)];
        _restrain1ImageView.userInteractionEnabled = YES;
    }
    return _restrain1ImageView;
}

- (UILabel *)restrain1DesLabel{
    if (_restrain1DesLabel == nil) {
        _restrain1DesLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.restrain1ImageView.frame) + 5, CGRectGetMinY(self.restrain1ImageView.frame), self.frame.size.width - margin * 2 - CGRectGetWidth(self.restrain1ImageView.frame) - 5, 50)];
        _restrain1DesLabel.font = [UIFont systemFontOfSize:13];
        _restrain1DesLabel.textColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1];
        _restrain1DesLabel.numberOfLines = 0;
    }
    return _restrain1DesLabel;
}

- (UIImageView *)restrain2ImageView{
    if (_restrain2ImageView == nil) {
        _restrain2ImageView = [[UIImageView alloc]initWithFrame:CGRectMake(margin, CGRectGetMaxY(self.restrain1DesLabel.frame) + 2, 45, 45)];
        _restrain2ImageView.userInteractionEnabled = YES;
    }
    return _restrain2ImageView;
}

- (UILabel *)restrain2DesLabel{
    if (_restrain2DesLabel == nil) {
        _restrain2DesLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.restrain2ImageView.frame) + 5, CGRectGetMinY(self.restrain2ImageView.frame), CGRectGetWidth(self.restrain2ImageView.frame), 50)];
        _restrain2DesLabel.font = [UIFont systemFontOfSize:13];
        _restrain2DesLabel.textColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1];
        _restrain2DesLabel.numberOfLines = 0;
    }
    return _restrain2DesLabel;
}

- (UILabel *)useTitleLabel{
    if (_useTitleLabel == nil) {
        _useTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(margin, CGRectGetMaxY(self.restrainView.frame) + 10, 30, 20)];
        _useTitleLabel.text = @"使用";
        _useTitleLabel.font = [UIFont systemFontOfSize:14];
        _useTitleLabel.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
    }
    return _useTitleLabel;
}

- (UILabel *)useLabel{
    if (_useLabel == nil) {
        _useLabel = [[UILabel alloc]initWithFrame:CGRectMake(margin, CGRectGetMaxY(self.useTitleLabel.frame) + 5, self.frame.size.width - margin * 2, 100)];
        _useLabel.font = [UIFont systemFontOfSize:13];
        _useLabel.numberOfLines = 0;
        _useLabel.backgroundColor = [UIColor whiteColor];
        _useLabel.layer.cornerRadius = 3;
        _useLabel.layer.masksToBounds = YES;

    }
    return _useLabel;
}

- (UILabel *)replyTitleLabel{
    if (_replyTitleLabel == nil) {
        _replyTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(margin, CGRectGetMaxY(self.useLabel.frame) + 10, 30, 20)];
        _replyTitleLabel.text = @"应对";
        _replyTitleLabel.font = [UIFont systemFontOfSize:14];
        _replyTitleLabel.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
    }
    return _replyTitleLabel;
}
- (UILabel *)replyLabel{
    if (_replyLabel == nil) {
        _replyLabel = [[UILabel alloc]initWithFrame:CGRectMake(margin, CGRectGetMaxY(self.replyTitleLabel.frame) + 5, self.frame.size.width - margin * 2, 100)];
        _replyLabel.font = [UIFont systemFontOfSize:13];
        _replyLabel.numberOfLines = 0;
        _replyLabel.backgroundColor = [UIColor whiteColor];
        _replyLabel.layer.cornerRadius = 3;
        _replyLabel.layer.masksToBounds = YES;
    }
    return _replyLabel;
}

- (UIView *)heroDataView{
    if (_heroDataView == nil) {
        _heroDataView = [[UIView alloc]initWithFrame:CGRectMake(margin, CGRectGetMaxY(self.replyLabel.frame) + 15, self.frame.size.width - margin * 2, 260)];
        _heroDataView.backgroundColor = [UIColor whiteColor];
        _heroDataView.layer.cornerRadius = 3;
        _heroDataView.layer.masksToBounds = YES;

        [_heroDataView addSubview:self.levelLabel];
        [_heroDataView addSubview:self.levelSlider];
        [_heroDataView addSubview:self.rangeLabel];
        [_heroDataView addSubview:self.moveSpeedLabel];
        [_heroDataView addSubview:self.attackBaseLabel];
        [_heroDataView addSubview:self.armorLabel];
        [_heroDataView addSubview:self.manaLabel];
        [_heroDataView addSubview:self.healthLabel];
        [_heroDataView addSubview:self.criticalChanceLabel];
        [_heroDataView addSubview:self.manaRegenLabel];
        [_heroDataView addSubview:self.healthRegenLabel];
        [_heroDataView addSubview:self.magicResistLabel];
    }
    return _heroDataView;
}

- (UILabel *)levelLabel{
    if (_levelLabel == nil) {
        _levelLabel = [[UILabel alloc]initWithFrame:CGRectMake(margin, 10, 60, 25)];
//        _levelLabel.textAlignment = NSTextAlignmentCenter;
        _levelLabel.font = [UIFont systemFontOfSize:16];
    }
    return _levelLabel;
}

- (UISlider *)levelSlider{
    if (_levelSlider == nil) {
        _levelSlider = [[UISlider alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.levelLabel.frame) + 10, 10, self.heroDataView.frame.size.width - 80 - margin * 3, 25)];
        _levelSlider.maximumValue = 18;
        _levelSlider.minimumValue = 1;
        
    }
    return _levelSlider;
}

- (UILabel *)rangeLabel{
    if (_rangeLabel == nil) {
        _rangeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.levelLabel.frame) + 5, 200, 20)];
        _rangeLabel.font = [UIFont systemFontOfSize:14];
    }
    return _rangeLabel;
}

- (UILabel *)moveSpeedLabel{
    if (_moveSpeedLabel == nil) {
        _moveSpeedLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.rangeLabel.frame) + 2, 200, 20)];
        _moveSpeedLabel.font = [UIFont systemFontOfSize:14];
    }
    return _moveSpeedLabel;
}

- (UILabel *)attackBaseLabel{
    if (_attackBaseLabel == nil) {
        _attackBaseLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.moveSpeedLabel.frame) + 2, 200, 20)];
        _attackBaseLabel.font = [UIFont systemFontOfSize:14];
    }
    return _attackBaseLabel;
}

- (UILabel *)armorLabel{
    if (_armorLabel == nil) {
        _armorLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.attackBaseLabel.frame) + 2, 200, 20)];
        _armorLabel.font = [UIFont systemFontOfSize:14];
    }
    return _armorLabel;
}

- (UILabel *)manaLabel{
    if (_manaLabel == nil) {
        _manaLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.armorLabel.frame) + 2, 200, 20)];
        _manaLabel.font = [UIFont systemFontOfSize:14];
    }
    return _manaLabel;
}

- (UILabel *)healthLabel{
    if (_healthLabel == nil) {
        _healthLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.manaLabel.frame) + 2, 200, 20)];
        _healthLabel.font = [UIFont systemFontOfSize:14];
    }
    return _healthLabel;
}

- (UILabel *)criticalChanceLabel{
    if (_criticalChanceLabel == nil) {
        _criticalChanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.healthLabel.frame) + 2, 200, 20)];
        _criticalChanceLabel.font = [UIFont systemFontOfSize:14];
    }
    return _criticalChanceLabel;
}

- (UILabel *)manaRegenLabel{
    if (_manaRegenLabel == nil) {
        _manaRegenLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.criticalChanceLabel.frame) + 2, 200, 20)];
        _manaRegenLabel.font = [UIFont systemFontOfSize:14];
    }
    return _manaRegenLabel;
}

- (UILabel *)healthRegenLabel{
    if (_healthRegenLabel == nil) {
        _healthRegenLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.manaRegenLabel.frame) + 2, 200, 20)];
        _healthRegenLabel.font = [UIFont systemFontOfSize:14];
    }
    return _healthRegenLabel;
}

- (UILabel *)magicResistLabel{
    if (_magicResistLabel == nil) {
        _magicResistLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.healthRegenLabel.frame) + 2, 200, 20)];
        _magicResistLabel.font = [UIFont systemFontOfSize:14];
    }
    return _magicResistLabel;
}

- (UILabel *)desLabel{
    if (_desLabel == nil) {
        _desLabel = [[UILabel alloc]initWithFrame:CGRectMake(margin, CGRectGetMaxY(self.heroDataView.frame) + 15, self.frame.size.width - margin * 2, 100)];
        _desLabel.font = [UIFont systemFontOfSize:13];
        _desLabel.numberOfLines = 0;
        _desLabel.backgroundColor = [UIColor whiteColor];
        _desLabel.layer.cornerRadius = 3;
        _desLabel.layer.masksToBounds = YES;
    }
    return _desLabel;
}












@end
