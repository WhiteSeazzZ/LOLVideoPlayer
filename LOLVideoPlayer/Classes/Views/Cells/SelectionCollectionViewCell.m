//
//  SelectionCollectionViewCell.m
//  HappyVideoPlayer
//
//  Created by lanou3g on 16/2/27.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "SelectionCollectionViewCell.h"

@implementation SelectionCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initLayout];
    }
    return self;
}

- (void)initLayout{
    self.picImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height / 7 * 5)];
    self.picImageView.layer.cornerRadius = 7;
    self.picImageView.layer.masksToBounds = YES;
    [self addSubview:self.picImageView];
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height / 7 * 5 + 3, self.frame.size.width, self.frame.size.height / 7)];
    self.nameLabel.textColor = [UIColor colorWithRed:0.1 green:0.3 blue:0.8 alpha:1];
    self.nameLabel.font = [UIFont systemFontOfSize:13];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.nameLabel];

}

@end
