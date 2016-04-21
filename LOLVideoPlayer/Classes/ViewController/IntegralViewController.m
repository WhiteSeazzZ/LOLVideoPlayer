//
//  IntegralViewController.m
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/2.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "IntegralViewController.h"
#import "RequestUrlPlayVideoHelper.h"
#import "SpecialViewController.h"

@interface IntegralViewController () <UIWebViewDelegate>
@property (nonatomic,strong)LoadingView *loadingView;

@end

@implementation IntegralViewController

- (void)handleData{
    
    NSString *dataString = [NSString stringWithContentsOfURL:[NSURL URLWithString:self.urlString] encoding:NSUTF8StringEncoding error:nil];
    [self.consultDetailView.webView loadHTMLString:dataString baseURL:nil];
    //不透明
    self.consultDetailView.webView.alpha = 1;
    [self.loadingView setHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loadingView = [[LoadingView alloc]initWithFrame:CGRectMake(0, 0, self.consultDetailView.frame.size.width, self.consultDetailView.frame.size.height - 64)];
    [self.consultDetailView addSubview:self.loadingView];
    
    // Do any additional setup after loading the view.
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
    
    [self handleDataWithUrlString:urlString];
    
    
    return YES;
}

- (void)handleDataWithUrlString:(NSString *)urlString{
    if ([urlString hasPrefix:@"http://box.dwstatic.com/unsupport.php"]) {
        //为了区分其它地方传过去值 这里将urlString中加个'='
        NSString *newUrlString = @"";
        NSArray *array = [urlString componentsSeparatedByString:@"&"];
        for (int i = 0; i < array.count; i++) {
            NSString *temp = array[i];
            if ([array[i] hasPrefix:@"topicId="]) {
                temp = [temp stringByReplacingCharactersInRange:NSMakeRange(7, 1) withString:@"=="];
            }
            
            newUrlString = [newUrlString stringByAppendingString:temp];
            //会少一个&  不加也没有关系 因为到下一个界面只要等号后面的
        }
        
        SpecialViewController *specialVC = [[SpecialViewController alloc]init];
        specialVC.destUrl = newUrlString;
        specialVC.aTitle = self.aTitle;
        [self showViewController:specialVC sender:nil];
        //隐藏webView然后重新加载
        self.consultDetailView.webView.alpha = 0;
        [self handleData];
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
