//
//  ConsultDetailView.m
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/1.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "ConsultDetailView.h"

@implementation ConsultDetailView

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
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 64)];
    [self addSubview:self.webView];
}

@end
