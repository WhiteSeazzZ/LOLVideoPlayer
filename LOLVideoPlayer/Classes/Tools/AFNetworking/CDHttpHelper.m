//
//  CDHttpHelper.m
//  TextLogin
//
//  Created by 张赛赛 on 15/8/3.
//  Copyright (c) 2015年 张赛赛. All rights reserved.
//

#import "CDHttpHelper.h"
#import "AFNetworking.h"

@implementation CDHttpHelper

+ (CDHttpHelper *)defaultCDHttpHelper
{
    static CDHttpHelper *httpHelper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        httpHelper = [[CDHttpHelper alloc] init];
    });
    return httpHelper;
}
#pragma mark get数据请求
- (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
    [securityPolicy setAllowInvalidCertificates:YES];
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    [mgr setSecurityPolicy:securityPolicy];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    [mgr.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
//            NSLog(@"success --- %@", responseObject);
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
- (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSLog(@"params:%@", params);
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    mgr.requestSerializer = [AFJSONRequestSerializer serializer];

    [mgr.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    [mgr POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            NSLog(@"%@",error);
            failure(error);
        }
    }];
}
-(void)sendReportInfo:(NSString *)url andData:(NSData *)data
{
    NSURL *urlData = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlData cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:15];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSInputStream *inputStream = [NSInputStream inputStreamWithData:data];
    [request setHTTPBodyStream:inputStream];
    __weak CDHttpHelper *http = self;
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data == nil) {
            NSLog(@"------99999999%@",connectionError);
            return;
        }
        else{
            http.backBlock(data);
        }
    }];
}
- (void)sendReportInfo:(NSString *)url andData:(NSData *)data backData:(void (^)(NSData *))backData
{
    NSURL *urlData = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlData cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:15];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSInputStream *inputStream = [NSInputStream inputStreamWithData:data];
    [request setHTTPBodyStream:inputStream];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data == nil) {
            NSLog(@"------99999999%@",connectionError);
            return;
        }
        else{
            backData(data);
        }
    }];
}
@end
