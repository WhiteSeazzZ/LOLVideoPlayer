//
//  ConsultViewController.m
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/1.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "ConsultViewController.h"
#import "ConsultView.h"
#import "ConsultCell.h"
#import "HeadlineModel.h"
#import "ConsultDetailViewController.h"
#import "SpecialViewController.h"
#import "ReturnRowHeightHelper.h"
#import "GetDateHelper.h"
#import "MJRefresh.h"
#import "SDCycleScrollView.h"
#import "VideoViewController.h"
#import "EventViewController.h"




@interface ConsultViewController () <SDCycleScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)ConsultView *consultView;
//定义3个用来接收数据的数组
@property (nonatomic,strong)NSMutableArray *bannerArray;
@property (nonatomic,strong)NSMutableArray *normalArray;
@property (nonatomic,strong)NSMutableArray *artIdArray;
@property (nonatomic,assign)NSInteger page;//记录刷新的页数
@property (nonatomic,assign)NSInteger index;//用来判断是否与page相同
@property (nonatomic,strong)SDCycleScrollView *cycleScrollView;
@property (nonatomic,strong)VideoViewController *videoVC;
@property (nonatomic,strong)EventViewController *eventVC;
@property (nonatomic,strong)LoadingView *loadingView;


@end

@implementation ConsultViewController

#pragma mark - 自定义的方法
- (void)setNavigationBar{
    //设置导航栏颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.281 green:0.281 blue:0.281 alpha:1]];
    //设置导航栏为不透明
    self.navigationController.navigationBar.translucent = NO;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    label.text = @"资讯";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    //设置titleView
    self.navigationItem.titleView = label;
    //设置返回按钮
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:(UIBarButtonItemStyleDone) target:nil action:nil];
    
}
//初始化方法
- (void)initMethod{
    self.bannerArray = [NSMutableArray array];
    self.normalArray = [NSMutableArray array];
    self.artIdArray = [NSMutableArray array];
    self.videoVC = [[VideoViewController alloc]init];
    [self addChildViewController:self.videoVC];
    self.eventVC = [[EventViewController alloc]init];
    [self addChildViewController:self.eventVC];
}
//处理数据
- (void)handleRotaionPictureData{
    /**
     * 自己写了一个下午的轮播图,用第三方10分组搞定......QAQ......不舍得删
     */
//    //为轮播图设置数据
//    for (int i = 0; i <= self.bannerArray.count + 1; i++) {
//        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * self.consultView.frame.size.width, 0, self.consultView.frame.size.width, CGRectGetHeight(self.consultView.rotationPicture.aScrollView.frame))];
//        imageView.userInteractionEnabled = YES;
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
//        [imageView addGestureRecognizer:tap];
//        if (i == 0) {
//            [imageView sd_setImageWithURL:[NSURL URLWithString:self.bannerArray[self.bannerArray.count - 1]] placeholderImage:nil];
//        }else if (i == self.bannerArray.count + 1){
//            [imageView sd_setImageWithURL:[NSURL URLWithString:self.bannerArray[0]] placeholderImage:nil];
//        }else{
//            [imageView sd_setImageWithURL:[NSURL URLWithString:self.bannerArray[i - 1]] placeholderImage:nil];
//        }
//        [self.consultView.rotationPicture.aScrollView addSubview:imageView];
//    }
//    //设置pageContrl的页数
//        self.consultView.rotationPicture.pageControl.numberOfPages = self.bannerArray.count;
//    //设置轮播图滚动范围
//    self.consultView.rotationPicture.aScrollView.contentSize = CGSizeMake(self.consultView.rotationPicture.frame.size.width * (self.bannerArray.count + 2), self.consultView.rotationPicture.frame.size.height);
    
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.consultView.frame.size.width, self.consultView.frame.size.height / 4 + 20) imageURLStringsGroup:self.bannerArray];
    self.cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    self.cycleScrollView.autoScrollTimeInterval = 3;
    self.cycleScrollView.delegate = self;
    self.consultView.tableView.tableHeaderView = self.cycleScrollView;
    
}

//轮播图imageView的手势点击事件
//- (void)tapClick{
//    //切换到下个页面
//    ConsultDetailViewController *consultDetailVC = [[ConsultDetailViewController alloc]init];
//    //将artID数组传过去
//    consultDetailVC.artId = self.artIdArray[self.consultView.rotationPicture.pageControl.currentPage];
//    [self showViewController:consultDetailVC sender:nil];

//}
////设置轮播图滚动
//- (void)setRotationPicture{
//    //轮播图的定时器
//    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerClick) userInfo:nil repeats:YES];
//    //设置scrollView的代理
//    self.consultView.rotationPicture.aScrollView.delegate = self;
//}
////定时器方法
//- (void)timerClick{
//    self.consultView.rotationPicture.pageControl.currentPage++;
//    if (self.consultView.rotationPicture.aScrollView.contentOffset.x == self.consultView.frame.size.width * self.bannerArray.count) {
//        self.consultView.rotationPicture.pageControl.currentPage = 0;
//        self.consultView.rotationPicture.aScrollView.contentOffset = CGPointMake(self.consultView.frame.size.width, 0);
//    }
//    [self.consultView.rotationPicture.aScrollView setContentOffset:CGPointMake(self.consultView.rotationPicture.pageControl.currentPage * self.consultView.frame.size.width + self.consultView.frame.size.width, 0) animated:YES];
//
//}

////scrollView代理方法
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    if (self.consultView.rotationPicture.aScrollView.contentOffset.x == (self.bannerArray.count + 1) * self.consultView.frame.size.width) {
//        self.consultView.rotationPicture.pageControl.currentPage = 0;
//        self.consultView.rotationPicture.aScrollView.contentOffset = CGPointMake(self.consultView.frame.size.width, 0);
//    }
//    if (self.consultView.rotationPicture.aScrollView.contentOffset.x == 0) {
//        self.consultView.rotationPicture.pageControl.currentPage = self.bannerArray.count - 1;
//        self.consultView.rotationPicture.aScrollView.contentOffset = CGPointMake(self.consultView.frame.size.width * self.bannerArray.count, 0);
//    }
//    self.consultView.rotationPicture.pageControl.currentPage = scrollView.contentOffset.x / self.consultView.frame.size.width - 1;
//}


- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    //切换到下个页面
    ConsultDetailViewController *consultDetailVC = [[ConsultDetailViewController alloc]init];
    //将artID数组传过去
    consultDetailVC.artId = self.artIdArray[index];
    [self showViewController:consultDetailVC sender:nil];
}

- (void)segmentControlClick:(UISegmentedControl *)segment{
    if (segment.selectedSegmentIndex == 0) {
        [self.videoVC.view removeFromSuperview];
        [self.eventVC.view removeFromSuperview];
    }else if (segment.selectedSegmentIndex == 1){
        [self.consultView addSubview:self.videoVC.view];
    }else if (segment.selectedSegmentIndex == 2){
        [self.consultView addSubview:self.eventVC.view];
    }
    
}

//刷新时根据页数处理数据
- (void)refreshHandleData:(NSInteger)page{

    [[CDHttpHelper defaultCDHttpHelper] get:[headerlineUrlString stringByAppendingFormat:@"%ld",(long)page] params:nil success:^(id responseObj) {
        if (responseObj != nil) {
            NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:responseObj options:(NSJSONReadingAllowFragments) error:nil];
            
            [FMDBSaveDataHelper FMDBSaveDataHelperWithData:responseObj andName:@"consult"];
            
            
            if (page == 1) {
                [self.normalArray removeAllObjects];
                self.index = -1;
                for (NSDictionary *dic in dataDic[@"headerline"]) {
                    [self.bannerArray addObject:dic[@"photo"]];
                    [self.artIdArray addObject:dic[@"artId"]];
                    
                }
                [self handleRotaionPictureData];
            }
            for (NSDictionary *dic in dataDic[@"data"]) {
                HeadlineModel *headline = [[HeadlineModel alloc]init];
                [headline setValuesForKeysWithDictionary:dic];
                if (self.index != page) {
                    [self.normalArray addObject:headline];
                }
            }
            self.index = page;
            
        }else{
            self.consultView.tableView.footerPullToRefreshText = @"没有更多数据了";
        }
        
        
        

    } failure:^(NSError *error){
        FMDatabase *db = [FMDatabase databaseWithPath:[[GetDocumentsPathHelper shareGetDocumentsPathHelper] getDocumentsPath]];
        if ([db open]) {
            
            [db executeUpdate:@"create table if not exists videoPlayer (id integer primary key autoincrement NOT NULL,data blob NOT NULL,name text NOT NULL)"];
            
            FMResultSet *resultSet = [db executeQuery:@"select *from videoPlayer where name = 'consult'"];
            
            
            id data = nil;
            while ([resultSet next]) {
                data = [resultSet dataForColumn:@"data"];
            }
            if (data != nil) {
                NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
                //if (page == 1) {
                [self.normalArray removeAllObjects];
                [self.bannerArray removeAllObjects];
                [self.artIdArray removeAllObjects];
                for (NSDictionary *dic in dataDic[@"headerline"]) {
                    [self.bannerArray addObject:dic[@"photo"]];
                    [self.artIdArray addObject:dic[@"artId"]];
                }
                [self handleRotaionPictureData];
                for (NSDictionary *dic in dataDic[@"data"]) {
                    HeadlineModel *headline = [[HeadlineModel alloc]init];
                    [headline setValuesForKeysWithDictionary:dic];
                    [self.normalArray addObject:headline];
                }
                [db close];

            }
        }

    }];
    
}

- (void)setRefresh{
    // dateKey用于存储刷新时间，可以保证不同界面拥有不同的刷新时间
    [self.consultView.tableView addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:@"table"];
    //第一次进入时下拉刷新
//    [self.consultView.tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.consultView.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
}
- (void)headerRereshing
{
    self.page = 1;
    [self.bannerArray removeAllObjects];
    [self.artIdArray removeAllObjects];
    // 1.处理添加数据
    [self refreshHandleData:self.page];
    
    // 2.模拟2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.consultView.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.consultView.tableView headerEndRefreshing];
    });
}

- (void)footerRereshing
{
    self.page++;
    
    // 1.添加数据
    [self refreshHandleData:self.page];
    
    // 2.模拟2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.consultView.tableView reloadData];
        
        //调用endRefreshing可以结束刷新状态
        [self.consultView.tableView footerEndRefreshing];
    });
}


//设置tableView属性
- (void)setTableView{
    self.consultView.tableView.delegate = self;
    self.consultView.tableView.dataSource = self;
    
}




#pragma mark - 代理方法和数据源方法
//tableViewCell设置每行的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ConsultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"consultReuseIdentifier"];
    if (cell == nil) {
        cell = [[ConsultCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"consultReuseIdentifier"];
    }
    //定义模型对象来接受数组中的模型数据
    HeadlineModel *headline = self.normalArray[indexPath.row];
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

//选择某行执行的操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HeadlineModel *headline = self.normalArray[indexPath.row];
    //判断是否点击的是专题页面
    if ([headline.type isEqualToString:@"topic"]) {
        SpecialViewController *specialVC = [[SpecialViewController alloc]init];
        specialVC.destUrl = headline.destUrl;
        specialVC.aTitle = headline.title;
        [self showViewController:specialVC sender:nil];
    }else{
        //切换到下个页面
        ConsultDetailViewController *consultDetailVC = [[ConsultDetailViewController alloc]init];
        
        //将artID数组传过去
        consultDetailVC.artId = headline.artId;
        consultDetailVC.type = headline.type;
        consultDetailVC.aTitle = headline.title;
        [self showViewController:consultDetailVC sender:nil];
    }
    
}
//设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 94;
}
//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.normalArray.count;
}

#pragma mark - 系统方法

- (void)loadView{
    self.consultView = [[ConsultView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.consultView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loadingView = [[LoadingView alloc]initWithFrame:CGRectMake(0, 0, self.consultView.frame.size.width, self.consultView.frame.size.height - 64)];
    [self.consultView addSubview:self.loadingView];
    
    self.page = 1;
    self.index = -1;
    self.consultView.count = self.normalArray.count;
    [self.consultView.tableView reloadData];
    //设置导航
    [self setNavigationBar];
    //初始化
    [self initMethod];
    //刷新方法
    [self setRefresh];
    //设置轮播图滚动
//    [self setRotationPicture];
    //设置tableView
    [self setTableView];
    
    [self.consultView.segmentControl addTarget:self action:@selector(segmentControlClick:) forControlEvents:(UIControlEventValueChanged)];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    if (self.normalArray.count == 0) {
        [self headerRereshing];
    }
    
    if ([self.consultView.tableView indexPathForSelectedRow] != nil) {
        [self.consultView.tableView deselectRowAtIndexPath:[self.consultView.tableView indexPathForSelectedRow] animated:YES];
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
