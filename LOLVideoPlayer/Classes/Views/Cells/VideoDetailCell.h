//
//  VideoDetailCell.h
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/4.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoDetailCell : UITableViewCell

@property (nonatomic,strong)UIImageView *picImageView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *durationLabel;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UIButton *downLoadButton;

@end
