//
//  RunesCell.m
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/5.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "RunesCell.h"

@implementation RunesCell

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
    [self addSubview:self.picImageView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.gradeLabel];
    [self addSubview:self.moneyLabel];
    [self addSubview:self.propLabel];
}

- (UIImageView *)picImageView{
    if (_picImageView == nil) {
        _picImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 5, 70, self.frame.size.height + 20)];
    }
    return _picImageView;
}
- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.picImageView.frame) + 5, CGRectGetMinY(self.picImageView.frame) + 5, 150, self.frame.size.height / 3)];
        _nameLabel.font = [UIFont systemFontOfSize:16];
    }
    return _nameLabel;
}
- (UILabel *)gradeLabel{
    if (_gradeLabel == nil) {
        _gradeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.picImageView.frame) + 5, CGRectGetMaxY(self.nameLabel.frame) + 5, 25, self.frame.size.height / 3)];
        _gradeLabel.font = [UIFont systemFontOfSize:13];
        _gradeLabel.textColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1];
    }
    return _gradeLabel;
}
- (UILabel *)moneyLabel{
    if (_moneyLabel == nil) {
        _moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.gradeLabel.frame) + 3, CGRectGetMaxY(self.nameLabel.frame) + 5, 100, self.frame.size.height / 3)];
        _moneyLabel.font = [UIFont systemFontOfSize:13];
        _moneyLabel.textColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1];
    }
    return _moneyLabel;
}
- (UILabel *)propLabel{
    if (_propLabel == nil) {
        _propLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.picImageView.frame) + 5, CGRectGetMaxY(self.moneyLabel.frame) + 5, self.frame.size.width - 70, self.frame.size.height / 3 + 20)];
        _propLabel.font = [UIFont systemFontOfSize:13];
        _propLabel.numberOfLines = 0;
        _propLabel.textColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1];
    }
    return _propLabel;
}


@end
