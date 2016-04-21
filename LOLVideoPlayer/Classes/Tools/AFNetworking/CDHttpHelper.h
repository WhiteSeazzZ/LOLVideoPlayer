//
//  CDHttpHelper.h
//  TextLogin
//
//  Created by 张赛赛 on 15/8/3.
//  Copyright (c) 2015年 张赛赛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDHttpHelper : NSObject
+ (CDHttpHelper *)defaultCDHttpHelper;
#pragma mark - 基本网络请求声明
/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
- (void)get:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure;
/**
 *  发送一个POST请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
- (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure;

@property (nonatomic, copy) void(^backBlock)(NSData *);
-(void)sendReportInfo:(NSString *)url andData:(NSData *)data;
- (void)sendReportInfo:(NSString *)url andData:(NSData *)data backData:(void (^)(NSData *))backData;
@end
