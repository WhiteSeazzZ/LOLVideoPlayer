//
//  ConsultView.h
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/1.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RotationPicture.h"

@interface ConsultView : UIView


//菜单栏的segmentControl
@property (nonatomic,strong)UISegmentedControl *segmentControl;
//轮播图下面的tableView
@property (nonatomic,strong)UITableView *tableView;

//接收cotroller传来的值
@property (nonatomic,assign)NSInteger count;

////轮播图
//@property (nonatomic,strong)RotationPicture *rotationPicture;

@end
