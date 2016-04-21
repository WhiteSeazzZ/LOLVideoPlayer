//
//  CyclopediaDetailViewController.m
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/4.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "CyclopediaDetailViewController.h"
#import "ConsultDetailView.h"


@interface CyclopediaDetailViewController ()

@property (nonatomic,strong)ConsultDetailView *consultDetailView;
@property (nonatomic,strong)LoadingView *loadingView;

@end

@implementation CyclopediaDetailViewController

- (void)handleData{
    NSString *htmlString = [NSString stringWithContentsOfURL:[NSURL URLWithString:self.url] encoding:NSUTF8StringEncoding error:nil];
    [self.consultDetailView.webView loadHTMLString:htmlString baseURL:nil];
    [self.loadingView setHidden:YES];
}

- (void)loadView{
    self.consultDetailView = [[ConsultDetailView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.consultDetailView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.loadingView = [[LoadingView alloc]initWithFrame:CGRectMake(0, 0, self.consultDetailView.frame.size.width, self.consultDetailView.frame.size.height - 64)];
    [self.consultDetailView addSubview:self.loadingView];
    
    [self handleData];
    [self setNavigationBar];
    
}
- (void)setNavigationBar{
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    label.text = self.name;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    //设置titleView
    self.navigationItem.titleView = label;
    //设置返回按钮
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:(UIBarButtonItemStyleDone) target:nil action:nil];
    
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
