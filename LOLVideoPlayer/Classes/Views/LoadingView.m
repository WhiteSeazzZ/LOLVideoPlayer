//
//  LoadingView.m
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/10.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "LoadingView.h"

@implementation LoadingView

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
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.5;
        [self initLayout];
    }
    return self;
}

- (void)initLayout{
    [self addSubview:self.loadingImageView];
}

- (UIImageView *)loadingImageView{
    if (_loadingImageView == nil) {
        _loadingImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width / 2 - 35, self.frame.size.height / 2 - 35, 70, 70)];
        _loadingImageView.image = [UIImage imageNamed:@"maingear"];
        [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(rotateClick) userInfo:nil repeats:YES];
    }
    return _loadingImageView;
}

- (void)rotateClick{
    _loadingImageView.transform = CGAffineTransformRotate(_loadingImageView.transform, 0.08);
}


@end
