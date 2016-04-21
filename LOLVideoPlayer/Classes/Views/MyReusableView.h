//
//  MyReusableView.h
//  HappyVideoPlayer
//
//  Created by lanou3g on 16/2/27.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyReusableView : UICollectionReusableView

@property (nonatomic,strong)UILabel *label;

- (void)setLabelText:(NSString *)text;

@end
