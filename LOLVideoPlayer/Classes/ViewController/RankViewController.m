//
//  RankViewController.m
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/6.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "RankViewController.h"
#import "RankCell.h"
#import "RankView.h"
#import "RankModel.h"

@interface RankViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)RankView *rankView;
@property (nonatomic,strong)NSMutableArray *allModelArray;
@property (nonatomic,strong)UISegmentedControl *segment;
@property (nonatomic,copy)void (^block)(NSMutableArray *array);
@property (nonatomic,strong)LoadingView *loadingView;

@end

@implementation RankViewController

- (void)loadView{
    self.rankView = [[RankView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.rankView;
}

- (void)handleData{
    [[CDHttpHelper defaultCDHttpHelper] get:[rankDataUrlString stringByAppendingFormat:@"%ld",self.segment.selectedSegmentIndex + 1]  params:nil success:^(id responseObj) {
        
        [FMDBSaveDataHelper FMDBSaveDataHelperWithData:responseObj andName:@"rank"];
        
        NSArray *array = [NSJSONSerialization JSONObjectWithData:responseObj options:(NSJSONReadingAllowFragments) error:nil];
        for (NSDictionary *dic in array) {
            RankModel *rankModel = [[RankModel alloc]init];
            [rankModel setValuesForKeysWithDictionary:dic];
            [self.allModelArray addObject:rankModel];
        }
        
        self.block(self.allModelArray);
        [self.rankView.tableView reloadData];
        
    } failure:^(NSError *error) {
        FMDatabase *db = [FMDatabase databaseWithPath:[[GetDocumentsPathHelper shareGetDocumentsPathHelper] getDocumentsPath]];
        if ([db open]) {
            [db executeUpdate:@"create table if not exists videoPlayer (id integer primary key autoincrement NOT NULL,data blob NOT NULL,name text NOT NULL)"];
            FMResultSet *resultSet = [db executeQuery:@"select *from videoPlayer where name = 'rank'"];
            id data = nil;
            while ([resultSet next]) {
                data = [resultSet dataForColumn:@"data"];
            }
            if (data != nil) {
                NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
                for (NSDictionary *dic in array) {
                    RankModel *rankModel = [[RankModel alloc]init];
                    [rankModel setValuesForKeysWithDictionary:dic];
                    [self.allModelArray addObject:rankModel];
                }
                
                self.block(self.allModelArray);
                [self.rankView.tableView reloadData];
                
                
                [db close];
            }
            
        }
        

    }];
}

- (NSMutableArray *)allModelArray{
    if (_allModelArray == nil) {
        _allModelArray = [NSMutableArray array];
    }
    return _allModelArray;
}

- (void)addSegment{
    
    NSArray *array = @[@"王者",@"大师",@"钻石",@"铂金",@"黄金",@"白银",@"青铜"];
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.rankView.frame.size.width - 130, 30)];
    scrollView.contentSize = CGSizeMake(self.rankView.frame.size.width * 1.5, 30);
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    self.segment = [[UISegmentedControl alloc]initWithItems:array];
    self.segment.frame = CGRectMake(0, 0, self.rankView.frame.size.width * 1.5, 30);
    self.segment.selectedSegmentIndex = 0;
    
    [self.segment addTarget:self action:@selector(navigationSegmentClick:) forControlEvents:(UIControlEventValueChanged)];
    [scrollView addSubview:self.segment];
    self.navigationItem.titleView = scrollView;
    
}

- (void)navigationSegmentClick:(UISegmentedControl *)segment{
    [self.allModelArray removeAllObjects];
    [self handleData];
}

- (void)segmentClick:(UISegmentedControl *)segment{
    [self.allModelArray removeAllObjects];
    [self handleData];
//    [self.rankView.tableView reloadData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.loadingView = [[LoadingView alloc]initWithFrame:CGRectMake(0, 0, self.rankView.frame.size.width, self.rankView.frame.size.height - 64)];
    [self.rankView addSubview:self.loadingView];
    
    [self handleData];
    [self addSegment];
    
    [self.rankView.segment addTarget:self action:@selector(segmentClick:) forControlEvents:(UIControlEventValueChanged)];
    
    self.rankView.tableView.delegate = self;
    self.rankView.tableView.dataSource = self;
    
    self.block = ^(NSMutableArray *array){
        if (self.rankView.segment.selectedSegmentIndex == 0) {
            for (int i = 1; i < array.count; i++) {
                for (int j = 0; j < array.count - i; j++) {
                    if ([array[j] presentRate] < [array[j + 1] presentRate]) {
                        RankModel *rankModel = array[j];
                        array[j] = array[j + 1];
                        array[j + 1] = rankModel;
                    }
                }
            }
        }else if (self.rankView.segment.selectedSegmentIndex == 1){
            for (int i = 1; i < array.count; i++) {
                for (int j = 0; j < array.count - i; j++) {
                    if ([array[j] winRate] < [array[j + 1] winRate]) {
                        RankModel *rankModel = array[j];
                        array[j] = array[j + 1];
                        array[j + 1] = rankModel;
                    }
                }
            }

        }

    };
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RankCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rankCell"];
    if (cell == nil) {
        cell = [[RankCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"rankCell"];
    }
    
    RankModel *rankModel = self.allModelArray[indexPath.row];
    [cell.heroImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:heroPictureUrlString,rankModel.nameUS]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cell.presentLabel.text = [NSString stringWithFormat:@"%.2f",rankModel.presentRate];
    cell.winLabel.text = [NSString stringWithFormat:@"%.2f",rankModel.winRate];
    cell.totalLabel.text = [NSString stringWithFormat:@"%ld",(long)rankModel.totalPresent];
    
    [self.loadingView setHidden:YES];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 53;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.allModelArray.count;
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
