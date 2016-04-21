//
//  ConsultDetailViewController.m
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/1.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "ConsultDetailViewController.h"
#import "ConsultDetailView.h"
#import "RequestUrlPlayVideoHelper.h"
#import "DownLoadHelper.h"
#import "DownLoadViewController.h"


@interface ConsultDetailViewController () <UIWebViewDelegate>

@property (nonatomic,strong)ConsultDetailView *consultDetailView;
@property (nonatomic,strong)NSString *content;
@property (nonatomic,assign)NSInteger vid;
@property (nonatomic,strong)LoadingView *loadingView;

@end

@implementation ConsultDetailViewController

- (void)handleData{
    [[CDHttpHelper defaultCDHttpHelper] get:[headerlineDetailUrlString stringByAppendingString:self.artId] params:nil success:^(id responseObj) {
        [FMDBSaveDataHelper FMDBSaveDataHelperWithData:responseObj andName:[@"consultDetail" stringByAppendingString:self.artId]];
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObj options:(NSJSONReadingAllowFragments) error:nil];
        
        NSDictionary *dict = dic[@"data"];
        self.content = dict[@"content"];
        [self.consultDetailView.webView loadHTMLString:self.content baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
        
        //设置webView为不透明
        self.consultDetailView.webView.alpha = 1;
        
        [self.loadingView setHidden:YES];
    } failure:^(NSError *error) {
        FMDatabase *db = [FMDatabase databaseWithPath:[[GetDocumentsPathHelper shareGetDocumentsPathHelper] getDocumentsPath]];
        if ([db open]) {
            
            [db executeUpdate:@"create table if not exists videoPlayer (id integer primary key autoincrement NOT NULL,data blob NOT NULL,name text NOT NULL)"];
            
            FMResultSet *resultSet = [db executeQuery:@"select *from videoPlayer where name = ?",[@"consultDetail" stringByAppendingString:self.artId]];
            
            
            id data = nil;
            while ([resultSet next]) {
                data = [resultSet dataForColumn:@"data"];
            }
            if (data != nil) {
                
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
                
                NSDictionary *dict = dic[@"data"];
                self.content = dict[@"content"];
                [self.consultDetailView.webView loadHTMLString:self.content baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
                
                //设置webView为不透明
                self.consultDetailView.webView.alpha = 1;
                
                [self.loadingView setHidden:YES];

                [db close];
                
            }
        }


    }];
}
//清除敏感词汇
- (void)setContent:(NSString *)content{
    _content = [content stringByReplacingOccurrencesOfString:@"多玩" withString:@""];
    _content = [_content stringByReplacingOccurrencesOfString:@"下载" withString:@""];
    _content = [_content stringByReplacingOccurrencesOfString:@"点击" withString:@""];
//    _content = [content stringByReplacingOccurrencesOfString:@"点击" withString:@""];
//    _content = [content stringByReplacingOccurrencesOfString:@"" withString:@""];
    
}


- (void)setNavigationBar{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    label.text = @"资讯";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    //设置title
    self.navigationItem.titleView = label;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    //设置返回按钮
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:(UIBarButtonItemStyleDone) target:nil action:nil];
}

- (void)loadView{
    self.consultDetailView = [[ConsultDetailView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.consultDetailView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loadingView = [[LoadingView alloc]initWithFrame:CGRectMake(0, 0, self.consultDetailView.frame.size.width, self.consultDetailView.frame.size.height - 64)];
    [self.consultDetailView addSubview:self.loadingView];
                 
    [self handleData];
    [self setNavigationBar];
    self.consultDetailView.webView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    if ([request.URL isEqual:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]]) {
        
        return YES;
        
    }else{
        if ([self.type isEqualToString:@"video"]) {

            NSString *urlString = [request.URL absoluteString];
            [self handleVideoWithUrlString:urlString];
            
        }
    }
    return YES;
}

- (void)handleVideoWithUrlString:(NSString *)urlString{
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
        }else if ([str hasPrefix:@"?lolboxAction="]){
            type = [str substringFromIndex:14];
        }
    }
    if ([type isEqualToString:@"videoPlay"]) {
        //请求视频详情页面
        [[RequestUrlPlayVideoHelper shareRequestUrlPlayVideoHelper] requestUrlPlayVideoWithVid:vid andController:self];
        
        [self.loadingView setHidden:NO];
        
        //进入播放状态后隐藏webView然后重新加载
        self.consultDetailView.webView.alpha = 0;
        [self handleData];
    }else if ([type isEqualToString:@"videoDownLoad"]){
        
//        DownLoadViewController *downLoadVC = [[DownLoadViewController alloc]init];
//        downLoadVC.vid = vid;
//        downLoadVC.aTitle = self.aTitle;
//        if ([DownLoadHelper shareDownLoadHelper].allDownLoadingArray.count == 0) {
        
//            self.vid = [vid integerValue];
            
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"抱歉!" message:@"该视频暂不支持下载功能!" preferredStyle:(UIAlertControllerStyleAlert)];
//            UIAlertAction *action = [UIAlertAction actionWithTitle:@"流畅" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
//                downLoadVC.distinct = @"350";
//                
//                [self showViewController:downLoadVC sender:nil];
//            }];
//            UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"高清" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
//                downLoadVC.distinct = @"1000";
//                
//                [self showViewController:downLoadVC sender:nil];
//            }];
//            UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"超清" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
//                downLoadVC.distinct = @"1300";
//                [self showViewController:downLoadVC sender:nil];
//            }];
//            UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"不想下载了" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
//                
//            }];
//
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
            [alertC addAction:action];
//            [alertC addAction:action2];
//            [alertC addAction:action3];
//            [alertC addAction:action4];
            
            [self presentViewController:alertC animated:YES completion:^{
                
            }];

//        }else{
//            [self showViewController:downLoadVC sender:nil];
//        }
        
        [self.loadingView setHidden:NO];
        
        self.consultDetailView.webView.alpha = 0;
        [self handleData];
    }
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
