//
//  DownLoadCell.h
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/8.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownLoadCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIButton *startAndStop;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
