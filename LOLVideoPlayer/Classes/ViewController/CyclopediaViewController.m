//
//  CyclopediaViewController.m
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/1.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "CyclopediaViewController.h"
#import "CyclopediaModel.h"
#import "CyclopediaCell.h"
#import "CyclopediaDetailViewController.h"
#import "EquipListViewController.h"
#import "RunesViewController.h"
#import "BestGroupViewController.h"
#import "RankViewController.h"
#import "FreeHeroViewController.h"
#import "AllHeroViewController.h"

@interface CyclopediaViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)NSMutableArray *allModelArray;
@property (nonatomic,strong)LoadingView *loadingView;

@end

@implementation CyclopediaViewController

#pragma mark - 设置导航栏
- (void)setNavigationBar{
    //设置导航栏颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.281 green:0.281 blue:0.281 alpha:1]];
    //设置导航栏为不透明
    self.navigationController.navigationBar.translucent = NO;
    //自定义导航栏
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    label.text = @"联盟百科";
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
    [[CDHttpHelper defaultCDHttpHelper] get:cyclopediaUrlString params:nil success:^(id responseObj) {
        
        [FMDBSaveDataHelper FMDBSaveDataHelperWithData:responseObj andName:@"cyclopedia"];
        
        
        NSArray *array = [NSJSONSerialization JSONObjectWithData:responseObj options:(NSJSONReadingAllowFragments) error:nil];
        for (NSDictionary *dic in array) {
            CyclopediaModel *cyclopediaModel = [[CyclopediaModel alloc]init];
            [cyclopediaModel setValuesForKeysWithDictionary:dic];
            if (([cyclopediaModel.name isEqualToString:@"S6天赋模拟器网页版"] || [cyclopediaModel.name isEqualToString:@"LOL关键词"] || [cyclopediaModel.name isEqualToString:@"多玩论坛"] || [cyclopediaModel.name isEqualToString:@"魅力排行榜"] || [cyclopediaModel.name isEqualToString:@"玩游戏得Q币点卡"] || [cyclopediaModel.name isEqualToString:@"战斗力排行榜"] || [cyclopediaModel.name isEqualToString:@"天赋"] || [cyclopediaModel.name isEqualToString:@"召唤师技能"]) == 0) {
                [self.allModelArray addObject:cyclopediaModel];
            }
        }
        CyclopediaModel *addModel = [[CyclopediaModel alloc]init];
        addModel.tag = @"free";
        addModel.name = @"周免英雄";
        addModel.icon = @"http://img.douxie.com/upload/upload/2016/02/03/tb_56b1cc8f8d5a7.png";
        CyclopediaModel *addModel2 = [[CyclopediaModel alloc]init];
        addModel2.tag = @"all";
        addModel2.name = @"全部英雄";
        addModel2.icon = @"http://img.douxie.com/upload/upload/2016/02/03/tb_56b1cc91c440a.png";
        [self.allModelArray addObject:addModel];
        [self.allModelArray addObject:addModel2];
        [self.cyclopediaView.tableView reloadData];
    } failure:^(NSError *error) {
        FMDatabase *db = [FMDatabase databaseWithPath:[[GetDocumentsPathHelper shareGetDocumentsPathHelper] getDocumentsPath]];
        if ([db open]) {
            [db executeUpdate:@"create table if not exists videoPlayer (id integer primary key autoincrement NOT NULL,data blob NOT NULL,name text NOT NULL)"];
            FMResultSet *resultSet = [db executeQuery:@"select *from videoPlayer where name = 'cyclopedia'"];
            id data = nil;
            while ([resultSet next]) {
                data = [resultSet dataForColumn:@"data"];
            }
            if (data != nil) {
                
                NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
                for (NSDictionary *dic in array) {
                    CyclopediaModel *cyclopediaModel = [[CyclopediaModel alloc]init];
                    [cyclopediaModel setValuesForKeysWithDictionary:dic];
                    if (([cyclopediaModel.name isEqualToString:@"S6天赋模拟器网页版"] || [cyclopediaModel.name isEqualToString:@"LOL关键词"] || [cyclopediaModel.name isEqualToString:@"多玩论坛"] || [cyclopediaModel.name isEqualToString:@"魅力排行榜"] || [cyclopediaModel.name isEqualToString:@"玩游戏得Q币点卡"] || [cyclopediaModel.name isEqualToString:@"战斗力排行榜"] || [cyclopediaModel.name isEqualToString:@"天赋"] || [cyclopediaModel.name isEqualToString:@"召唤师技能"]) == 0) {
                        [self.allModelArray addObject:cyclopediaModel];
                    }
                }
                CyclopediaModel *addModel = [[CyclopediaModel alloc]init];
                addModel.tag = @"free";
                addModel.name = @"周免英雄";
                addModel.icon = @"http://img.douxie.com/upload/upload/2016/02/03/tb_56b1cc8f8d5a7.png";
                CyclopediaModel *addModel2 = [[CyclopediaModel alloc]init];
                addModel2.tag = @"all";
                addModel2.name = @"全部英雄";
                addModel2.icon = @"http://img.douxie.com/upload/upload/2016/02/03/tb_56b1cc91c440a.png";
                [self.allModelArray addObject:addModel];
                [self.allModelArray addObject:addModel2];
                [self.cyclopediaView.tableView reloadData];

                
                [db close];
            }
            
        }
        

    }];
}

#pragma mark - 懒加载
- (NSMutableArray *)allModelArray{
    if (_allModelArray == nil) {
        _allModelArray = [[NSMutableArray alloc]init];
    }
    return _allModelArray;
}

- (void)loadView{
    self.cyclopediaView = [[CyclopediaView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.cyclopediaView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.loadingView = [[LoadingView alloc]initWithFrame:CGRectMake(0, 0, self.cyclopediaView.frame.size.width, self.cyclopediaView.frame.size.height - 64)];
    [self.cyclopediaView addSubview:self.loadingView];
    
    //设置导航栏
    [self setNavigationBar];
    //处理数据
    [self handleData];
    
    self.cyclopediaView.tableView.delegate = self;
    self.cyclopediaView.tableView.dataSource = self;

    

}

#pragma mark - 视图将要出现时取消选中的行
- (void)viewWillAppear:(BOOL)animated{
    if ([self.cyclopediaView.tableView indexPathForSelectedRow] != nil) {
        [self.cyclopediaView.tableView deselectRowAtIndexPath:[self.cyclopediaView.tableView indexPathForSelectedRow] animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 设置tableView的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CyclopediaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cycCell"];
    if (cell == nil) {
        cell = [[CyclopediaCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cycCell"];
    }
    //定义模型对象来接受数组中的模型数据
    CyclopediaModel *cyclopediaModel = self.allModelArray[indexPath.row];
    [cell.picImageView sd_setImageWithURL:[NSURL URLWithString:cyclopediaModel.icon] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cell.nameLabel.text = cyclopediaModel.name;
    
    [self.loadingView setHidden:YES];
    return cell;
}
#pragma mark - 设置tableView行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.allModelArray.count;
}
#pragma mark - 设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 54;
}
#pragma mark - 选择某行执行的操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CyclopediaModel *cyclopediaModel = self.allModelArray[indexPath.row];
    
    
    if ([cyclopediaModel.tag isEqualToString:@"lol_story"]) {
        CyclopediaDetailViewController *cyclopediaDetailVC = [[CyclopediaDetailViewController alloc]init];
        cyclopediaDetailVC.url = cyclopediaModel.url;
        cyclopediaDetailVC.name = cyclopediaModel.name;
        [self showViewController:cyclopediaDetailVC sender:nil];
    }else if ([cyclopediaModel.tag isEqualToString:@"item"]){
        //装备列表
        EquipListViewController *equipListVC = [[EquipListViewController alloc]init];
        [self showViewController:equipListVC sender:nil];
    }else if ([cyclopediaModel.tag isEqualToString:@"runnes"]){
        RunesViewController *runesVC = [[RunesViewController alloc]init];
        [self showViewController:runesVC sender:nil];
    }else if ([cyclopediaModel.tag isEqualToString:@"best_group"]){
        BestGroupViewController *bestGroupVC = [[BestGroupViewController alloc] init];
        [self showViewController:bestGroupVC sender:nil];
    }else if ([cyclopediaModel.tag isEqualToString:@"hero_odds_week"]){
        RankViewController *rankVC = [[RankViewController alloc]init];
        [self showViewController:rankVC sender:nil];
    }else if ([cyclopediaModel.tag isEqualToString:@"free"]){
        FreeHeroViewController *freeHeroVC = [[FreeHeroViewController alloc]init];
        [self showViewController:freeHeroVC sender:nil];
    }else if ([cyclopediaModel.tag isEqualToString:@"all"]){
        AllHeroViewController *heroVC = [[AllHeroViewController alloc]init];
        [self showViewController:heroVC sender:nil];
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
