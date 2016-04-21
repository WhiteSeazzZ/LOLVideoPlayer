//
//  MyReusableView.m
//  HappyVideoPlayer
//
//  Created by lanou3g on 16/2/27.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "MyReusableView.h"

@implementation MyReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, self.frame.size.width, 20)];
        self.label.font = [UIFont systemFontOfSize:16];
        self.label.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1];
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.label.frame) + 5, self.frame.size.width, 1)];
        view.backgroundColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1];
        [self addSubview:self.label];
        [self addSubview:view];
    }
    return self;
}

- (void)setLabelText:(NSString *)text{
    self.label.text = text;
    [self.label sizeToFit];
}

@end
