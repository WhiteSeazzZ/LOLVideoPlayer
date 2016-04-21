//
//  ReturnRowHeightHelper.h
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/2.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReturnRowHeightHelper : NSObject

+ (instancetype)shareReturnRowHeightHelper;
- (CGFloat)returnSubTitleHeight:(NSString *)string andFontSize:(NSInteger)fontSize;

@end
