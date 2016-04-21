//
//  EquipDetailView.h
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/5.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EquipDetailView : UIView

@property (nonatomic,strong)UIImageView *picImageView;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *priceLabel;
@property (nonatomic,strong)UILabel *allPriceLabel;
@property (nonatomic,strong)UILabel *sellPriceLabel;
@property (nonatomic,strong)UILabel *valueTitleLabel;
@property (nonatomic,strong)UILabel *valueLabel;
@property (nonatomic,strong)UILabel *needTitleLabel;
@property (nonatomic,strong)UIView *needView;
@property (nonatomic,strong)UILabel *composeTitleLabel;
@property (nonatomic,strong)UIView *composeView;

@end
