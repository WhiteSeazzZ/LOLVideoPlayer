//
//  BestGroupViewController.m
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/5.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "BestGroupViewController.h"
#import "BestGroupCell.h"
#import "BestGroupView.h"
#import "BestGroupModel.h"
#import "BestGroupDetailViewController.h"

@interface BestGroupViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)BestGroupView *bestGroupView;

@property (nonatomic,strong)NSMutableArray *allModelArray;

@property (nonatomic,strong)LoadingView *loadingView;

@end

@implementation BestGroupViewController

- (void)loadView{
    self.bestGroupView = [[BestGroupView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.bestGroupView;
}

- (void)handleData{
    [[CDHttpHelper defaultCDHttpHelper] get:bestGroupUrlString params:nil success:^(id responseObj) {
        
        [FMDBSaveDataHelper FMDBSaveDataHelperWithData:responseObj andName:@"bestGroup"];
        
        NSArray *array = [NSJSONSerialization JSONObjectWithData:responseObj options:(NSJSONReadingAllowFragments) error:nil];
        for (NSDictionary *dic in array) {
            BestGroupModel *bestGroupModel = [[BestGroupModel alloc]init];
            [bestGroupModel setValuesForKeysWithDictionary:dic];
            [self.allModelArray addObject:bestGroupModel];
            
        }
        [self.bestGroupView.tableView reloadData];
    } failure:^(NSError *error) {
        FMDatabase *db = [FMDatabase databaseWithPath:[[GetDocumentsPathHelper shareGetDocumentsPathHelper] getDocumentsPath]];
        if ([db open]) {
            [db executeUpdate:@"create table if not exists videoPlayer (id integer primary key autoincrement NOT NULL,data blob NOT NULL,name text NOT NULL)"];
            FMResultSet *resultSet = [db executeQuery:@"select *from videoPlayer where name = 'bestGroup'"];
            id data = nil;
            while ([resultSet next]) {
                data = [resultSet dataForColumn:@"data"];
            }
            if (data != nil) {
                NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
                for (NSDictionary *dic in array) {
                    BestGroupModel *bestGroupModel = [[BestGroupModel alloc]init];
                    [bestGroupModel setValuesForKeysWithDictionary:dic];
                    [self.allModelArray addObject:bestGroupModel];
                    
                }
                [self.bestGroupView.tableView reloadData];
                
                
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

#pragma mark - 设置导航栏
- (void)setNavigationBar{
    //设置导航栏颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.281 green:0.281 blue:0.281 alpha:1]];
    //设置导航栏为不透明
    self.navigationController.navigationBar.translucent = NO;
    //自定义导航栏
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    label.text = @"最佳阵容";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    //设置title
    self.navigationItem.titleView = label;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    //设置返回按钮
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:(UIBarButtonItemStyleDone) target:nil action:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.loadingView = [[LoadingView alloc]initWithFrame:CGRectMake(0, 0, self.bestGroupView.frame.size.width, self.bestGroupView.frame.size.height - 64)];
    [self.bestGroupView addSubview:self.loadingView];
    
    [self handleData];
    [self setNavigationBar];
    
    
    self.bestGroupView.tableView.delegate = self;
    self.bestGroupView.tableView.dataSource = self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BestGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bestGroupCell"];
    if (cell == nil) {
        cell = [[BestGroupCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"bestGroupCell"];
    }
    BestGroupModel *bestGroupModel = self.allModelArray[indexPath.row];
    
    cell.titleLabel.text = bestGroupModel.title;
    cell.desLabel.text = bestGroupModel.des;
    
    [cell.aImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:heroPictureUrlString,bestGroupModel.hero1]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    [cell.bImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:heroPictureUrlString,bestGroupModel.hero2]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    [cell.cImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:heroPictureUrlString,bestGroupModel.hero3]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    [cell.dImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:heroPictureUrlString,bestGroupModel.hero4]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    [cell.eImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:heroPictureUrlString,bestGroupModel.hero5]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    [self.loadingView setHidden:YES];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BestGroupDetailViewController *bestGroupDetailVC = [[BestGroupDetailViewController alloc]init];
    BestGroupModel *bestGroupModel = self.allModelArray[indexPath.row];
    bestGroupDetailVC.des = bestGroupModel.des;
    bestGroupDetailVC.des1 = bestGroupModel.des1;
    bestGroupDetailVC.des2 = bestGroupModel.des2;
    bestGroupDetailVC.des3 = bestGroupModel.des3;
    bestGroupDetailVC.des4 = bestGroupModel.des4;
    bestGroupDetailVC.des5 = bestGroupModel.des5;
    bestGroupDetailVC.hero1 = bestGroupModel.hero1;
    bestGroupDetailVC.hero2 = bestGroupModel.hero2;
    bestGroupDetailVC.hero3 = bestGroupModel.hero3;
    bestGroupDetailVC.hero4 = bestGroupModel.hero4;
    bestGroupDetailVC.hero5 = bestGroupModel.hero5;
    bestGroupDetailVC.aTitle = bestGroupModel.title;
    
    [self showViewController:bestGroupDetailVC sender:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.allModelArray.count;
}

#pragma mark - 视图将要出现时取消选中的行
- (void)viewWillAppear:(BOOL)animated{
    if ([self.bestGroupView.tableView indexPathForSelectedRow] != nil) {
        [self.bestGroupView.tableView deselectRowAtIndexPath:[self.bestGroupView.tableView indexPathForSelectedRow] animated:YES];
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
