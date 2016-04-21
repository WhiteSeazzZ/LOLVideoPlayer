//
//  SpecialView.h
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/1.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpecialView : UIView

//菜单栏的segmentControl
@property (nonatomic,strong)UISegmentedControl *segmentControl;

//整个页面的滑动scrollView
@property (nonatomic,strong)UIScrollView *pageScrollView;

//tableView
@property (nonatomic,strong)UITableView *tableView;

//tableTitleView
@property (nonatomic,strong)UIView *titleView;
//titleView上面的imageView
@property (nonatomic,strong)UIImageView *picImageView;
//titleView上面的label
@property (nonatomic,strong)UILabel *titleLabel;




@end
