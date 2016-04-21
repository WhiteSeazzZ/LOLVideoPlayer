//
//  UserViewController.m
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/1.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "UserViewController.h"
#import "ConsultDetailView.h"

@interface UserViewController () <UIWebViewDelegate>

@property (nonatomic,strong)ConsultDetailView *consultDetail;

@end

@implementation UserViewController

- (void)loadView{
    self.consultDetail = [[ConsultDetailView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.consultDetail;
}

#pragma mark - 设置导航栏
- (void)setNavigationBar{
    //设置导航栏颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.281 green:0.281 blue:0.281 alpha:1]];
    //设置导航栏为不透明
    self.navigationController.navigationBar.translucent = NO;
    //自定义导航栏
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    label.text = @"召唤师查询";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    //设置title
    self.navigationItem.titleView = label;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    self.consultDetail.webView.frame = CGRectMake(0, 0, self.consultDetail.frame.size.width, self.consultDetail.frame.size.height);
    
    [self.consultDetail.webView loadHTMLString:[NSString stringWithContentsOfURL:[NSURL URLWithString:searchPlayerUrlString] encoding:NSUTF8StringEncoding error:nil] baseURL:nil];
    
    self.consultDetail.webView.delegate = self;
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *urlString = [NSString stringWithFormat:@"%@",request.URL];

    
    if ([urlString hasPrefix:@"applewebdata:"]) {
        NSString *serverName = nil;

        NSArray *array = [urlString componentsSeparatedByString:@"&"];
        for (int i = 0; i < array.count; i++) {
            if ([array[i] hasPrefix:@"serverName="]) {
                serverName = [array[i] substringFromIndex:11];

            }
        }
        //更新webView
        [self.consultDetail.webView loadHTMLString:[NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:searchResultUrlString,serverName,serverName]] encoding:NSUTF8StringEncoding error:nil] baseURL:nil];
    }else if ([urlString hasPrefix:@"http://zdl.mbox.duowan.com/phone/matchListNew.php?"]){
        return NO;
    }
    

    return YES;
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
