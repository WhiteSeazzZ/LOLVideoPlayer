//
//  IntegralViewController.h
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/2.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConsultDetailView.h"

@interface IntegralViewController : UIViewController

@property (nonatomic,strong)ConsultDetailView *consultDetailView;
@property (nonatomic,copy)NSString *urlString;
@property (nonatomic,copy)NSString *aTitle;

@end
