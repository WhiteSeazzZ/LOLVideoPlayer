//
//  BestGroupDetailView.m
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/5.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "BestGroupDetailView.h"

@implementation BestGroupDetailView

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
        self.backgroundColor = [UIColor whiteColor];
        [self initLayout];
    }
    return self;
}

- (void)initLayout{
    [self addSubview:self.pageScrollView];
    [self.pageScrollView addSubview:self.titleLabel];
    [self.pageScrollView addSubview:self.desTitleLabel];
    [self.pageScrollView addSubview:self.aImageView];
    [self.pageScrollView addSubview:self.bImageView];
    [self.pageScrollView addSubview:self.cImageView];
    [self.pageScrollView addSubview:self.dImageView];
    [self.pageScrollView addSubview:self.eImageView];
    [self.pageScrollView addSubview:self.desLabel];
    [self.pageScrollView addSubview:self.lineView];
    [self.pageScrollView addSubview:self.heroTitleLabel];
    [self.pageScrollView addSubview:self.aImageView2];
    [self.pageScrollView addSubview:self.hero1Label];
    [self.pageScrollView addSubview:self.bImageView2];
    [self.pageScrollView addSubview:self.hero2Label];
    [self.pageScrollView addSubview:self.cImageView2];
    [self.pageScrollView addSubview:self.hero3Label];
    [self.pageScrollView addSubview:self.dImageView2];
    [self.pageScrollView addSubview:self.hero4Label];
    [self.pageScrollView addSubview:self.eImageView2];
    [self.pageScrollView addSubview:self.hero5Label];
}

- (UIScrollView *)pageScrollView{
    if (_pageScrollView == nil) {
        _pageScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 64)];
        
    }
    return _pageScrollView;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width - 20, 45)];
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont systemFontOfSize:17];
    }
    return _titleLabel;
}
- (UILabel *)desTitleLabel{
    if (_desTitleLabel == nil) {
        _desTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.titleLabel.frame), CGRectGetMaxY(self.titleLabel.frame) + 10, 100, 20)];
        _desTitleLabel.text = @"阵容介绍";
        _desTitleLabel.textColor = [UIColor colorWithRed:0.2 green:0.3 blue:0.8 alpha:1];
        _desTitleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _desTitleLabel;
}

- (UIImageView *)aImageView{
    if (_aImageView == nil) {
        _aImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.titleLabel.frame), CGRectGetMaxY(self.desTitleLabel.frame) + 10, 50, 50)];
        _aImageView.userInteractionEnabled = YES;
    }
    return _aImageView;
    
}
- (UIImageView *)bImageView{
    if (_bImageView == nil) {
        _bImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.aImageView.frame) + 7, CGRectGetMaxY(self.desTitleLabel.frame) + 10, 50, 50)];
        _bImageView.userInteractionEnabled = YES;
    }
    return _bImageView;
    
}
- (UIImageView *)cImageView{
    if (_cImageView == nil) {
        _cImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.bImageView.frame) + 7, CGRectGetMaxY(self.desTitleLabel.frame) + 10, 50, 50)];
        _cImageView.userInteractionEnabled = YES;
    }
    return _cImageView;
    
}
- (UIImageView *)dImageView{
    if (_dImageView == nil) {
        _dImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.cImageView.frame) + 7, CGRectGetMaxY(self.desTitleLabel.frame) + 10, 50, 50)];
        _dImageView.userInteractionEnabled = YES;
    }
    return _dImageView;
    
}
- (UIImageView *)eImageView{
    if (_eImageView == nil) {
        _eImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.dImageView.frame) + 7, CGRectGetMaxY(self.desTitleLabel.frame) + 10, 50, 50)];
        _eImageView.userInteractionEnabled = YES;
    }
    return _eImageView;
    
}

- (UILabel *)desLabel{
    if (_desLabel == nil) {
        _desLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.titleLabel.frame), CGRectGetMaxY(self.aImageView.frame) + 10, [UIScreen mainScreen].bounds.size.width - 20, 50)];
        _desLabel.font = [UIFont systemFontOfSize:13];
        _desLabel.numberOfLines = 0;
        _desLabel.textColor = [UIColor colorWithRed:0.05 green:0.05 blue:0.05 alpha:1];
    }
    return _desLabel;
}

- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.desLabel.frame) + 10, [UIScreen mainScreen].bounds.size.width, 5)];
        _lineView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    }
    return _lineView;
}

- (UILabel *)heroTitleLabel{
    if (_heroTitleLabel == nil) {
        _heroTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.titleLabel.frame), CGRectGetMaxY(self.lineView.frame) + 10, 100, 20)];
        _heroTitleLabel.text = @"阵容英雄";
        _heroTitleLabel.textColor = [UIColor colorWithRed:0.2 green:0.3 blue:0.8 alpha:1];
        _heroTitleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _heroTitleLabel;
}

- (UIImageView *)aImageView2{
    if (_aImageView2 == nil) {
        _aImageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.titleLabel.frame), CGRectGetMaxY(self.heroTitleLabel.frame) + 10, 50, 50)];
        _aImageView2.userInteractionEnabled = YES;
    }
    return _aImageView2;
}

- (UILabel *)hero1Label{
    if (_hero1Label == nil) {
        _hero1Label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.aImageView2.frame) + 5, CGRectGetMinY(self.aImageView2.frame), [UIScreen mainScreen].bounds.size.width - 75, 100)];
        _hero1Label.font = [UIFont systemFontOfSize:12];
        _hero1Label.textColor = [UIColor colorWithRed:0.05 green:0.05 blue:0.05 alpha:1];
        _hero1Label.numberOfLines = 0;
    }
    return _hero1Label;
}

- (UIImageView *)bImageView2{
    if (_bImageView2 == nil) {
        _bImageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.titleLabel.frame), CGRectGetMaxY(self.hero1Label.frame) + 10, 50, 50)];
        _bImageView2.userInteractionEnabled = YES;
    }
    return _bImageView2;
}

- (UILabel *)hero2Label{
    if (_hero2Label == nil) {
        _hero2Label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.aImageView2.frame) + 5, CGRectGetMinY(self.bImageView2.frame), [UIScreen mainScreen].bounds.size.width - 75, 100)];
        _hero2Label.font = [UIFont systemFontOfSize:12];
        _hero2Label.textColor = [UIColor colorWithRed:0.05 green:0.05 blue:0.05 alpha:1];
        _hero2Label.numberOfLines = 0;
    }
    return _hero2Label;
}

- (UIImageView *)cImageView2{
    if (_cImageView2 == nil) {
        _cImageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.titleLabel.frame), CGRectGetMaxY(self.hero2Label.frame) + 10, 50, 50)];
        _cImageView2.userInteractionEnabled = YES;
    }
    return _cImageView2;
}

- (UILabel *)hero3Label{
    if (_hero3Label == nil) {
        _hero3Label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.aImageView2.frame) + 5, CGRectGetMinY(self.cImageView2.frame), [UIScreen mainScreen].bounds.size.width - 75, 100)];
        _hero3Label.font = [UIFont systemFontOfSize:12];
        _hero3Label.textColor = [UIColor colorWithRed:0.05 green:0.05 blue:0.05 alpha:1];
        _hero3Label.numberOfLines = 0;
    }
    return _hero3Label;
}

- (UIImageView *)dImageView2{
    if (_dImageView2 == nil) {
        _dImageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.titleLabel.frame), CGRectGetMaxY(self.hero3Label.frame) + 10, 50, 50)];
        _dImageView2.userInteractionEnabled = YES;
    }
    return _dImageView2;
}

- (UILabel *)hero4Label{
    if (_hero4Label == nil) {
        _hero4Label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.aImageView2.frame) + 5, CGRectGetMinY(self.dImageView2.frame), [UIScreen mainScreen].bounds.size.width - 75, 100)];
        _hero4Label.font = [UIFont systemFontOfSize:12];
        _hero4Label.textColor = [UIColor colorWithRed:0.05 green:0.05 blue:0.05 alpha:1];
        _hero4Label.numberOfLines = 0;
    }
    return _hero4Label;
}

- (UIImageView *)eImageView2{
    if (_eImageView2 == nil) {
        _eImageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.titleLabel.frame), CGRectGetMaxY(self.hero4Label.frame) + 10, 50, 50)];
        _eImageView2.userInteractionEnabled = YES;
    }
    return _eImageView2;
}

- (UILabel *)hero5Label{
    if (_hero5Label == nil) {
        _hero5Label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.aImageView2.frame) + 5, CGRectGetMinY(self.eImageView2.frame), [UIScreen mainScreen].bounds.size.width - 75, 100)];
        _hero5Label.font = [UIFont systemFontOfSize:12];
        _hero5Label.textColor = [UIColor colorWithRed:0.05 green:0.05 blue:0.05 alpha:1];
        _hero5Label.numberOfLines = 0;
    }
    return _hero5Label;
}





@end
