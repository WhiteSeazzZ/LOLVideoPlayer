//
//  ConsultCell.m
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/1.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "ConsultCell.h"

@implementation ConsultCell

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
    //初始化设置picImageView的位置大小
    self.picImageView = [[UIImageView alloc]initWithFrame:CGRectMake(7, 7, 100, 80)];
    [self addSubview:self.picImageView];
    //初始化设置titleLabel的位置大小
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.picImageView.frame) + 7, 7, [UIScreen mainScreen].bounds.size.width - 21 - CGRectGetWidth(self.picImageView.frame), 20)];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:self.titleLabel];
    //初始化设置subTitleLabel的位置大小
    self.subTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.titleLabel.frame), CGRectGetMaxY(self.titleLabel.frame) + 5, CGRectGetWidth(self.titleLabel.frame) - 10, 20)];
    self.subTitleLabel.font = [UIFont systemFontOfSize:13];
    //自适应高度时需要设置为0
    self.subTitleLabel.numberOfLines = 0;
    self.subTitleLabel.textColor = [UIColor colorWithRed:0.13 green:0.13 blue:0.13 alpha:1];
    [self addSubview:self.subTitleLabel];
    //初始化设置readCountLabel的位置大小
    self.readCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.subTitleLabel.frame), CGRectGetMaxY(self.subTitleLabel.frame) + 10, CGRectGetWidth(self.subTitleLabel.frame) / 2, 20)];
    self.readCountLabel.font = [UIFont systemFontOfSize:11];
    self.readCountLabel.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1];
    [self addSubview:self.readCountLabel];
    //初始化设置timeLabel的位置大小
    self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.readCountLabel.frame) + 5, CGRectGetMinY(self.readCountLabel.frame), CGRectGetWidth(self.subTitleLabel.frame) / 2 - 15, 20)];
    self.timeLabel.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1];
    self.timeLabel.font = [UIFont systemFontOfSize:11];
    self.timeLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.timeLabel];
}

@end
