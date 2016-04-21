//
//  SpecialView.m
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/1.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "SpecialView.h"


@implementation SpecialView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initLayout];
    }
    return self;
}

- (void)initLayout{
    self.backgroundColor = [UIColor whiteColor];
    
        
    //tableView
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 25, self.frame.size.width, self.frame.size.height - 25 - 49 - 15) style:(UITableViewStylePlain)];
    //定义tableView的headerView
    self.titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 25, self.frame.size.width, self.frame.size.height / 6 + 5)];
    self.picImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, CGRectGetHeight(self.titleView.frame) - 35)];
    [self.titleView addSubview:self.picImageView];
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.picImageView.frame), self.frame.size.width - 20, 30)];
    self.titleLabel.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1];
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.titleView addSubview:self.titleLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame), self.frame.size.width, 5)];
    lineView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [self.titleView addSubview:lineView];
    
    //设置tableView的headerView
    self.tableView.tableHeaderView = self.titleView;

    [self addSubview:self.tableView];
}

@end
