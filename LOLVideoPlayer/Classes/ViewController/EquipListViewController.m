//
//  EquipListViewController.m
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/4.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "EquipListViewController.h"
#import "VideoAndEventView.h"
#import "EquipListModel.h"
#import "EquipCategoryViewController.h"

@interface EquipListViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)VideoAndEventView *videoAndEventView;
@property (nonatomic,strong)NSMutableArray *allModelArray;
@property (nonatomic,strong)LoadingView *loadingView;

@end

@implementation EquipListViewController
#pragma mark - 设置导航栏
- (void)setNavigationBar{
    //设置导航栏颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.281 green:0.281 blue:0.281 alpha:1]];
    //设置导航栏为不透明
    self.navigationController.navigationBar.translucent = NO;
    //自定义导航栏
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    label.text = @"物品分类";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    //设置title
    self.navigationItem.titleView = label;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    //设置返回按钮
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:(UIBarButtonItemStyleDone) target:nil action:nil];
    
}
#pragma mark - 处理数据
- (void)handleData{
    [[CDHttpHelper defaultCDHttpHelper] get:equipListUrlString params:nil success:^(id responseObj) {
        
        [FMDBSaveDataHelper FMDBSaveDataHelperWithData:responseObj andName:@"equipList"];
        
        NSArray *array = [NSJSONSerialization JSONObjectWithData:responseObj options:(NSJSONReadingAllowFragments) error:nil];
        for (NSDictionary *dic in array) {
            EquipListModel *equipListModel = [[EquipListModel alloc]init];
            [equipListModel setValuesForKeysWithDictionary:dic];
            [self.allModelArray addObject:equipListModel];
        }
        [self.videoAndEventView.tableView reloadData];
    } failure:^(NSError *error) {
        FMDatabase *db = [FMDatabase databaseWithPath:[[GetDocumentsPathHelper shareGetDocumentsPathHelper] getDocumentsPath]];
        if ([db open]) {
            [db executeUpdate:@"create table if not exists videoPlayer (id integer primary key autoincrement NOT NULL,data blob NOT NULL,name text NOT NULL)"];
            FMResultSet *resultSet = [db executeQuery:@"select *from videoPlayer where name = 'equipList'"];
            id data = nil;
            while ([resultSet next]) {
                data = [resultSet dataForColumn:@"data"];
            }
            if (data != nil) {
                NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
                for (NSDictionary *dic in array) {
                    EquipListModel *equipListModel = [[EquipListModel alloc]init];
                    [equipListModel setValuesForKeysWithDictionary:dic];
                    [self.allModelArray addObject:equipListModel];
                }
                [self.videoAndEventView.tableView reloadData];
                
                
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

- (void)loadView{
    self.videoAndEventView = [[VideoAndEventView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.videoAndEventView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.loadingView = [[LoadingView alloc]initWithFrame:CGRectMake(0, 0, self.videoAndEventView.frame.size.width, self.videoAndEventView.frame.size.height - 64)];
    [self.videoAndEventView addSubview:self.loadingView];
    
    [self setNavigationBar];
    [self handleData];
    self.videoAndEventView.tableView.delegate = self;
    self.videoAndEventView.tableView.dataSource = self;
    self.videoAndEventView.tableView.frame = CGRectMake(0, 0, self.videoAndEventView.frame.size.width, self.videoAndEventView.frame.size.height - 64);
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

#pragma mark - tableView的代理和数据源方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eqcell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"eqcell"];
    }
    EquipListModel *equipListModel = self.allModelArray[indexPath.row];
    cell.textLabel.text = equipListModel.text;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    [self.loadingView setHidden:YES];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    EquipListModel *equipListModel = self.allModelArray[indexPath.row];
    EquipCategoryViewController *equipCategoryVC = [[EquipCategoryViewController alloc]init];
    equipCategoryVC.tag = equipListModel.tag;
    equipCategoryVC.text = equipListModel.text;
    [self showViewController:equipCategoryVC sender:nil];
    
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
