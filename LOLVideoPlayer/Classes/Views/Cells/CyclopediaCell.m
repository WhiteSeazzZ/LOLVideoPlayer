//
//  CyclopediaCell.m
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/4.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "CyclopediaCell.h"

@implementation CyclopediaCell

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
    [self addSubview:self.arrowImageView];
}

- (UIImageView *)picImageView{
    if (_picImageView == nil) {
        _picImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 7, 40, 40)];
    }
    return _picImageView;
}

- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 7, 200, 40)];
    }
    return _nameLabel;
}

- (UIImageView *)arrowImageView{
    if (_arrowImageView == nil) {
        _arrowImageView = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 30, 17, 15, 20)];
        _arrowImageView.image = [UIImage imageNamed:@"bg_bar_arrow"];
    }
    return _arrowImageView;
    
}

@end
