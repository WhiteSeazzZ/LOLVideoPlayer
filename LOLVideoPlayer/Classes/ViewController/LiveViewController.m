//
//  LiveViewController.m
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/2.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "LiveViewController.h"
#import "RequestUrlPlayVideoHelper.h"

@interface LiveViewController () <UIWebViewDelegate>

@property (nonatomic,strong)LoadingView *loadingView;

@end

@implementation LiveViewController

- (void)handleData{
    
    NSString *dataString = [NSString stringWithContentsOfURL:[NSURL URLWithString:self.urlString] encoding:NSUTF8StringEncoding error:nil];
    
    [self.consultDetailView.webView loadHTMLString:dataString baseURL:nil];
    self.consultDetailView.webView.alpha = 1;
    [self.loadingView setHidden:YES];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.loadingView = [[LoadingView alloc]initWithFrame:CGRectMake(0, 0, self.consultDetailView.frame.size.width, self.consultDetailView.frame.size.height - 64)];
    [self.consultDetailView addSubview:self.loadingView];
    
    //设置view的frame
    self.view.frame = CGRectMake(0, 25, self.view.frame.size.width, self.view.frame.size.height - 25);
    self.view.backgroundColor = [UIColor whiteColor];
    self.consultDetailView = [[ConsultDetailView alloc]initWithFrame:self.view.bounds];
    self.consultDetailView.webView.delegate = self;
    self.consultDetailView.webView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.consultDetailView.frame.size.height - 64 - 49);
    [self.view addSubview:self.consultDetailView];
    [self handleData];
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *urlString = [request.URL absoluteString];
        
    
    return [self handleVideoWithUrlString:urlString];
}

- (BOOL)handleVideoWithUrlString:(NSString *)urlString{
    if ([urlString hasPrefix:@"http://box.dwstatic.com/unsupport.php"]) {
        urlString = [urlString stringByReplacingCharactersInRange:NSMakeRange(0, 38) withString:@""];
        NSString *vid = nil;
        NSString *type = nil;
        //通过&把content数据分割
        NSArray *array = [urlString componentsSeparatedByString:@"&"];
        for (NSString *str in array) {
            if ([str hasPrefix:@"vid="]) {
                vid = [str substringFromIndex:4];
            }else if ([str hasPrefix:@"lolboxAction="]){
                type = [str substringFromIndex:13];
            }
        }
        if ([type isEqualToString:@"videoPlay"]) {
            //请求视频详情页面
            [[RequestUrlPlayVideoHelper shareRequestUrlPlayVideoHelper] requestUrlPlayVideoWithVid:vid andController:self];
            //进入播放状态后隐藏webView然后重新加载
            self.consultDetailView.webView.alpha = 0;
            [self handleData];
        }else if ([type isEqualToString:@"videoDownLoad"]){
            //下载视频
        }
        return NO;
    }else{
        return YES;
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
