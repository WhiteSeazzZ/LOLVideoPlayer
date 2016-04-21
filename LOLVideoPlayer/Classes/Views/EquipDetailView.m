//
//  EquipDetailView.m
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/5.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "EquipDetailView.h"

@implementation EquipDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initLayout];
    }
    return self;
}

- (void)initLayout{
    
    self.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1];
    
    [self addSubview:self.picImageView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.priceLabel];
    [self addSubview:self.allPriceLabel];
    [self addSubview:self.sellPriceLabel];
    
    [self addSubview:self.valueTitleLabel];
    
    [self addSubview:self.valueLabel];
    
    
    [self addSubview:self.needTitleLabel];
    
    
    [self addSubview:self.composeTitleLabel];
    
    [self addSubview:self.needView];
    [self addSubview:self.composeView];
}



- (UIImageView *)picImageView{
    if (_picImageView == nil) {
        _picImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 80, 80)];
    }
    return _picImageView;
}

- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.picImageView.frame) + 10, CGRectGetMinY(self.picImageView.frame) + 5, self.frame.size.width - 20 * 2 - CGRectGetWidth(self.picImageView.frame) - 10, 25)];
    }
    return _nameLabel;
}

- (UILabel *)priceLabel{
    if (_priceLabel == nil) {
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.nameLabel.frame), CGRectGetMaxY(self.nameLabel.frame) + 5, 65, 15)];
        _priceLabel.font = [UIFont systemFontOfSize:13];
        _priceLabel.textColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1];
    }
    return _priceLabel;
}

- (UILabel *)allPriceLabel{
    if (_allPriceLabel == nil) {
        _allPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.priceLabel.frame) + 2, CGRectGetMinY(self.priceLabel.frame), CGRectGetWidth(self.priceLabel.frame), CGRectGetHeight(self.priceLabel.frame))];
        _allPriceLabel.font = [UIFont systemFontOfSize:13];
        _allPriceLabel.textColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1];
    
    }
    return _allPriceLabel;
}

- (UILabel *)sellPriceLabel{
    if (_sellPriceLabel == nil) {
        _sellPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.allPriceLabel.frame) + 2, CGRectGetMinY(self.allPriceLabel.frame), CGRectGetWidth(self.allPriceLabel.frame), CGRectGetHeight(self.allPriceLabel.frame))];
        _sellPriceLabel.font = [UIFont systemFontOfSize:13];
        _sellPriceLabel.textColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1];
    }
    return _sellPriceLabel;
}

- (UILabel *)valueTitleLabel{
    if (_valueTitleLabel == nil) {
        _valueTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.picImageView.frame) + 15, 100, 25)];
        _valueTitleLabel.text = @"物品属性";
        _valueTitleLabel.font = [UIFont systemFontOfSize:15];
        _valueTitleLabel.textColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1];

    }
    return _valueTitleLabel;
}

- (UILabel *)valueLabel{
    if (_valueLabel == nil) {
        _valueLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.valueTitleLabel.frame) + 7, self.frame.size.width - 30, 30)];
        _valueLabel.backgroundColor = [UIColor whiteColor];
        _valueLabel.font = [UIFont systemFontOfSize:13];
        _valueLabel.layer.cornerRadius = 5;
        _valueLabel.layer.masksToBounds = YES;
        _valueLabel.numberOfLines = NO;
    }
    return _valueLabel;
}

- (UILabel *)needTitleLabel{
    if (_needTitleLabel == nil) {
        _needTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.valueLabel.frame) + 15, 100, 25)];
        _needTitleLabel.text = @"需求";
        _needTitleLabel.font = [UIFont systemFontOfSize:15];
        _needTitleLabel.textColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1];
    }
    return _needTitleLabel;
}

- (UIView *)needView{
    if (_needView == nil) {
        _needView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.valueLabel.frame), CGRectGetMaxY(self.needTitleLabel.frame) + 7, CGRectGetWidth(self.valueLabel.frame), 20)];
        _needView.backgroundColor = [UIColor whiteColor];
        _needView.layer.cornerRadius = 5;
        _needView.layer.masksToBounds = YES;
    }
    return _needView;
}

- (UILabel *)composeTitleLabel{
    if (_composeTitleLabel == nil) {
        _composeTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.needView.frame) + 15, 100, 25)];
        _composeTitleLabel.text = @"可合成";
        _composeTitleLabel.font = [UIFont systemFontOfSize:15];
        _composeTitleLabel.textColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1];
    }
    return _composeTitleLabel;
}

- (UIView *)composeView{
    if (_composeView == nil) {
        _composeView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.needView.frame), CGRectGetMaxY(self.composeTitleLabel.frame) + 7, CGRectGetWidth(self.needView.frame), 20)];
        _composeView.backgroundColor = [UIColor whiteColor];
        _composeView.layer.cornerRadius = 5;
        _composeView.layer.masksToBounds = YES;

    }
    return _composeView;

}



@end
