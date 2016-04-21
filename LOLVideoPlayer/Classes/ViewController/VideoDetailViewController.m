//
//  VideoDetailViewController.m
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/4.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "VideoDetailViewController.h"
#import "ReturnRowHeightHelper.h"
#import "GetDateHelper.h"
#import "ConsultDetailViewController.h"
#import "MJRefresh.h"
#import "VideoDetailCell.h"
#import "ClassifyNavigationDetailModel.h"
#import "RequestUrlPlayVideoHelper.h"
#import "DownLoadViewController.h"
#import "DownLoadHelper.h"

@interface VideoDetailViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSMutableArray *allModelArray;

@property (nonatomic,assign)NSInteger page;

@property (nonatomic,strong)LoadingView *loadingView;

@property (nonatomic,copy)NSString *vid;
@property (nonatomic,copy)NSString *aTitle;

@end

@implementation VideoDetailViewController

#pragma mark - 设置导航栏
- (void)setNavigationBar{
    //自定义导航栏
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    label.text = @"解说视频";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    //设置title
    self.navigationItem.titleView = label;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    //设置返回按钮
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:(UIBarButtonItemStyleDone) target:nil action:nil];
}

#pragma mark - 懒加载
- (NSMutableArray *)allModelArray{
    if (_allModelArray == nil) {
        _allModelArray = [[NSMutableArray alloc]init];
    }
    return _allModelArray;
}
#pragma mark - 刷新页面时处理数据
- (void)refreshHandleData:(NSInteger)page{
    
    [[CDHttpHelper defaultCDHttpHelper] get:[NSString stringWithFormat:classifyNavigationDetailUrlString,self.tag,self.page] params:nil success:^(id responseObj) {
        
        [FMDBSaveDataHelper FMDBSaveDataHelperWithData:responseObj andName:[@"videoDetail" stringByAppendingString:self.tag]];
        
        
        if (responseObj != nil) {
            NSArray *array = [NSJSONSerialization JSONObjectWithData:responseObj options:(NSJSONReadingAllowFragments) error:nil];
            if (self.page == 1) {
                [self.allModelArray removeAllObjects];
            }
            for (NSDictionary *dict in array) {
                ClassifyNavigationDetailModel *classifyNavigationDetailModel = [[ClassifyNavigationDetailModel alloc]init];
                [classifyNavigationDetailModel setValuesForKeysWithDictionary:dict];
                [self.allModelArray addObject:classifyNavigationDetailModel];
            }
        }else{
            self.videoAndEventView.tableView.footerPullToRefreshText = @"没有更多数据了";
        }
        
        
    } failure:^(NSError *error) {
        FMDatabase *db = [FMDatabase databaseWithPath:[[GetDocumentsPathHelper shareGetDocumentsPathHelper] getDocumentsPath]];
        if ([db open]) {
            
            [db executeUpdate:@"create table if not exists videoPlayer (id integer primary key autoincrement NOT NULL,data blob NOT NULL,name text NOT NULL)"];
            
            FMResultSet *resultSet = [db executeQuery:@"select *from videoPlayer where name = ?",[@"videoDetail" stringByAppendingString:self.tag]];
            
            id data = nil;
            while ([resultSet next]) {
                data = [resultSet dataForColumn:@"data"];
            }
            if (data != nil) {
                NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
                if (self.page == 1) {
                    [self.allModelArray removeAllObjects];
                }
                for (NSDictionary *dict in array) {
                    ClassifyNavigationDetailModel *classifyNavigationDetailModel = [[ClassifyNavigationDetailModel alloc]init];
                    [classifyNavigationDetailModel setValuesForKeysWithDictionary:dict];
                    [self.allModelArray addObject:classifyNavigationDetailModel];
                }

                
                [db close];
                
            }
        }

        

    }];
    
}
#pragma mark - 设置刷新方法
- (void)setRefresh{
    // dateKey用于存储刷新时间，可以保证不同界面拥有不同的刷新时间
    [self.videoAndEventView.tableView addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:@"table"];
    
    [self.videoAndEventView.tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.videoAndEventView.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
}
#pragma mark - 下拉刷新
- (void)headerRereshing
{
    self.page = 1;
    // 1.处理添加数据
    [self refreshHandleData:self.page];
    
    // 2.模拟2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.videoAndEventView.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.videoAndEventView.tableView headerEndRefreshing];
    });
}
#pragma mark - 上拉加载
- (void)footerRereshing
{
    self.page++;
    
    // 1.添加数据
    [self refreshHandleData:self.page];
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.videoAndEventView.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.videoAndEventView.tableView footerEndRefreshing];
    });
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.loadingView = [[LoadingView alloc]initWithFrame:CGRectMake(0, 0, self.videoAndEventView.frame.size.width, self.videoAndEventView.frame.size.height - 64)];
    [self.videoAndEventView addSubview:self.loadingView];
    
    //设置导航栏
    [self setNavigationBar];
    
    self.view.frame = CGRectMake(0, 25, self.view.frame.size.width, self.view.frame.size.height - 25);
    self.view.backgroundColor = [UIColor whiteColor];
    self.videoAndEventView = [[VideoAndEventView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.videoAndEventView];
    
    self.videoAndEventView.tableView.frame = CGRectMake(0, 0, self.videoAndEventView.frame.size.width, self.videoAndEventView.frame.size.height - 64 + 25);
    self.videoAndEventView.tableView.delegate = self;
    self.videoAndEventView.tableView.dataSource = self;
    //默认只加载第一页的数据
    self.page = 1;
    //处理数据
    //    [self handleData];
    [self setRefresh];
    
    //添加监听
    
    
}

#pragma mark - 视图将要出现时取消选中的行
- (void)viewWillAppear:(BOOL)animated{
    if ([self.videoAndEventView.tableView indexPathForSelectedRow] != nil) {
        [self.videoAndEventView.tableView deselectRowAtIndexPath:[self.videoAndEventView.tableView indexPathForSelectedRow] animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 设置tableView的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VideoDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"videoCell"];
    if (cell == nil) {
        cell = [[VideoDetailCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"videoCell"];
    }
    //定义模型对象来接受数组中的模型数据
    ClassifyNavigationDetailModel *classifyNavigationDetailModel = self.allModelArray[indexPath.row];
    [cell.picImageView sd_setImageWithURL:[NSURL URLWithString:classifyNavigationDetailModel.cover_url] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cell.titleLabel.text = classifyNavigationDetailModel.title;
//    //设置tableViewCell里的subTitle自适应高度
    cell.titleLabel.frame = CGRectMake(CGRectGetMaxX(cell.picImageView.frame) + 7, 17, [UIScreen mainScreen].bounds.size.width - 21 - CGRectGetWidth(cell.picImageView.frame), [[ReturnRowHeightHelper shareReturnRowHeightHelper] returnSubTitleHeight:classifyNavigationDetailModel.title andFontSize:14]);
    
    cell.timeLabel.text = [classifyNavigationDetailModel.upload_time substringWithRange:NSMakeRange(5, 5)];
//    
    cell.durationLabel.text = [NSString stringWithFormat:@"%ld:%ld",classifyNavigationDetailModel.video_length / 60,classifyNavigationDetailModel.video_length % 60];
    
    self.vid = classifyNavigationDetailModel.vid;
    self.aTitle = classifyNavigationDetailModel.title;
    
    [cell.downLoadButton addTarget:self action:@selector(downLoadButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    
    [self.loadingView setHidden:YES];
    
    return cell;
}

- (void)downLoadButtonClick{
    DownLoadViewController *downLoadVC = [[DownLoadViewController alloc]init];
    downLoadVC.vid = self.vid;
    downLoadVC.aTitle = self.aTitle;
    if ([DownLoadHelper shareDownLoadHelper].allDownLoadingArray.count == 0) {
        
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"请选择一种画质:" message:@"" preferredStyle:(UIAlertControllerStyleActionSheet)];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"流畅" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            downLoadVC.distinct = @"350";
            
            [self showViewController:downLoadVC sender:nil];
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"高清" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            downLoadVC.distinct = @"1000";
            
            [self showViewController:downLoadVC sender:nil];
        }];
        UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"超清" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            downLoadVC.distinct = @"1300";
            [self showViewController:downLoadVC sender:nil];
        }];
        UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"不想下载了" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertC addAction:action];
        [alertC addAction:action2];
        [alertC addAction:action3];
        [alertC addAction:action4];
        
        [self presentViewController:alertC animated:YES completion:^{
            
        }];
    }else{
        [self showViewController:downLoadVC sender:nil];
    }


}


#pragma mark - 设置tableView行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.allModelArray.count;
}
#pragma mark - 设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 94;
}
#pragma mark - 选择某行执行的操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    ClassifyNavigationDetailModel *classifyNavigationDetailModel = self.allModelArray[indexPath.row];
    
    [[RequestUrlPlayVideoHelper shareRequestUrlPlayVideoHelper] requestUrlPlayVideoWithVid:classifyNavigationDetailModel.vid andController:self];
    

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
