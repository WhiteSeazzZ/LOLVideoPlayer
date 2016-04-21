//
//  FreeHeroCell.m
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/6.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "FreeHeroCell.h"

@implementation FreeHeroCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initLayout];
    }
    return self;
}

- (void)initLayout{
    [self addSubview:self.heroImageView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.desLabel];
    [self addSubview:self.locationLabel];

}

- (UIImageView *)heroImageView{
    if (_heroImageView == nil) {
        _heroImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    }
    return _heroImageView;
}
- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.heroImageView.frame) + 7, CGRectGetMinY(self.heroImageView.frame) + 3, 80, 15)];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1];
    }
    return _nameLabel;
}
- (UILabel *)desLabel{
    if (_desLabel == nil) {
        _desLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.heroImageView.frame) + 7, CGRectGetMaxY(self.nameLabel.frame) + 3, 80, 15)];
        _desLabel.font = [UIFont systemFontOfSize:12];
        _desLabel.textColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1];
    }
    return _desLabel;
}

- (UILabel *)locationLabel{
    if (_locationLabel == nil) {
        _locationLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.heroImageView.frame) + 7, CGRectGetMaxY(self.desLabel.frame) + 3, 90, 15)];
        _locationLabel.font = [UIFont systemFontOfSize:12];
        _locationLabel.numberOfLines = 0;
        _locationLabel.textColor = [UIColor colorWithRed:0.1 green:0.2 blue:0.8 alpha:1];
    }
    return _locationLabel;
}


@end
