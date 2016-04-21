//
//  RankView.m
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/6.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "RankView.h"

@implementation RankView

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
        [self initLayout];
    }
    return self;
}

- (void)initLayout{
    self.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1];
    [self addSubview:self.tableView];
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 64) style:(UITableViewStylePlain)];
        UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 70)];
        UILabel *aLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, self.frame.size.width / 2, 20)];
        aLabel.text = @"排位赛英雄胜率周榜";
        aLabel.font = [UIFont systemFontOfSize:14];
        [titleView addSubview:aLabel];
        UILabel *bLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width / 2 + 5, 5, self.frame.size.width / 2 - 10, 20)];
        bLabel.text = @"每周一0点更新";
        bLabel.font = [UIFont systemFontOfSize:11];
        bLabel.textColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1];
        bLabel.textAlignment = NSTextAlignmentRight;
        [titleView addSubview:bLabel];
        UILabel *heroLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(bLabel.frame) + 5, self.frame.size.width / 4 - 10, 40)];
        heroLabel.text = @"英雄";
        heroLabel.textColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1];
        heroLabel.backgroundColor = [UIColor whiteColor];
        heroLabel.textAlignment = NSTextAlignmentCenter;
        [titleView addSubview:heroLabel];
        
        self.segment.frame = CGRectMake(CGRectGetMaxX(heroLabel.frame), CGRectGetMaxY(bLabel.frame) + 5, self.frame.size.width / 2, 40);
        //分段控件的背景颜色
        self.segment.backgroundColor = [UIColor whiteColor];
        //选中某个控件的颜色
        self.segment.tintColor = [UIColor whiteColor];
        //设置默认字体颜色
        [self.segment setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1],NSFontAttributeName:[UIFont systemFontOfSize:16]} forState:(UIControlStateNormal)];
        //设置选中的字体颜色
        [self.segment setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.94 green:0.34 blue:0.07 alpha:1],NSFontAttributeName:[UIFont systemFontOfSize:18]} forState:(UIControlStateSelected)];
        //默认选中第一个
        self.segment.selectedSegmentIndex = 0;
        [titleView addSubview:self.segment];
        
        UILabel *totalLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.segment.frame), CGRectGetMaxY(bLabel.frame) + 5, self.frame.size.width / 4, 40)];
        totalLabel.text = @"出场次数";
        totalLabel.textColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1];
        totalLabel.backgroundColor = [UIColor whiteColor];
        totalLabel.textAlignment = NSTextAlignmentCenter;
        [titleView addSubview:totalLabel];
        
        _tableView.tableHeaderView = titleView;
        
    }
    return _tableView;
}

- (UISegmentedControl *)segment{
    if (_segment == nil) {
        NSArray *array = @[@"出场率",@"胜率"];
        _segment = [[UISegmentedControl alloc]initWithItems:array];
    }
    return _segment;
}

@end
