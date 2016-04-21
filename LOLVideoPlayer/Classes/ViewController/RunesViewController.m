//
//  RunesViewController.m
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/5.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "RunesViewController.h"
#import "RunesView.h"
#import "RunesCell.h"
#import "RunesCategoryModel.h"

@interface RunesViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)RunesView *runsView;
@property (nonatomic,strong)NSMutableArray *allBlueArray;
@property (nonatomic,strong)NSMutableArray *allPurpleArray;
@property (nonatomic,strong)NSMutableArray *allRedArray;
@property (nonatomic,strong)NSMutableArray *allYellowArray;
@property (nonatomic,strong)NSMutableArray *allRetureArray;
@property (nonatomic,strong)LoadingView *loadingView;





@end

@implementation RunesViewController

- (void)loadView{
    self.runsView = [[RunesView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.runsView;
}

#pragma mark - 设置导航栏
- (void)setNavigationBar{
    //设置导航栏颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.281 green:0.281 blue:0.281 alpha:1]];
    //设置导航栏为不透明
    self.navigationController.navigationBar.translucent = NO;
    //自定义导航栏
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    label.text = @"符文(旧)";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    //设置title
    self.navigationItem.titleView = label;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];

    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.loadingView = [[LoadingView alloc]initWithFrame:CGRectMake(0, 0, self.runsView.frame.size.width, self.runsView.frame.size.height - 64)];
    [self.runsView addSubview:self.loadingView];
    
    [self handleData];
    [self setNavigationBar];
    
    self.runsView.tableView.delegate = self;
    self.runsView.tableView.dataSource = self;
    
    [self.runsView.gradeSegmentControl addTarget:self action:@selector(segmentClick:) forControlEvents:(UIControlEventValueChanged)];
    [self.runsView.typeSegmentControl addTarget:self action:@selector(segmentClick:) forControlEvents:(UIControlEventValueChanged)];
}
- (void)segmentClick:(UISegmentedControl *)segment{
    
    //if (segment.selectedSegmentIndex == 0) {
        [self.allRetureArray removeAllObjects];
        [self.runsView.tableView reloadData];
    //}
    
}
#pragma mark - 处理数据
- (void)handleData{
    [[CDHttpHelper defaultCDHttpHelper] get:runesUrlString params:nil success:^(id responseObj) {
        
        [FMDBSaveDataHelper FMDBSaveDataHelperWithData:responseObj andName:@"runes"];
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObj options:(NSJSONReadingAllowFragments) error:nil];
        
        
        for (NSDictionary *dict in dic[@"Blue"]) {
            RunesCategoryModel *runesCategoryModel = [[RunesCategoryModel alloc]init];
            [runesCategoryModel setValuesForKeysWithDictionary:dict];
            [self.allBlueArray addObject:runesCategoryModel];
            
        }
        for (NSDictionary *dict in dic[@"Purple"]) {
            RunesCategoryModel *runesCategoryModel = [[RunesCategoryModel alloc]init];
            [runesCategoryModel setValuesForKeysWithDictionary:dict];
            [self.allPurpleArray addObject:runesCategoryModel];
        }
        for (NSDictionary *dict in dic[@"Red"]) {
            RunesCategoryModel *runesCategoryModel = [[RunesCategoryModel alloc]init];
            [runesCategoryModel setValuesForKeysWithDictionary:dict];
            [self.allRedArray addObject:runesCategoryModel];
        }
        for (NSDictionary *dict in dic[@"Yellow"]) {
            RunesCategoryModel *runesCategoryModel = [[RunesCategoryModel alloc]init];
            [runesCategoryModel setValuesForKeysWithDictionary:dict];
            [self.allYellowArray addObject:runesCategoryModel];
        }
        
        [self.runsView.tableView reloadData];
        
    } failure:^(NSError *error) {
        FMDatabase *db = [FMDatabase databaseWithPath:[[GetDocumentsPathHelper shareGetDocumentsPathHelper] getDocumentsPath]];
        if ([db open]) {
            [db executeUpdate:@"create table if not exists videoPlayer (id integer primary key autoincrement NOT NULL,data blob NOT NULL,name text NOT NULL)"];
            FMResultSet *resultSet = [db executeQuery:@"select *from videoPlayer where name = 'runes'"];
            id data = nil;
            while ([resultSet next]) {
                data = [resultSet dataForColumn:@"data"];
            }
            if (data != nil) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
                
                
                for (NSDictionary *dict in dic[@"Blue"]) {
                    RunesCategoryModel *runesCategoryModel = [[RunesCategoryModel alloc]init];
                    [runesCategoryModel setValuesForKeysWithDictionary:dict];
                    [self.allBlueArray addObject:runesCategoryModel];
                    
                }
                for (NSDictionary *dict in dic[@"Purple"]) {
                    RunesCategoryModel *runesCategoryModel = [[RunesCategoryModel alloc]init];
                    [runesCategoryModel setValuesForKeysWithDictionary:dict];
                    [self.allPurpleArray addObject:runesCategoryModel];
                }
                for (NSDictionary *dict in dic[@"Red"]) {
                    RunesCategoryModel *runesCategoryModel = [[RunesCategoryModel alloc]init];
                    [runesCategoryModel setValuesForKeysWithDictionary:dict];
                    [self.allRedArray addObject:runesCategoryModel];
                }
                for (NSDictionary *dict in dic[@"Yellow"]) {
                    RunesCategoryModel *runesCategoryModel = [[RunesCategoryModel alloc]init];
                    [runesCategoryModel setValuesForKeysWithDictionary:dict];
                    [self.allYellowArray addObject:runesCategoryModel];
                }
                
                [self.runsView.tableView reloadData];

                
                
                [db close];
            }
            
        }
        

    }];
}

- (NSMutableArray *)allBlueArray{
    if (_allBlueArray == nil) {
        _allBlueArray = [NSMutableArray array];
    }
    return _allBlueArray;
}
- (NSMutableArray *)allPurpleArray{
    if (_allPurpleArray == nil) {
        _allPurpleArray = [NSMutableArray array];
    }
    return _allPurpleArray;
}
- (NSMutableArray *)allRedArray{
    if (_allRedArray == nil) {
        _allRedArray = [NSMutableArray array];
    }
    return _allRedArray;
}
- (NSMutableArray *)allRetureArray{
    if (_allRetureArray == nil) {
        _allRetureArray = [NSMutableArray array];
    }
    return _allRetureArray;
}
- (NSMutableArray *)allYellowArray{
    if (_allYellowArray == nil) {
        _allYellowArray = [NSMutableArray array];
    }
    return _allYellowArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RunesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"runesCell"];
    if (cell == nil) {
        cell = [[RunesCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"runesCell"];
    }
    
    RunesCategoryModel *runesCategoryModel = [self returnArray:@[self.allBlueArray,self.allPurpleArray,self.allRedArray,self.allYellowArray]][indexPath.row];
    [cell.picImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:runesPictureUrlString,runesCategoryModel.Img,runesCategoryModel.Type]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cell.nameLabel.text = runesCategoryModel.Name;
    cell.gradeLabel.text = [NSString stringWithFormat:@"%ld级",runesCategoryModel.Type];
    if (self.runsView.gradeSegmentControl.selectedSegmentIndex == 0) {
        cell.propLabel.text = [runesCategoryModel.Prop stringByAppendingString:runesCategoryModel.lev1];
        cell.moneyLabel.text = [NSString stringWithFormat:@"游戏币 %ld",runesCategoryModel.iplev1];
        if (runesCategoryModel.iplev1 == 0) {
            cell.moneyLabel.text = @"(已移除)";
        }
        
    }
    if (self.runsView.gradeSegmentControl.selectedSegmentIndex == 1) {
        cell.propLabel.text = [runesCategoryModel.Prop stringByAppendingString:runesCategoryModel.lev2];
        cell.moneyLabel.text = [NSString stringWithFormat:@"游戏币 %ld",runesCategoryModel.iplev2];
        if (runesCategoryModel.iplev2 == 0) {
            cell.moneyLabel.text = @"(已移除)";
        }
    }
    if (self.runsView.gradeSegmentControl.selectedSegmentIndex == 2) {
        cell.propLabel.text = [runesCategoryModel.Prop stringByAppendingString:runesCategoryModel.lev3];
        cell.moneyLabel.text = [NSString stringWithFormat:@"游戏币 %ld",runesCategoryModel.iplev3];
        if (runesCategoryModel.iplev3 == 0) {
            cell.moneyLabel.text = @"(已移除)";
        }
    }
    
    [self.loadingView setHidden:YES];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self returnArray:@[self.allBlueArray,self.allYellowArray,self.allRedArray,self.allPurpleArray]] count];
}

- (NSMutableArray *)returnArray:(NSArray *)array{
    for (int i = 0; i < 4; i++) {
        if (self.runsView.typeSegmentControl.selectedSegmentIndex == i) {
            for (RunesCategoryModel *runesCategoryModel in array[i]) {
                if (self.runsView.gradeSegmentControl.selectedSegmentIndex + 1 == runesCategoryModel.Type) {
                    [self.allRetureArray addObject:runesCategoryModel];
                        
                }
                
            }
        }
    }
    return self.allRetureArray;
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
