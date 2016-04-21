//
//  RotationPicture.m
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/1.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "RotationPicture.h"

@implementation RotationPicture

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
    
    //初始化轮播图aScrollView设置位置大小
    self.aScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0
        , self.frame.size.width, self.frame.size.height)];
    //整页滑动
    self.aScrollView.pagingEnabled = YES;
    //隐藏横向滑动的滑动条
    self.aScrollView.showsHorizontalScrollIndicator = NO;
    //设置默认的offset
    self.aScrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
    //关闭弹簧效果
    self.aScrollView.bounces = NO;
    //添加到视图
    [self addSubview:self.aScrollView];
    
    //轮播图的pageControl
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.aScrollView.frame) - 15, self.frame.size.width, 15)];
    self.pageControl.backgroundColor = [UIColor blackColor];
    self.pageControl.alpha = 0.3;
    [self addSubview:self.pageControl];

}

@end
