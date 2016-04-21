//
//  DownLoadView.m
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/8.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "DownLoadView.h"

@implementation DownLoadView

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
    [self addSubview:self.segment];
    [self addSubview:self.pageScrollView];
}

- (UISegmentedControl *)segment{
    if (_segment == nil) {
        NSArray *array = @[@"下载中",@"已下载"];
        _segment = [[UISegmentedControl alloc]initWithItems:array];
        _segment.frame = CGRectMake(0, 0, self.frame.size.width, 25);
        //分段控件的背景颜色
        _segment.backgroundColor = [UIColor whiteColor];
        //选中某个控件的颜色
        _segment.tintColor = [UIColor whiteColor];
        _segment.selectedSegmentIndex = 0;
        //设置默认字体颜色
        [_segment setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.281 green:0.281 blue:0.281 alpha:1]} forState:(UIControlStateNormal)];
        //设置选中的字体颜色
        [_segment setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.94 green:0.34 blue:0.07 alpha:1],NSFontAttributeName:[UIFont systemFontOfSize:16]} forState:(UIControlStateSelected)];

    }
    return _segment;
}

- (UIScrollView *)pageScrollView{
    if (_pageScrollView == nil) {
        _pageScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 25, self.frame.size.width, self.frame.size.height - 25 - 49)];
        _pageScrollView.contentSize = CGSizeMake(self.frame.size.width * 2, self.frame.size.height - 25 - 49);
        _pageScrollView.bounces = NO;
        _pageScrollView.pagingEnabled = YES;
        [_pageScrollView addSubview:self.aTableView];
        [_pageScrollView addSubview:self.bTableView];
    }
    return _pageScrollView;
}

- (UITableView *)aTableView{
    if (_aTableView == nil) {
        _aTableView = [[UITableView alloc]initWithFrame:self.pageScrollView.bounds style:(UITableViewStylePlain)];
//        _aTableView.backgroundColor = [UIColor redColor];
//        _aTableView
        _aTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _aTableView;
}
- (UITableView *)bTableView{
    if (_bTableView == nil) {
        _bTableView = [[UITableView alloc]initWithFrame:CGRectMake(self.frame.size.width, 0, self.frame.size.width, CGRectGetHeight(self.pageScrollView.frame)) style:(UITableViewStylePlain)];
//        _bTableView.backgroundColor = [UIColor redColor];
        _bTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _bTableView;
}


@end
