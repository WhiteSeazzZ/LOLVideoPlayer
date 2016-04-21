//
//  EquipCategoryViewController.m
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/4.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "EquipCategoryViewController.h"
#import "EquipCategoryView.h"
#import "SelectionCollectionViewCell.h"
#import "EquipCategoryModel.h"
#import "EquipDetailViewController.h"

@interface EquipCategoryViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)EquipCategoryView *equipCategoryView;
@property (nonatomic,strong)NSMutableArray *allModelArray;

@property (nonatomic,strong)LoadingView *loadingView;

@end

@implementation EquipCategoryViewController

- (void)loadView{
    self.equipCategoryView = [[EquipCategoryView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.equipCategoryView;
}

- (void)handleData{
    [[CDHttpHelper defaultCDHttpHelper] get:[equipCategoryUrlString stringByAppendingString:self.tag] params:nil success:^(id responseObj) {
        
        //[FMDBSaveDataHelper FMDBSaveDataHelperWithData:responseObj andName:@"equipCategory"];
        [FMDBSaveDataHelper FMDBSaveDataHelperWithData:responseObj andName:[@"equipCategory" stringByAppendingString:self.tag]];
        
        NSArray *array = [NSJSONSerialization JSONObjectWithData:responseObj options:(NSJSONReadingAllowFragments) error:nil];
        for (NSDictionary *dic in array) {
            EquipCategoryModel *equipCategoryModel = [[EquipCategoryModel alloc]init];
            [equipCategoryModel setValuesForKeysWithDictionary:dic];
            [self.allModelArray addObject:equipCategoryModel];
        }
        [self.equipCategoryView.collectionView reloadData];
    } failure:^(NSError *error) {
        FMDatabase *db = [FMDatabase databaseWithPath:[[GetDocumentsPathHelper shareGetDocumentsPathHelper] getDocumentsPath]];
        if ([db open]) {
            
            [db executeUpdate:@"create table if not exists videoPlayer (id integer primary key autoincrement NOT NULL,data blob NOT NULL,name text NOT NULL)"];
            
            FMResultSet *resultSet = [db executeQuery:@"select *from videoPlayer where name = ?",[@"equipCategory" stringByAppendingString:self.tag]];
            
            
            id data = nil;
            while ([resultSet next]) {
                data = [resultSet dataForColumn:@"data"];
            }
            if (data != nil) {
                NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
                for (NSDictionary *dic in array) {
                    EquipCategoryModel *equipCategoryModel = [[EquipCategoryModel alloc]init];
                    [equipCategoryModel setValuesForKeysWithDictionary:dic];
                    [self.allModelArray addObject:equipCategoryModel];
                }
                [self.equipCategoryView.collectionView reloadData];

                
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
    label.text = self.text;
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
    self.loadingView = [[LoadingView alloc]initWithFrame:CGRectMake(0, 0, self.equipCategoryView.frame.size.width, self.equipCategoryView.frame.size.height - 64)];
    [self.equipCategoryView addSubview:self.loadingView];
    
    [self setNavigationBar];
    [self handleData];
    //注册cell
    [self.equipCategoryView.collectionView registerClass:[SelectionCollectionViewCell class] forCellWithReuseIdentifier:@"collectionViewCell"];

    
    self.equipCategoryView.collectionView.delegate = self;
    self.equipCategoryView.collectionView.dataSource = self;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 设置集合视图的每个Item的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SelectionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCell" forIndexPath:indexPath];
    
    EquipCategoryModel *equipCategoryModel = self.allModelArray[indexPath.row];
    [cell.picImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:equipPictureUrlString,(long)equipCategoryModel.Id]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cell.nameLabel.text = equipCategoryModel.text;
    [self.loadingView setHidden:YES];
    return cell;
}
#pragma mark - 选择某一个item执行的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    EquipCategoryModel *equipCategoryModel = self.allModelArray[indexPath.item];
    EquipDetailViewController *equipDetailVC = [[EquipDetailViewController alloc]init];
    equipDetailVC.Id = equipCategoryModel.Id;
    [self showViewController:equipDetailVC sender:nil];
}
#pragma mark - 返回区的数量
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
#pragma mark - 每个区的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.allModelArray.count;
}
#pragma mark - 每个item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.equipCategoryView.frame.size.width / 5, self.equipCategoryView.frame.size.height / 6);
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
