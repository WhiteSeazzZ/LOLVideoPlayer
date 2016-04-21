//
//  RankCell.m
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/6.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "RankCell.h"

@implementation RankCell

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
    [self addSubview:self.heroImageView];
    [self addSubview:self.presentLabel];
    [self addSubview:self.winLabel];
    [self addSubview:self.totalLabel];
}

- (UIImageView *)heroImageView{
    if (_heroImageView == nil) {
        _heroImageView = [[UIImageView alloc]initWithFrame:CGRectMake(18, 5, 40, 40)];
    }
    return _heroImageView;
}

- (UILabel *)presentLabel{
    if (_presentLabel == nil) {
        _presentLabel = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 4 - 10, 5, [UIScreen mainScreen].bounds.size.width / 4, 40)];
        _presentLabel.font = [UIFont systemFontOfSize:14];
        _presentLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _presentLabel;
}

- (UILabel *)winLabel{
    if (_winLabel == nil) {
        _winLabel = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 10, 5, [UIScreen mainScreen].bounds.size.width / 4, 40)];
        _winLabel.font = [UIFont systemFontOfSize:14];
        _winLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _winLabel;
}

- (UILabel *)totalLabel{
    if (_totalLabel == nil) {
        _totalLabel = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 4 * 3 - 10, 5, [UIScreen mainScreen].bounds.size.width / 4, 40)];
        _totalLabel.font = [UIFont systemFontOfSize:14];
        _totalLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _totalLabel;
}

@end
