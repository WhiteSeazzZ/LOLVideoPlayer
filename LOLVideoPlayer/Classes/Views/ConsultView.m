//
//  ConsultView.m
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/1.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "ConsultView.h"



@implementation ConsultView

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
    self.backgroundColor = [UIColor whiteColor];
    //分段控件的内容数组
    NSArray *segmentArray = @[@"头条",@"视频",@"赛事"];
    //初始化分段空间并设置内容
    self.segmentControl = [[UISegmentedControl alloc]initWithItems:segmentArray];
   
    //分段控件的背景颜色
    self.segmentControl.backgroundColor = [UIColor whiteColor];
    //选中某个控件的颜色
    self.segmentControl.tintColor = [UIColor whiteColor];
    //设置默认字体颜色
    [self.segmentControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.281 green:0.281 blue:0.281 alpha:1]} forState:(UIControlStateNormal)];
    //设置选中的字体颜色
    [self.segmentControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.94 green:0.34 blue:0.07 alpha:1],NSFontAttributeName:[UIFont systemFontOfSize:16]} forState:(UIControlStateSelected)];
    self.segmentControl.frame = CGRectMake(0, 0, self.bounds.size.width, 25);
    //    self.segmentControl.
    //默认选中第一个
    self.segmentControl.selectedSegmentIndex = 0;
    //将分段控件添加到滚动视图上
    [self addSubview:self.segmentControl];

    //轮播图下面的tableView
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 25, self.frame.size.width, self.frame.size.height - 25 - 49 - 64) style:(UITableViewStylePlain)];
    //self.rotationPicture = [[RotationPicture alloc]initWithFrame:CGRectMake(0, 25, self.frame.size.width, self.frame.size.height / 4 + 20)];
    //self.tableView.tableHeaderView = self.rotationPicture;
    [self addSubview:self.tableView];
}


@end
