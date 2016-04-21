//
//  AllHeroViewController.m
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/7.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "AllHeroViewController.h"
#import "EquipCategoryView.h"
#import "SelectionCollectionViewCell.h"
#import "FreeHeroModel.h"
#import "HeroDetailViewController.h"

@interface AllHeroViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)EquipCategoryView *allHeroView;
@property (nonatomic,strong)NSMutableArray *allModelArray;
@property (nonatomic,strong)LoadingView *loadingView;

@end

@implementation AllHeroViewController

-(void)loadView{
    self.allHeroView = [[EquipCategoryView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.allHeroView;
}

- (void)handleData{
    [[CDHttpHelper defaultCDHttpHelper] get:allHeroUrlString params:nil success:^(id responseObj) {
        
        [FMDBSaveDataHelper FMDBSaveDataHelperWithData:responseObj andName:@"all"];
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObj options:(NSJSONReadingAllowFragments) error:nil];
        for (NSDictionary *dict in dic[@"all"]) {
            FreeHeroModel *model = [[FreeHeroModel alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            [self.allModelArray addObject:model];
        }
        [self.allHeroView.collectionView reloadData];
    } failure:^(NSError *error) {
        FMDatabase *db = [FMDatabase databaseWithPath:[[GetDocumentsPathHelper shareGetDocumentsPathHelper] getDocumentsPath]];
        if ([db open]) {
            [db executeUpdate:@"create table if not exists videoPlayer (id integer primary key autoincrement NOT NULL,data blob NOT NULL,name text NOT NULL)"];
            FMResultSet *resultSet = [db executeQuery:@"select *from videoPlayer where name = 'all'"];
            id data = nil;
            while ([resultSet next]) {
                data = [resultSet dataForColumn:@"data"];
            }
            if (data != nil) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
                for (NSDictionary *dict in dic[@"all"]) {
                    FreeHeroModel *model = [[FreeHeroModel alloc]init];
                    [model setValuesForKeysWithDictionary:dict];
                    [self.allModelArray addObject:model];
                }
                [self.allHeroView.collectionView reloadData];
                
                
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
    label.text = @"全部英雄";
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
    self.loadingView = [[LoadingView alloc]initWithFrame:CGRectMake(0, 0, self.allHeroView.frame.size.width, self.allHeroView.frame.size.height - 64)];
    [self.allHeroView addSubview:self.loadingView];
    
    [self setNavigationBar];
    [self handleData];
    self.allHeroView.collectionView.frame = CGRectMake(0, 0, self.allHeroView.frame.size.width, self.allHeroView.frame.size.height - 64);
    [self.allHeroView.collectionView registerClass:[SelectionCollectionViewCell class] forCellWithReuseIdentifier:@"collectionViewCell"];
    
    self.allHeroView.collectionView.delegate = self;
    self.allHeroView.collectionView.dataSource = self;
}

#pragma mark - 设置集合视图的每个Item的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SelectionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCell" forIndexPath:indexPath];
    
    FreeHeroModel *model = self.allModelArray[indexPath.item];
    [cell.picImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:heroPictureUrlString,model.enName]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cell.nameLabel.text = model.title;
    [self.loadingView setHidden:YES];
    return cell;
}
#pragma mark - 选择某一个item执行的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FreeHeroModel *model = self.allModelArray[indexPath.item];
    HeroDetailViewController *heroDetailVC = [[HeroDetailViewController alloc]init];
    heroDetailVC.enName = model.enName;
    [self showViewController:heroDetailVC sender:nil];
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
    return CGSizeMake(self.allHeroView.frame.size.width / 5, self.allHeroView.frame.size.height / 6);
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
