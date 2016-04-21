//
//  VideoViewController.m
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/3.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "VideoViewController.h"
#import "ConsultCell.h"
#import "HeadlineModel.h"
#import "ReturnRowHeightHelper.h"
#import "GetDateHelper.h"
#import "ConsultDetailViewController.h"
#import "MJRefresh.h"

@interface VideoViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSMutableArray *allModelArray;

@property (nonatomic,assign)NSInteger page;

@property (nonatomic,strong)LoadingView *loadingView;

@end

@implementation VideoViewController

#pragma mark - 懒加载
- (NSMutableArray *)allModelArray{
    if (_allModelArray == nil) {
        _allModelArray = [[NSMutableArray alloc]init];
    }
    return _allModelArray;
}
#pragma mark - 刷新页面时处理数据
- (void)refreshHandleData:(NSInteger)page{
    
    [[CDHttpHelper defaultCDHttpHelper] get:[videoUrlString stringByAppendingFormat:@"%ld",(long)self.page] params:nil success:^(id responseObj) {
        
        [FMDBSaveDataHelper FMDBSaveDataHelperWithData:responseObj andName:@"video"];
        
        
        if (responseObj != nil) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObj options:(NSJSONReadingAllowFragments) error:nil];
            if (self.page == 1) {
                [self.allModelArray removeAllObjects];
            }
            for (NSDictionary *dict in dic[@"data"]) {
                HeadlineModel *headline = [[HeadlineModel alloc]init];
                [headline setValuesForKeysWithDictionary:dict];
                [self.allModelArray addObject:headline];
            }
        }else{
            self.videoAndEventView.tableView.footerPullToRefreshText = @"没有更多数据了";
        }
        
        
    } failure:^(NSError *error) {
        
        FMDatabase *db = [FMDatabase databaseWithPath:[[GetDocumentsPathHelper shareGetDocumentsPathHelper] getDocumentsPath]];
        if ([db open]) {
            [db executeUpdate:@"create table if not exists videoPlayer (id integer primary key autoincrement NOT NULL,data blob NOT NULL,name text NOT NULL)"];
            FMResultSet *resultSet = [db executeQuery:@"select *from videoPlayer where name = 'video'"];
            id data = nil;
            while ([resultSet next]) {
                data = [resultSet dataForColumn:@"data"];
            }
            if (data != nil) {
                
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
                [self.allModelArray removeAllObjects];
                for (NSDictionary *dict in dic[@"data"]) {
                    HeadlineModel *headline = [[HeadlineModel alloc]init];
                    [headline setValuesForKeysWithDictionary:dict];
                    [self.allModelArray addObject:headline];
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
    
    
    
    
    self.view.frame = CGRectMake(0, 25, self.view.frame.size.width, self.view.frame.size.height - 25);
    self.view.backgroundColor = [UIColor whiteColor];
    self.videoAndEventView = [[VideoAndEventView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.videoAndEventView];
    
    self.videoAndEventView.tableView.delegate = self;
    self.videoAndEventView.tableView.dataSource = self;
    //默认只加载第一页的数据
    self.page = 1;
    //处理数据
//    [self handleData];
    [self setRefresh];
}
#pragma mark - 视图将要出现时取消选中的行
- (void)viewWillAppear:(BOOL)animated{
    
    if (self.allModelArray.count == 0) {
        self.loadingView = [[LoadingView alloc]initWithFrame:CGRectMake(0, 0, self.videoAndEventView.frame.size.width, self.videoAndEventView.frame.size.height - 64)];
        [self.videoAndEventView addSubview:self.loadingView];
    }
    
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
    ConsultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"videoCell"];
    if (cell == nil) {
        cell = [[ConsultCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"videoCell"];
    }
    //定义模型对象来接受数组中的模型数据
    HeadlineModel *headline = self.allModelArray[indexPath.row];
    [cell.picImageView sd_setImageWithURL:[NSURL URLWithString:headline.photo] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cell.titleLabel.text = headline.title;
    cell.subTitleLabel.text = headline.content;
    //设置tableViewCell里的subTitle自适应高度
    cell.subTitleLabel.frame = CGRectMake(CGRectGetMinX(cell.titleLabel.frame), CGRectGetMaxY(cell.titleLabel.frame) + 5, CGRectGetWidth(cell.titleLabel.frame), [[ReturnRowHeightHelper shareReturnRowHeightHelper] returnSubTitleHeight:headline.content andFontSize:13]);
    //如果阅读量不为0才显示到cell
    if (![headline.readCount isEqualToString:@"0"]) {
        cell.readCountLabel.text = [headline.readCount stringByAppendingString:@"  阅读"];
    }
    cell.timeLabel.text = [[GetDateHelper shareGetDateHelper] getDateWithTimeString:headline.time];

    [self.loadingView setHidden:YES];
    
    return cell;
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
    HeadlineModel *headline = self.allModelArray[indexPath.row];
    //切换到下个页面
    ConsultDetailViewController *consultDetailVC = [[ConsultDetailViewController alloc]init];
    
    //将artID数组传过去
    consultDetailVC.artId = headline.artId;
    consultDetailVC.type = headline.type;
    consultDetailVC.aTitle = headline.title;
    
    [self showViewController:consultDetailVC sender:nil];
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
