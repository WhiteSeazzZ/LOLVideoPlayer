//
//  BestGroupCell.m
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/5.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "BestGroupCell.h"

@implementation BestGroupCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initLayout];
    }
    return self;
}

- (void)initLayout{
    [self addSubview:self.titleLabel];
    [self addSubview:self.aImageView];
    [self addSubview:self.bImageView];
    [self addSubview:self.cImageView];
    [self addSubview:self.dImageView];
    [self addSubview:self.eImageView];
    [self addSubview:self.desLabel];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.desLabel.frame) + 5, [UIScreen mainScreen].bounds.size.width, 5)];
    lineView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [self addSubview:lineView];
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, [UIScreen mainScreen].bounds.size.width - 20, 30)];
        _titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _titleLabel;
}

- (UIImageView *)aImageView{
    if (_aImageView == nil) {
        _aImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.titleLabel.frame), 50, 50)];
    }
    return _aImageView;
    
}
- (UIImageView *)bImageView{
    if (_bImageView == nil) {
        _bImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.aImageView.frame) + 7, CGRectGetMaxY(self.titleLabel.frame), 50, 50)];
    }
    return _bImageView;
    
}
- (UIImageView *)cImageView{
    if (_cImageView == nil) {
        _cImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.bImageView.frame) + 7, CGRectGetMaxY(self.titleLabel.frame), 50, 50)];
    }
    return _cImageView;
    
}
- (UIImageView *)dImageView{
    if (_dImageView == nil) {
        _dImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.cImageView.frame) + 7, CGRectGetMaxY(self.titleLabel.frame), 50, 50)];
    }
    return _dImageView;
    
}
- (UIImageView *)eImageView{
    if (_eImageView == nil) {
        _eImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.dImageView.frame) + 7, CGRectGetMaxY(self.titleLabel.frame), 50, 50)];
    }
    return _eImageView;
    
}

- (UILabel *)desLabel{
    if (_desLabel == nil) {
        _desLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 85, [UIScreen mainScreen].bounds.size.width - 20, 35)];
        _desLabel.font = [UIFont systemFontOfSize:11];
        _desLabel.numberOfLines = 0;
        _desLabel.textColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1];
    }
    return _desLabel;
}


@end
