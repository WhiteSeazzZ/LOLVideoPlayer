//
//  VideoAndEventView.m
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/3.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "VideoAndEventView.h"

@implementation VideoAndEventView

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
    [self addSubview:self.tableView];
}


- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 64 - 49) style:(UITableViewStylePlain)];
    }
    return _tableView;
}

@end
