//
//  HeroDetailViewController.m
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/7.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "HeroDetailViewController.h"
#import "HeroDetailModel.h"
#import "HeroSkillModel.h"
#import "HeroDetailView.h"

#define margin 11.0

@interface HeroDetailViewController ()

@property (nonatomic,strong)HeroDetailView *heroDetailView;
@property (nonatomic,strong)HeroDetailModel *heroDetailModel;
@property (nonatomic,strong)NSMutableArray *allSkillModelArray;
@property (nonatomic,strong)void (^block)(HeroDetailModel *model);
@property (nonatomic,strong)LoadingView *loadingView;

@end

@implementation HeroDetailViewController

- (void)loadView{
    self.heroDetailView = [[HeroDetailView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.heroDetailView;
}

- (void)handleData{
    [[CDHttpHelper defaultCDHttpHelper]get:[heroDetailUrlString stringByAppendingString:self.enName] params:nil success:^(id responseObj) {
        
        [FMDBSaveDataHelper FMDBSaveDataHelperWithData:responseObj andName:[@"heroDetail" stringByAppendingString:self.enName]];
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObj options:(NSJSONReadingAllowFragments) error:nil];
        self.heroDetailModel = [[HeroDetailModel alloc]init];
        [self.heroDetailModel setValuesForKeysWithDictionary:dic];
        
        for (int i = 0; i < 5; i++) {
            HeroSkillModel *heroSkillModel = [[HeroSkillModel alloc]init];
            switch (i) {
                case 0:
                    [heroSkillModel setValuesForKeysWithDictionary:dic[[NSString stringWithFormat:@"%@_B",self.enName]]];
                    break;
                case 1:
                    [heroSkillModel setValuesForKeysWithDictionary:dic[[NSString stringWithFormat:@"%@_Q",self.enName]]];
                    break;
                case 2:
                    [heroSkillModel setValuesForKeysWithDictionary:dic[[NSString stringWithFormat:@"%@_W",self.enName]]];
                    break;
                case 3:
                    [heroSkillModel setValuesForKeysWithDictionary:dic[[NSString stringWithFormat:@"%@_E",self.enName]]];
                    break;
                case 4:
                    [heroSkillModel setValuesForKeysWithDictionary:dic[[NSString stringWithFormat:@"%@_R",self.enName]]];
                    break;
                
            }
            
            [self.allSkillModelArray addObject:heroSkillModel];
        }
        
        
        
        
        self.block(self.heroDetailModel);
        
    } failure:^(NSError *error) {
        FMDatabase *db = [FMDatabase databaseWithPath:[[GetDocumentsPathHelper shareGetDocumentsPathHelper] getDocumentsPath]];
        if ([db open]) {
            
            [db executeUpdate:@"create table if not exists videoPlayer (id integer primary key autoincrement NOT NULL,data blob NOT NULL,name text NOT NULL)"];
            
            FMResultSet *resultSet = [db executeQuery:@"select *from videoPlayer where name = ?",[@"heroDetail" stringByAppendingString:self.enName]];
            
            
            id data = nil;
            while ([resultSet next]) {
                data = [resultSet dataForColumn:@"data"];
            }
            if (data != nil) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
                self.heroDetailModel = [[HeroDetailModel alloc]init];
                [self.heroDetailModel setValuesForKeysWithDictionary:dic];
                
                for (int i = 0; i < 5; i++) {
                    HeroSkillModel *heroSkillModel = [[HeroSkillModel alloc]init];
                    switch (i) {
                        case 0:
                            [heroSkillModel setValuesForKeysWithDictionary:dic[[NSString stringWithFormat:@"%@_B",self.enName]]];
                            break;
                        case 1:
                            [heroSkillModel setValuesForKeysWithDictionary:dic[[NSString stringWithFormat:@"%@_Q",self.enName]]];
                            break;
                        case 2:
                            [heroSkillModel setValuesForKeysWithDictionary:dic[[NSString stringWithFormat:@"%@_W",self.enName]]];
                            break;
                        case 3:
                            [heroSkillModel setValuesForKeysWithDictionary:dic[[NSString stringWithFormat:@"%@_E",self.enName]]];
                            break;
                        case 4:
                            [heroSkillModel setValuesForKeysWithDictionary:dic[[NSString stringWithFormat:@"%@_R",self.enName]]];
                            break;
                            
                    }
                    
                    [self.allSkillModelArray addObject:heroSkillModel];
                }
                
                
                
                
                self.block(self.heroDetailModel);

                
                [db close];
                
            }
        }

    }];
}

- (NSMutableArray *)allSkillModelArray{
    if (_allSkillModelArray == nil) {
        _allSkillModelArray = [NSMutableArray array];
    }
    return _allSkillModelArray;
}

- (void)setData:(HeroDetailModel *)model{
    [self.heroDetailView.heroImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:heroPictureUrlString,self.enName]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.heroDetailView.nameLabel.text = model.displayName;
    //将金钱与点券分开
    NSArray *array = [model.price componentsSeparatedByString:@","];
    self.heroDetailView.heroTypeLabel.text = [NSString stringWithFormat:@"%@  金%@券%@",model.tags,array[0],array[1]];
    self.heroDetailView.valueLabel.text = [NSString stringWithFormat:@"功%@ 防%@ 法%@ 难度%@",model.ratingAttack,model.ratingDefense,model.ratingMagic,model.ratingDifficulty];
    //循环创建图片
    for (int i = 0; i < 5; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * 55 + 11, CGRectGetMaxY(self.heroDetailView.skillTitleLabel.frame) + 6, 50, 50)];
        imageView.userInteractionEnabled = YES;
        imageView.tag = 100 + i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
        [imageView addGestureRecognizer:tap];
        switch (i) {
            case 0:
                [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:heroSkillPictureUrlString,[NSString stringWithFormat:@"%@_B",self.enName]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
                
                break;
            case 1:
                [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:heroSkillPictureUrlString,[NSString stringWithFormat:@"%@_Q",self.enName]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
                break;
            case 2:
                [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:heroSkillPictureUrlString,[NSString stringWithFormat:@"%@_W",self.enName]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
                break;
            case 3:
                [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:heroSkillPictureUrlString,[NSString stringWithFormat:@"%@_E",self.enName]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
                break;
            case 4:
                [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:heroSkillPictureUrlString,[NSString stringWithFormat:@"%@_R",self.enName]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
                break;
                
        }
        [self.heroDetailView.pageScrollView addSubview:imageView];

    }
    
    //默认显示被动技能
    HeroSkillModel *heroSkillModel = self.allSkillModelArray[0];
    self.heroDetailView.skillDetailLabel.text = [NSString stringWithFormat:@"  %@(被动)\n  描述:%@\n",heroSkillModel.name,heroSkillModel.descriptions];
    
    CGFloat skillLabelHeight = [self getHeightWithString:[NSString stringWithFormat:@"  %@(被动)\n  描述:%@\n",heroSkillModel.name,heroSkillModel.descriptions] andWidth:self.heroDetailView.frame.size.width - margin * 2  andFontSize:13];
    
    self.heroDetailView.skillDetailLabel.frame = CGRectMake(margin, CGRectGetMaxY(self.heroDetailView.skillTitleLabel.frame) + 70, self.heroDetailView.frame.size.width - margin * 2, skillLabelHeight);
    [self setFrame];
}

- (void)tapClick:(UITapGestureRecognizer *)tap{
    
    HeroSkillModel *heroSkillModel = self.allSkillModelArray[[tap view].tag - 100];
    CGFloat skillLabelHeight = 0;
    if ([tap view].tag == 100) {
        self.heroDetailView.skillDetailLabel.text = [NSString stringWithFormat:@"  %@(被动)\n  描述:%@\n",heroSkillModel.name,heroSkillModel.descriptions];
        skillLabelHeight = [self getHeightWithString:[NSString stringWithFormat:@"  %@(被动)\n  描述:%@\n",heroSkillModel.name,heroSkillModel.descriptions] andWidth:self.heroDetailView.frame.size.width - margin * 2  andFontSize:13];
        
    }else{
        self.heroDetailView.skillDetailLabel.text = [NSString stringWithFormat:@"  %@\n  消耗:%@\n  冷却:%@\n  范围:%@\n  效果:%@\n  描述:%@\n",heroSkillModel.name,heroSkillModel.cost,heroSkillModel.cooldown,heroSkillModel.range,heroSkillModel.effect,heroSkillModel.descriptions];
        skillLabelHeight = [self getHeightWithString:[NSString stringWithFormat:@"  %@\n  消耗:%@\n  冷却:%@\n  范围:%@\n  效果:%@\n  描述:%@\n",heroSkillModel.name,heroSkillModel.cost,heroSkillModel.cooldown,heroSkillModel.range,heroSkillModel.effect,heroSkillModel.descriptions] andWidth:self.heroDetailView.frame.size.width - margin * 2 andFontSize:13];
    }
    self.heroDetailView.skillDetailLabel.frame = CGRectMake(margin, CGRectGetMaxY(self.heroDetailView.skillTitleLabel.frame) + 70, self.heroDetailView.frame.size.width - margin * 2, skillLabelHeight);
    [self setFrame];
    

}

//重新设置技能label下面的所有控件的frame
- (void)setFrame{
    
    
    
    
    self.heroDetailView.bestCooperateTitleLabel.frame = CGRectMake(margin, CGRectGetMaxY(self.heroDetailView.skillDetailLabel.frame) + 10, 70, 20);
    
    if (self.heroDetailModel.like.count == 2 && self.heroDetailModel.hate.count == 2) {
        //设置最佳搭档的数据
        NSDictionary *like1 = self.heroDetailModel.like[0];
        NSDictionary *like2 = self.heroDetailModel.like[1];
        [self.heroDetailView.cooperate1ImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:heroPictureUrlString,like1[@"partner"]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClicks:)];
        self.heroDetailView.cooperate1ImageView.tag = 300;
        [self.heroDetailView.cooperate1ImageView addGestureRecognizer:tap1];
        [self.heroDetailView.cooperate2ImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:heroPictureUrlString,like2[@"partner"]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClicks:)];
        self.heroDetailView.cooperate2ImageView.tag = 301;
        [self.heroDetailView.cooperate2ImageView addGestureRecognizer:tap2];
        self.heroDetailView.cooperate1DesLabel.text = like1[@"des"];
        self.heroDetailView.cooperate2DesLabel.text = like2[@"des"];
        //搭档1的label高度
        CGFloat cooperate1DesLabelHeight = [self getHeightWithString:like1[@"des"] andWidth:self.heroDetailView.frame.size.width - margin * 3 - CGRectGetWidth(self.heroDetailView.cooperate1ImageView.frame) - 10 andFontSize:13];
        cooperate1DesLabelHeight = cooperate1DesLabelHeight > 45 ? cooperate1DesLabelHeight : 45;
        //搭档2的label高度
        CGFloat cooperate2DesLabelHeight = [self getHeightWithString:like2[@"des"] andWidth:self.heroDetailView.frame.size.width - margin * 3 - CGRectGetWidth(self.heroDetailView.cooperate1ImageView.frame) - 10 andFontSize:13];
        cooperate2DesLabelHeight = cooperate2DesLabelHeight > 45 ? cooperate2DesLabelHeight : 45;
        //重新设置搭档1的label的frame
        self.heroDetailView.cooperate1DesLabel.frame = CGRectMake(CGRectGetMaxX(self.heroDetailView.cooperate1ImageView.frame) + 5, CGRectGetMinY(self.heroDetailView.cooperate1ImageView.frame), self.heroDetailView.frame.size.width - margin * 3 - CGRectGetWidth(self.heroDetailView.cooperate1ImageView.frame) - 10, cooperate1DesLabelHeight);
        //重新设置搭档2的imageView的frame
        self.heroDetailView.cooperate2ImageView.frame = CGRectMake(margin, CGRectGetMaxY(self.heroDetailView.cooperate1DesLabel.frame) + 9, 45, 45);
        //重新设置搭档2的label的frame
        self.heroDetailView.cooperate2DesLabel.frame = CGRectMake(CGRectGetMaxX(self.heroDetailView.cooperate2ImageView.frame) + 5, CGRectGetMinY(self.heroDetailView.cooperate2ImageView.frame), CGRectGetWidth(self.heroDetailView.cooperate1DesLabel.frame), cooperate2DesLabelHeight);
        //重新设置view的frame ,主要是高度
        self.heroDetailView.cooperateView.frame = CGRectMake(margin, CGRectGetMaxY(self.heroDetailView.bestCooperateTitleLabel.frame), self.heroDetailView.frame.size.width - margin * 2, cooperate1DesLabelHeight + cooperate2DesLabelHeight + 28);
        
        
        self.heroDetailView.bestRestrainTitleLabel.frame = CGRectMake(margin, CGRectGetMaxY(self.heroDetailView.cooperateView.frame) + 10, 70, 20);
        
        //设置最佳克制的数据
        NSDictionary *hate1 = self.heroDetailModel.hate[0];
        NSDictionary *hate2 = self.heroDetailModel.hate[1];
        [self.heroDetailView.restrain1ImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:heroPictureUrlString,hate1[@"partner"]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClicks:)];
        self.heroDetailView.restrain1ImageView.tag = 302;
        [self.heroDetailView.restrain1ImageView addGestureRecognizer:tap3];
        [self.heroDetailView.restrain2ImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:heroPictureUrlString,hate2[@"partner"]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClicks:)];
        self.heroDetailView.restrain2ImageView.tag = 303;
        [self.heroDetailView.restrain2ImageView addGestureRecognizer:tap4];
        self.heroDetailView.restrain1DesLabel.text = hate1[@"des"];
        self.heroDetailView.restrain2DesLabel.text = hate2[@"des"];
        //克制1的label高度
        CGFloat restrain1DesLabelHeight = [self getHeightWithString:hate1[@"des"] andWidth:self.heroDetailView.frame.size.width - margin * 3 - CGRectGetWidth(self.heroDetailView.cooperate1ImageView.frame) - 10 andFontSize:13];
        restrain1DesLabelHeight = restrain1DesLabelHeight > 45 ? restrain1DesLabelHeight : 45;
        //克制2的label高度
        CGFloat restrain2DesLabelHeight = [self getHeightWithString:hate2[@"des"] andWidth:self.heroDetailView.frame.size.width - margin * 3 - CGRectGetWidth(self.heroDetailView.cooperate1ImageView.frame) - 10 andFontSize:13];
        restrain2DesLabelHeight = restrain2DesLabelHeight > 45 ?  restrain2DesLabelHeight : 45;
        //重新设置克制1的label的frame
        self.heroDetailView.restrain1DesLabel.frame = CGRectMake(CGRectGetMaxX(self.heroDetailView.restrain1ImageView.frame) + 5, CGRectGetMinY(self.heroDetailView.restrain1ImageView.frame), self.heroDetailView.frame.size.width - margin * 3 - CGRectGetWidth(self.heroDetailView.restrain1ImageView.frame) - 10, restrain1DesLabelHeight);
        //重新设置克制2的imageView的frame
        self.heroDetailView.restrain2ImageView.frame = CGRectMake(margin, CGRectGetMaxY(self.heroDetailView.restrain1DesLabel.frame) + 9, 45, 45);
        //重新设置克制2的label的frame
        self.heroDetailView.restrain2DesLabel.frame = CGRectMake(CGRectGetMaxX(self.heroDetailView.restrain2ImageView.frame) + 5, CGRectGetMinY(self.heroDetailView.restrain2ImageView.frame), CGRectGetWidth(self.heroDetailView.restrain1DesLabel.frame), cooperate2DesLabelHeight + 20);
        //重新设置view的frame ,主要是高度
        self.heroDetailView.restrainView.frame = CGRectMake(margin, CGRectGetMaxY(self.heroDetailView.bestRestrainTitleLabel.frame), self.heroDetailView.frame.size.width - margin * 2, restrain1DesLabelHeight + restrain2DesLabelHeight + 28);
        
        //重新设置useTitleLabel的frame
        self.heroDetailView.useTitleLabel.frame = CGRectMake(margin, CGRectGetMaxY(self.heroDetailView.restrainView.frame) + 10, 30, 20);
        //useLabel的高度
        CGFloat useLabelHeight = [self getHeightWithString:self.heroDetailModel.tips andWidth:self.heroDetailView.frame.size.width - margin * 2 andFontSize:13] + 10;
        self.heroDetailView.useLabel.frame = CGRectMake(margin, CGRectGetMaxY(self.heroDetailView.useTitleLabel.frame) + 5, self.heroDetailView.frame.size.width - margin * 2, useLabelHeight);
        self.heroDetailView.useLabel.text = self.heroDetailModel.tips;
    }else{
        self.heroDetailView.cooperateView.alpha = 0;
        self.heroDetailView.bestCooperateTitleLabel.alpha = 0;
        self.heroDetailView.restrainView.alpha = 0;
        self.heroDetailView.bestRestrainTitleLabel.alpha = 0;
        
        //重新设置useTitleLabel的frame
        self.heroDetailView.useTitleLabel.frame = CGRectMake(margin, CGRectGetMaxY(self.heroDetailView.skillDetailLabel.frame) + 10, 30, 20);
        //useLabel的高度
        CGFloat useLabelHeight = [self getHeightWithString:self.heroDetailModel.tips andWidth:self.heroDetailView.frame.size.width - margin * 2 andFontSize:13] + 10;
        self.heroDetailView.useLabel.frame = CGRectMake(margin, CGRectGetMaxY(self.heroDetailView.useTitleLabel.frame) + 5, self.heroDetailView.frame.size.width - margin * 2, useLabelHeight);
        self.heroDetailView.useLabel.text = self.heroDetailModel.tips;
    }
    
    //重新设置replyTitleLabel的frame
    self.heroDetailView.replyTitleLabel.frame = CGRectMake(margin, CGRectGetMaxY(self.heroDetailView.useLabel.frame) + 10, 30, 20);
    CGFloat replyLabelHeight = [self getHeightWithString:self.heroDetailModel.opponentTips andWidth:self.heroDetailView.frame.size.width - margin * 2 andFontSize:13] + 10;
    self.heroDetailView.replyLabel.frame = CGRectMake(margin, CGRectGetMaxY(self.heroDetailView.replyTitleLabel.frame) + 5, self.heroDetailView.frame.size.width - margin * 2, replyLabelHeight);
    self.heroDetailView.replyLabel.text = self.heroDetailModel.opponentTips;
    //重新设置heroDataView的frame
    self.heroDetailView.heroDataView.frame = CGRectMake(margin, CGRectGetMaxY(self.heroDetailView.replyLabel.frame) + 15, self.heroDetailView.frame.size.width - margin * 2, 270);
    [self.heroDetailView.levelSlider addTarget:self action:@selector(sliderClick:) forControlEvents:(UIControlEventValueChanged)];
    self.heroDetailView.levelLabel.text = @"等级: 1";
    self.heroDetailView.rangeLabel.text = [NSString stringWithFormat:@"攻击距离:%@",self.heroDetailModel.range];
    self.heroDetailView.moveSpeedLabel.text = [NSString stringWithFormat:@"移动速度:%@",self.heroDetailModel.moveSpeed];
    self.heroDetailView.attackBaseLabel.text = [NSString stringWithFormat:@"基础攻击:%.2f (%@)",[self.heroDetailModel.attackBase doubleValue] + [self.heroDetailModel.attackLevel doubleValue],self.heroDetailModel.attackLevel];
    self.heroDetailView.armorLabel.text = [NSString stringWithFormat:@"基础防御:%.2f (%@)",[self.heroDetailModel.armorBase doubleValue] + [self.heroDetailModel.armorLevel doubleValue],self.heroDetailModel.armorLevel];
    self.heroDetailView.manaLabel.text = [NSString stringWithFormat:@"基础魔法值:%.2f (%@)",[self.heroDetailModel.manaBase doubleValue] + [self.heroDetailModel.manaLevel doubleValue],self.heroDetailModel.manaLevel];
    self.heroDetailView.healthLabel.text = [NSString stringWithFormat:@"基础生命值:%.2f (%@)",[self.heroDetailModel.healthBase doubleValue] + [self.heroDetailModel.healthLevel doubleValue],self.heroDetailModel.healthLevel];
    self.heroDetailView.criticalChanceLabel.text = [NSString stringWithFormat:@"暴击概率:%.2f (%@)",[self.heroDetailModel.criticalChanceBase doubleValue] + [self.heroDetailModel.criticalChanceLevel doubleValue],self.heroDetailModel.criticalChanceLevel];
    self.heroDetailView.manaRegenLabel.text = [NSString stringWithFormat:@"魔法回复:%.2f (%@)",[self.heroDetailModel.manaRegenBase doubleValue] + [self.heroDetailModel.manaRegenLevel doubleValue],self.heroDetailModel.manaRegenLevel];
    self.heroDetailView.healthRegenLabel.text = [NSString stringWithFormat:@"生命回复:%.2f (%@)",[self.heroDetailModel.healthRegenBase doubleValue] + [self.heroDetailModel.healthRegenLevel doubleValue],self.heroDetailModel.healthRegenLevel];
    self.heroDetailView.magicResistLabel.text = [NSString stringWithFormat:@"魔法抗性:%.2f (%@)",[self.heroDetailModel.magicResistBase doubleValue] + [self.heroDetailModel.magicResistLevel doubleValue],self.heroDetailModel.magicResistLevel];
    
    CGFloat desLabelHeight = [self getHeightWithString:self.heroDetailModel.descriptions andWidth:self.heroDetailView.frame.size.width - margin * 2 andFontSize:13] + 10;
    self.heroDetailView.desLabel.frame = CGRectMake(margin, CGRectGetMaxY(self.heroDetailView.heroDataView.frame) + 15, self.heroDetailView.frame.size.width - margin * 2, desLabelHeight);
    self.heroDetailView.desLabel.text = self.heroDetailModel.descriptions;
    
    [self.loadingView setHidden:YES];
    
    self.heroDetailView.pageScrollView.contentSize = CGSizeMake(self.heroDetailView.frame.size.width, CGRectGetMaxY(self.heroDetailView.desLabel.frame));
    
    
    
    
}

- (void)tapClicks:(UITapGestureRecognizer *)tap{
    NSDictionary *like1 = self.heroDetailModel.like[0];
    NSDictionary *like2 = self.heroDetailModel.like[1];
    //设置最佳克制的数据
    NSDictionary *hate1 = self.heroDetailModel.hate[0];
    NSDictionary *hate2 = self.heroDetailModel.hate[1];
    HeroDetailViewController *heroDetailVC = [[HeroDetailViewController alloc]init];
    switch ([tap view].tag) {
        case 300:
            heroDetailVC.enName = like1[@"partner"];
            break;
        case 301:
            heroDetailVC.enName = like2[@"partner"];
            break;
        case 302:
            heroDetailVC.enName = hate1[@"partner"];
            break;
        case 303:
            heroDetailVC.enName = hate2[@"partner"];
            break;
    }
    [self showViewController:heroDetailVC sender:nil];
}


//滑竿的触发事件
- (void)sliderClick:(UISlider *)slider{
    self.heroDetailView.levelLabel.text = [NSString stringWithFormat:@"等级: %.f",slider.value];
    self.heroDetailView.attackBaseLabel.text = [NSString stringWithFormat:@"基础攻击:%.2f (%@)",[self.heroDetailModel.attackBase doubleValue] + [self.heroDetailModel.attackLevel doubleValue] * (NSInteger)slider.value,self.heroDetailModel.attackLevel];
    self.heroDetailView.armorLabel.text = [NSString stringWithFormat:@"基础防御:%.2f (%@)",[self.heroDetailModel.armorBase doubleValue] + [self.heroDetailModel.armorLevel doubleValue] * (NSInteger)slider.value,self.heroDetailModel.armorLevel];
    self.heroDetailView.manaLabel.text = [NSString stringWithFormat:@"基础魔法值:%.2f (%@)",[self.heroDetailModel.manaBase doubleValue] + [self.heroDetailModel.manaLevel doubleValue] * (NSInteger)slider.value,self.heroDetailModel.manaLevel];
    self.heroDetailView.healthLabel.text = [NSString stringWithFormat:@"基础生命值:%.2f (%@)",[self.heroDetailModel.healthBase doubleValue] + [self.heroDetailModel.healthLevel doubleValue] * (NSInteger)slider.value,self.heroDetailModel.healthLevel];
    self.heroDetailView.criticalChanceLabel.text = [NSString stringWithFormat:@"暴击概率:%.2f (%@)",[self.heroDetailModel.criticalChanceBase doubleValue] + [self.heroDetailModel.criticalChanceLevel doubleValue] * (NSInteger)slider.value,self.heroDetailModel.criticalChanceLevel];
    self.heroDetailView.manaRegenLabel.text = [NSString stringWithFormat:@"魔法回复:%.2f (%@)",[self.heroDetailModel.manaRegenBase doubleValue] + [self.heroDetailModel.manaRegenLevel doubleValue] * (NSInteger)slider.value,self.heroDetailModel.manaRegenLevel];
    self.heroDetailView.healthRegenLabel.text = [NSString stringWithFormat:@"生命回复:%.2f (%@)",[self.heroDetailModel.healthRegenBase doubleValue] + [self.heroDetailModel.healthRegenLevel doubleValue] * (NSInteger)slider.value,self.heroDetailModel.healthRegenLevel];
    self.heroDetailView.magicResistLabel.text = [NSString stringWithFormat:@"魔法抗性:%.2f (%@)",[self.heroDetailModel.magicResistBase doubleValue] + [self.heroDetailModel.magicResistLevel doubleValue] * (NSInteger)slider.value,self.heroDetailModel.magicResistLevel];
}

#pragma mark - 自适应高度
- (CGFloat)getHeightWithString:(NSString *)string andWidth:(CGFloat)width andFontSize:(NSInteger)fontSize{
    CGRect temp = [string boundingRectWithSize:CGSizeMake(width, 1000) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    return temp.size.height;
}
#pragma mark - 设置导航栏
- (void)setNavigationBar{
    //设置导航栏颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.281 green:0.281 blue:0.281 alpha:1]];
    //设置导航栏为不透明
    self.navigationController.navigationBar.translucent = NO;
    //自定义导航栏
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    label.text = @"英雄详情";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    //设置title
    self.navigationItem.titleView = label;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
//    //设置返回按钮
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:(UIBarButtonItemStyleDone) target:nil action:nil];
    
    //设置返回装备列表的方法
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"百科" style:(UIBarButtonItemStyleDone) target:self action:@selector(listClick)];
    
}

#pragma  mark - 返回列表的方法
- (void)listClick{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.loadingView = [[LoadingView alloc]initWithFrame:CGRectMake(0, 0, self.heroDetailView.frame.size.width, self.heroDetailView.frame.size.height - 64)];
    [self.heroDetailView addSubview:self.loadingView];
    
    [self setNavigationBar];
    [self handleData];
    
    
    __weak typeof (self) Self = self;
    self.block = ^(HeroDetailModel *model){
        [Self setData:(HeroDetailModel *)model];
    };
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
