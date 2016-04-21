//
//  RunesView.m
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/5.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "RunesView.h"

@implementation RunesView

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
        self.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1];
        [self initLayout];
    }
    return self;
}

- (void)initLayout{
    [self addSubview:self.gradeSegmentControl];
    [self addSubview:self.typeSegmentControl];
    [self addSubview:self.tableView];
}

- (UISegmentedControl *)gradeSegmentControl{
    if (_gradeSegmentControl == nil) {
        NSArray *array = @[@"1级",@"2级",@"3级"];
        _gradeSegmentControl = [[UISegmentedControl alloc]initWithItems:array];
        _gradeSegmentControl.frame = CGRectMake(self.frame.size.width / 9, 10, self.frame.size.width / 9 * 3 - 5, 30);
        //分段控件的背景颜色
        _gradeSegmentControl.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1];
        //选中某个控件的颜色
        _gradeSegmentControl.tintColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1];
        //设置默认字体颜色
        [_gradeSegmentControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.281 green:0.281 blue:0.281 alpha:1]} forState:(UIControlStateNormal)];
        //设置选中的字体颜色
        [_gradeSegmentControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.94 green:0.34 blue:0.07 alpha:1],NSFontAttributeName:[UIFont systemFontOfSize:16]} forState:(UIControlStateSelected)];
        
        //默认选中第一个
        _gradeSegmentControl.selectedSegmentIndex = 0;

    }
    return _gradeSegmentControl;
}

- (UISegmentedControl *)typeSegmentControl{
    if (_typeSegmentControl == nil) {
        NSArray *array = @[@"雕纹",@"符印",@"印记",@"精华"];
        _typeSegmentControl = [[UISegmentedControl alloc]initWithItems:array];
        _typeSegmentControl.frame = CGRectMake(self.frame.size.width / 9 * 4, 10, self.frame.size.width / 9 * 4, 30);
        //分段控件的背景颜色
        _typeSegmentControl.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1];
        //选中某个控件的颜色
        _typeSegmentControl.tintColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1];
        //设置默认字体颜色
        [_typeSegmentControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.281 green:0.281 blue:0.281 alpha:1]} forState:(UIControlStateNormal)];
        //设置选中的字体颜色
        [_typeSegmentControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.94 green:0.34 blue:0.07 alpha:1],NSFontAttributeName:[UIFont systemFontOfSize:16]} forState:(UIControlStateSelected)];
        
        //默认选中第一个
        _typeSegmentControl.selectedSegmentIndex = 0;

    }
    return _typeSegmentControl;
}


- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 60, self.frame.size.width - 20, self.frame.size.height - 64 - 49 - 60) style:(UITableViewStylePlain)];
        _tableView.layer.cornerRadius = 5;
        _tableView.layer.masksToBounds = YES;
    }
    return _tableView;
}


@end
