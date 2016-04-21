//
//  SpecialViewController.m
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/1.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "SpecialViewController.h"
#import "SpecialView.h"
#import "SpecialModel.h"
#import "TopicModel.h"
#import "HeadlineModel.h"
#import "ConsultCell.h"
#import "ReturnRowHeightHelper.h"
#import "GetDateHelper.h"
#import "ConsultDetailViewController.h"
#import "LiveViewController.h"
#import "IntegralViewController.h"

@interface SpecialViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)SpecialView *specialView;
//存放专题的分类
@property (nonatomic,strong)NSMutableArray *classesArray;
//分段控件的内容
@property (nonatomic,strong)NSMutableArray *segmentArray;
//存放所有data数据的数组
@property (nonatomic,strong)NSMutableArray *allDataArray;
//容器视图控制器
@property (nonatomic,strong)LiveViewController *liveVC;
@property (nonatomic,strong)IntegralViewController *integralVC;

@property (nonatomic,strong)LoadingView *loadingView;


@end

@implementation SpecialViewController

- (void)setNavigationBar{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    label.text = self.aTitle;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    //设置titleView
    self.navigationItem.titleView = label;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    //设置返回按钮
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@" " style:(UIBarButtonItemStyleDone) target:nil action:nil];
}

- (void)initMethod{
    //添加子视图控制器
    self.liveVC = [[LiveViewController alloc]init];
    [self addChildViewController:self.liveVC];
    self.integralVC = [[IntegralViewController alloc]init];
    [self addChildViewController:self.integralVC];
    self.classesArray = [NSMutableArray array];
    self.segmentArray = [NSMutableArray array];
    self.allDataArray = [NSMutableArray array];
}

- (void)addSegment{
    //初始化分段空间并设置内容
    self.specialView.segmentControl = [[UISegmentedControl alloc]initWithItems:self.segmentArray];
    //分段控件的背景颜色
    self.specialView.segmentControl.backgroundColor = [UIColor whiteColor];
    //选中某个控件的颜色
    self.specialView.segmentControl.tintColor = [UIColor whiteColor];
    //设置默认字体颜色
    [self.specialView.segmentControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.281 green:0.281 blue:0.281 alpha:1]} forState:(UIControlStateNormal)];
    //设置选中的字体颜色
    [self.specialView.segmentControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.94 green:0.34 blue:0.07 alpha:1],NSFontAttributeName:[UIFont systemFontOfSize:16]} forState:(UIControlStateSelected)];
    self.specialView.segmentControl.frame = CGRectMake(0, 0, self.specialView.bounds.size.width, 25);
    //默认选中第一个
    self.specialView.segmentControl.selectedSegmentIndex = 0;
    //添加事件
    [self.specialView.segmentControl addTarget:self action:@selector(segmentClick:) forControlEvents:(UIControlEventValueChanged)];
    //将分段控件添加到滚动视图上
    [self.specialView addSubview:self.specialView.segmentControl];
}
//当segmentControl值放生改变时触发方法
- (void)segmentClick:(UISegmentedControl *)segment{
    if (segment.selectedSegmentIndex == 0) {
        [self.liveVC.view removeFromSuperview];
        [self.integralVC.view removeFromSuperview];
    }else if (segment.selectedSegmentIndex == 1) {
        SpecialModel *special = self.classesArray[1];
        self.liveVC.urlString = special.url;
        [self.specialView addSubview:self.liveVC.view];
    }else if (segment.selectedSegmentIndex == 2){
        SpecialModel *special = self.classesArray[2];
        self.integralVC.urlString = special.url;
        self.integralVC.aTitle = self.aTitle;
        [self.specialView addSubview:self.integralVC.view];
    }
}

- (void)setTableView{
    self.specialView.tableView.delegate = self;
    self.specialView.tableView.dataSource = self;
}

//根据destUrl获取topicId
- (NSString *)getId:(NSString *)string{
    NSArray *array = [string componentsSeparatedByString:@"="];
    return [array lastObject];
}
//处理数据
- (void)handleData{
    [[CDHttpHelper defaultCDHttpHelper] get:[specialUrlString stringByAppendingString:[self getId:self.destUrl]] params:nil success:^(id responseObj) {
        
        [FMDBSaveDataHelper FMDBSaveDataHelperWithData:responseObj andName:@"special"];
        
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObj options:(NSJSONReadingAllowFragments) error:nil];
        for (NSDictionary *dict in dic[@"data"]) {
            //创建模型对象
            SpecialModel *special = [[SpecialModel alloc]init];
            [special setValuesForKeysWithDictionary:dict];
            [self.classesArray addObject:special];
            //去掉专题
            if ([special.title hasSuffix:@"专题"]) {
                special.title = [special.title substringToIndex:special.title.length - 2];
            }
            //设置分段控件的内容
            [self.segmentArray addObject:special.title];
            //判断type
            if ([special.type isEqualToString:@"topic"]) {
                TopicModel *topic = [[TopicModel alloc]init];
                [topic setValuesForKeysWithDictionary:special.data];
                [self.specialView.picImageView sd_setImageWithURL:[NSURL URLWithString:topic.photo] placeholderImage:[UIImage imageNamed:@"placeholder"]];
                self.specialView.titleLabel.text = topic.content;
                for (NSDictionary *dictionary in topic.news) {
                    //模型
                    HeadlineModel *headline = [[HeadlineModel alloc]init];
                    [headline setValuesForKeysWithDictionary:dictionary];
                    [self.allDataArray addObject:headline];
                }
            }
            [self.specialView.tableView reloadData];
        }
        
        //添加分段控件
        [self addSegment];
        if ([self.destUrl containsString:@"=="]) {
            self.specialView.tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);
            self.specialView.segmentControl.alpha = 0;
        }
        
    } failure:^(NSError *error) {
        
        self.specialView.tableView.frame = CGRectMake(0, 0, self.specialView.frame.size.width, self.specialView.frame.size.height);
        
        FMDatabase *db = [FMDatabase databaseWithPath:[[GetDocumentsPathHelper shareGetDocumentsPathHelper] getDocumentsPath]];
        if ([db open]) {
            [db executeUpdate:@"create table if not exists videoPlayer (id integer primary key autoincrement NOT NULL,data blob NOT NULL,name text NOT NULL)"];
            FMResultSet *resultSet = [db executeQuery:@"select *from videoPlayer where name = 'special'"];
            id data = nil;
            while ([resultSet next]) {
                data = [resultSet dataForColumn:@"data"];
            }
            if (data != nil) {
                
                
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
                for (NSDictionary *dict in dic[@"data"]) {
                    //创建模型对象
                    SpecialModel *special = [[SpecialModel alloc]init];
                    [special setValuesForKeysWithDictionary:dict];
                    [self.classesArray addObject:special];
                    //去掉专题
                    if ([special.title hasSuffix:@"专题"]) {
                        special.title = [special.title substringToIndex:special.title.length - 2];
                    }
                    //设置分段控件的内容
                    [self.segmentArray addObject:special.title];
                    //判断type
                    if ([special.type isEqualToString:@"topic"]) {
                        TopicModel *topic = [[TopicModel alloc]init];
                        [topic setValuesForKeysWithDictionary:special.data];
                        [self.specialView.picImageView sd_setImageWithURL:[NSURL URLWithString:topic.photo] placeholderImage:[UIImage imageNamed:@"placeholder"]];
                        self.specialView.titleLabel.text = topic.content;
                        for (NSDictionary *dictionary in topic.news) {
                            //模型
                            HeadlineModel *headline = [[HeadlineModel alloc]init];
                            [headline setValuesForKeysWithDictionary:dictionary];
                            [self.allDataArray addObject:headline];
                        }
                    }
                    [self.specialView.tableView reloadData];
                }

                
                
                [db close];
                
            }
        }

    }];
}

- (void)loadView{
    self.specialView = [[SpecialView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.specialView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.loadingView = [[LoadingView alloc]initWithFrame:CGRectMake(0, 0, self.specialView.frame.size.width, self.specialView.frame.size.height - 64)];
    [self.specialView addSubview:self.loadingView];
    
    [self setNavigationBar];
    [self initMethod];
    [self handleData];
    [self setTableView];
}
- (void)viewWillAppear:(BOOL)animated{
    if ([self.specialView.tableView indexPathForSelectedRow] != nil) {
        [self.specialView.tableView deselectRowAtIndexPath:[self.specialView.tableView indexPathForSelectedRow] animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView 代理 数据源
//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ConsultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"specialReuseIdentifier"];
    if (cell == nil) {
        cell = [[ConsultCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"specialReuseIdentifier"];
    }
    HeadlineModel *headline = self.allDataArray[indexPath.row];
    [cell.picImageView sd_setImageWithURL:[NSURL URLWithString:headline.photo] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cell.titleLabel.text = headline.title;
    cell.subTitleLabel.text = headline.content;
    //设置tableViewCell里的subTitle自适应高度
    cell.subTitleLabel.frame = CGRectMake(CGRectGetMinX(cell.titleLabel.frame), CGRectGetMaxY(cell.titleLabel.frame) + 5, CGRectGetWidth(cell.titleLabel.frame), [[ReturnRowHeightHelper shareReturnRowHeightHelper] returnSubTitleHeight:headline.content andFontSize:13]);
    cell.timeLabel.text = [[GetDateHelper shareGetDateHelper] getDateWithTimeString:headline.time];
    
    [self.loadingView setHidden:YES];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ConsultDetailViewController *consultDetailVC = [[ConsultDetailViewController alloc]init];
    HeadlineModel *headline = self.allDataArray[indexPath.row];
    consultDetailVC.artId = [self getId:headline.destUrl];
    consultDetailVC.type = headline.type;
    consultDetailVC.aTitle = headline.title;
    [self showViewController:consultDetailVC sender:nil];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.allDataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 94;
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
