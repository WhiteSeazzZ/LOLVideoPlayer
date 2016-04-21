//
//  FreeHeroViewController.m
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/6.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "FreeHeroViewController.h"
#import "FreeHeroView.h"
#import "FreeHeroCell.h"
#import "FreeHeroModel.h"
#import "HeroDetailViewController.h"

@interface FreeHeroViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)FreeHeroView *freeHeroView;
@property (nonatomic,strong)NSMutableArray *allModelArray;
@property (nonatomic,strong)LoadingView *loadingView;

@end

@implementation FreeHeroViewController

- (void)loadView{
    self.freeHeroView = [[FreeHeroView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.freeHeroView;
}

- (void)handleData{
    [[CDHttpHelper defaultCDHttpHelper] get:freeHeroUrlString params:nil success:^(id responseObj) {
        
        [FMDBSaveDataHelper FMDBSaveDataHelperWithData:responseObj andName:@"free"];
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObj options:(NSJSONReadingAllowFragments) error:nil];
        
        for (NSDictionary *dict in dic[@"free"]) {
            FreeHeroModel *freeHeroModel = [[FreeHeroModel alloc]init];
            [freeHeroModel setValuesForKeysWithDictionary:dict];
            [self.allModelArray addObject:freeHeroModel];
        }
        [self.freeHeroView.collectionView reloadData];
    } failure:^(NSError *error) {
        FMDatabase *db = [FMDatabase databaseWithPath:[[GetDocumentsPathHelper shareGetDocumentsPathHelper] getDocumentsPath]];
        if ([db open]) {
            [db executeUpdate:@"create table if not exists videoPlayer (id integer primary key autoincrement NOT NULL,data blob NOT NULL,name text NOT NULL)"];
            FMResultSet *resultSet = [db executeQuery:@"select *from videoPlayer where name = 'free'"];
            id data = nil;
            while ([resultSet next]) {
                data = [resultSet dataForColumn:@"data"];
            }
            if (data != nil) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
                
                for (NSDictionary *dict in dic[@"free"]) {
                    FreeHeroModel *freeHeroModel = [[FreeHeroModel alloc]init];
                    [freeHeroModel setValuesForKeysWithDictionary:dict];
                    [self.allModelArray addObject:freeHeroModel];
                }
                [self.freeHeroView.collectionView reloadData];
                
                
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
    label.text = @"周免英雄";
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
    
    self.loadingView = [[LoadingView alloc]initWithFrame:CGRectMake(0, 0, self.freeHeroView.frame.size.width, self.freeHeroView.frame.size.height - 64)];
    [self.freeHeroView addSubview:self.loadingView];
    
    [self setNavigationBar];
    [self handleData];
    
    self.freeHeroView.collectionView.delegate = self;
    self.freeHeroView.collectionView.dataSource = self;
    
    //注册cell
    [self.freeHeroView.collectionView registerClass:[FreeHeroCell class] forCellWithReuseIdentifier:@"freeHeroCell"];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FreeHeroCell *cell  =[collectionView dequeueReusableCellWithReuseIdentifier:@"freeHeroCell" forIndexPath:indexPath];
    
    FreeHeroModel *freeHeroModel = self.allModelArray[indexPath.item];
    
    [cell.heroImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:heroPictureUrlString,freeHeroModel.enName]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cell.nameLabel.text = freeHeroModel.title;
    cell.desLabel.text = freeHeroModel.cnName;
    cell.locationLabel.text = freeHeroModel.location;
    
    [self.loadingView setHidden:YES];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HeroDetailViewController *heroDetailVC = [[HeroDetailViewController alloc]init];
    FreeHeroModel *freeHeroModel = self.allModelArray[indexPath.item];
    heroDetailVC.enName = freeHeroModel.enName;
    [self showViewController:heroDetailVC sender:nil];
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.freeHeroView.frame.size.width / 2.4, 60);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.allModelArray.count;
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
