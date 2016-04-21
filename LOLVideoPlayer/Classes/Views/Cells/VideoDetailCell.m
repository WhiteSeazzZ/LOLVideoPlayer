//
//  VideoDetailCell.m
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/4.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "VideoDetailCell.h"

@implementation VideoDetailCell

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
//    //初始化设置picImageView的位置大小
    self.picImageView = [[UIImageView alloc]initWithFrame:CGRectMake(7, 7, 100, 80)];
    
    [self addSubview:self.picImageView];

    //初始化设置titleLabel的位置大小
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.picImageView.frame) + 7, 17, [UIScreen mainScreen].bounds.size.width - 21 - CGRectGetWidth(self.picImageView.frame), 20)];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    //自适应高度时需要设置为0
    self.titleLabel.numberOfLines = 0;

    [self addSubview:self.titleLabel];
    //初始化设置readCountLabel的位置大小
    self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.titleLabel.frame) + 10, CGRectGetMaxY(self.titleLabel.frame) + 25, CGRectGetWidth(self.titleLabel.frame) / 2 , 20)];
    self.timeLabel.font = [UIFont systemFontOfSize:11];
    self.timeLabel.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1];
    [self addSubview:self.timeLabel];
    //初始化设置timeLabel的位置大小
    self.durationLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.timeLabel.frame) + 5, CGRectGetMinY(self.timeLabel.frame), CGRectGetWidth(self.titleLabel.frame) / 2 - 60, 20)];
    self.durationLabel.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1];
    self.durationLabel.font = [UIFont systemFontOfSize:11];
    self.durationLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.durationLabel];
    
    [self addSubview:self.downLoadButton];
    
}

- (UIButton *)downLoadButton{
    if (_downLoadButton == nil) {
        _downLoadButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        _downLoadButton.frame = CGRectMake(CGRectGetMaxX(self.durationLabel.frame) + 5, CGRectGetMinY(self.durationLabel.frame) - 10, 30, 30);
        [_downLoadButton setImage:[UIImage imageNamed:@"btn_video_download"] forState:(UIControlStateNormal)];
        
        //上不了线 把他隐藏
        _downLoadButton.alpha = 0;
    }
    return _downLoadButton;
}


@end
