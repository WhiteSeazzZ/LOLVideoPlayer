//
//  CommentaryViewController.m
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/1.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "CommentaryVideoViewController.h"
#import "CommentaryVideoView.h"
#import "SelectionCollectionViewCell.h"
#import "MyReusableView.h"
#import "ClassifyNavigationModel.h"
#import "VideoDetailViewController.h"
#import "RanklistViewController.h"
#import "NewVideoViewController.h"
#import "RequestUrlPlayVideoHelper.h"
#import "ClassifyNavigationDetailModel.h"
#import "DownLoadHelper.h"
#import "DownLoadViewController.h"

@interface CommentaryVideoViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)CommentaryVideoView *commentaryVideoView;
//存放所有标题的数组
@property (nonatomic,strong)NSMutableArray *allTitleArray;
//存放所有模型数据
@property (nonatomic,strong)NSMutableArray *allModelArray;

@property (nonatomic,strong)RanklistViewController *ranklistVC;
@property (nonatomic,strong)NewVideoViewController *newsVideoVC;
@property (nonatomic,strong)LoadingView *loadingView;

@end

@implementation CommentaryVideoViewController

#pragma mark - 设置导航栏
- (void)setNavigationBar{
    //设置导航栏颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.281 green:0.281 blue:0.281 alpha:1]];
    //设置导航栏为不透明
    self.navigationController.navigationBar.translucent = NO;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    label.text = @"解说视频";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    //设置titleView
    self.navigationItem.titleView = label;
    //设置返回按钮
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:(UIBarButtonItemStyleDone) target:nil action:nil];
    
}
#pragma mark - 设置集合视图
- (void)setCollectionView{
    //注册cell
    [self.commentaryVideoView.collectionView registerClass:[SelectionCollectionViewCell class] forCellWithReuseIdentifier:@"collectionViewCell"];
    //注册头标题
    [self.commentaryVideoView.collectionView registerClass:[MyReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    self.commentaryVideoView.collectionView.delegate = self;
    self.commentaryVideoView.collectionView.dataSource  = self;
}

#pragma mark - 处理数据
- (void)handleData{
    [[CDHttpHelper defaultCDHttpHelper] get:classifyNavigationUrlString params:nil success:^(id responseObj) {
        
        [FMDBSaveDataHelper FMDBSaveDataHelperWithData:responseObj andName:@"commentary"];
        
        NSArray *array = [NSJSONSerialization JSONObjectWithData:responseObj options:(NSJSONReadingAllowFragments) error:nil];
        for (NSDictionary *dic in array) {
            //临时数组
            NSMutableArray *tempArray = [NSMutableArray array];
            [self.allTitleArray addObject:dic[@"name"]];
            for (NSDictionary *dict in dic[@"subCategory"]) {
                ClassifyNavigationModel *classifyNavigationModel = [[ClassifyNavigationModel alloc]init];
                [classifyNavigationModel setValuesForKeysWithDictionary:dict];
                [tempArray addObject:classifyNavigationModel];
            }
            [self.allModelArray addObject:tempArray];
        }
        [self.commentaryVideoView.collectionView reloadData];
    } failure:^(NSError *error) {
        FMDatabase *db = [FMDatabase databaseWithPath:[[GetDocumentsPathHelper shareGetDocumentsPathHelper] getDocumentsPath]];
        if ([db open]) {
            [db executeUpdate:@"create table if not exists videoPlayer (id integer primary key autoincrement NOT NULL,data blob NOT NULL,name text NOT NULL)"];
            FMResultSet *resultSet = [db executeQuery:@"select *from videoPlayer where name = 'commentary'"];
            id data = nil;
            while ([resultSet next]) {
                data = [resultSet dataForColumn:@"data"];
            }
            if (data != nil) {
                
                NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
                for (NSDictionary *dic in array) {
                    //临时数组
                    NSMutableArray *tempArray = [NSMutableArray array];
                    [self.allTitleArray addObject:dic[@"name"]];
                    for (NSDictionary *dict in dic[@"subCategory"]) {
                        ClassifyNavigationModel *classifyNavigationModel = [[ClassifyNavigationModel alloc]init];
                        [classifyNavigationModel setValuesForKeysWithDictionary:dict];
                        [tempArray addObject:classifyNavigationModel];
                    }
                    [self.allModelArray addObject:tempArray];
                }
                [self.commentaryVideoView.collectionView reloadData];
                
                [db close];
            }
            
        }
    }];
}

#pragma mark - 懒加载
- (NSMutableArray *)allTitleArray{
    if (_allTitleArray == nil) {
        _allTitleArray = [NSMutableArray array];
    }
    return _allTitleArray;
}
- (NSMutableArray *)allModelArray{
    if (_allModelArray == nil) {
        _allModelArray = [NSMutableArray array];
    }
    return _allModelArray;
}
- (RanklistViewController *)ranklistVC{
    if (_ranklistVC == nil) {
        _ranklistVC = [[RanklistViewController alloc]init];
    }
    return _ranklistVC;
}
- (NewVideoViewController *)newsVideoVC{
    if (_newsVideoVC == nil) {
        _newsVideoVC = [[NewVideoViewController alloc]init];
    }
    return _newsVideoVC;
}

#pragma mark - 系统方法
- (void)loadView{
    self.commentaryVideoView = [[CommentaryVideoView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.commentaryVideoView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loadingView = [[LoadingView alloc]initWithFrame:CGRectMake(0, 0, self.commentaryVideoView.frame.size.width, self.commentaryVideoView.frame.size.height - 64)];
    [self.commentaryVideoView addSubview:self.loadingView];
    
    //设置导航栏
    [self setNavigationBar];
    //设置集合视图
    [self setCollectionView];
    //处理数据
    [self handleData];
    
    //给segmentControll添加事件
    [self.commentaryVideoView.segmentControl addTarget:self action:@selector(segmentControlClick:) forControlEvents:(UIControlEventValueChanged)];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushVC:) name:@"push" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downLoadVC:) name:@"downLoad" object:nil];
}
- (void)pushVC:(NSNotification *)sender
{
    [[RequestUrlPlayVideoHelper shareRequestUrlPlayVideoHelper] requestUrlPlayVideoWithVid:sender.object andController:self];
}

- (void)downLoadVC:(NSNotification *)sender{
    ClassifyNavigationDetailModel *model = sender.object;
    DownLoadViewController *downLoadVC = [[DownLoadViewController alloc]init];
    downLoadVC.vid = model.vid;
    downLoadVC.aTitle = model.title;
    if ([DownLoadHelper shareDownLoadHelper].allDownLoadingArray.count == 0) {
        
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"请选择一种画质:" message:@"" preferredStyle:(UIAlertControllerStyleActionSheet)];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"流畅" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            downLoadVC.distinct = @"350";
            
            [self showViewController:downLoadVC sender:nil];
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"高清" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            downLoadVC.distinct = @"1000";
            
            [self showViewController:downLoadVC sender:nil];
        }];
        UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"超清" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            downLoadVC.distinct = @"1300";
            [self showViewController:downLoadVC sender:nil];
        }];
        UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"不想下载了" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertC addAction:action];
        [alertC addAction:action2];
        [alertC addAction:action3];
        [alertC addAction:action4];
        
        [self presentViewController:alertC animated:YES completion:^{
            
        }];
    }else{
        [self showViewController:downLoadVC sender:nil];
    }

}

#pragma mark - 分段控件事件
- (void)segmentControlClick:(UISegmentedControl *)segment{
    if (segment.selectedSegmentIndex == 0) {
        [self.ranklistVC.view removeFromSuperview];
        [self.newsVideoVC.view removeFromSuperview];
    }else if (segment.selectedSegmentIndex == 1) {
        [self.commentaryVideoView addSubview:self.ranklistVC.view];
    }else if (segment.selectedSegmentIndex == 2){
        [self.commentaryVideoView addSubview:self.newsVideoVC.view];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 设置集合视图的每个Item的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SelectionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCell" forIndexPath:indexPath];
    
    ClassifyNavigationModel *classifyNavigationModel = self.allModelArray[indexPath.section][indexPath.row];
    [cell.picImageView sd_setImageWithURL:[NSURL URLWithString:classifyNavigationModel.icon] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cell.nameLabel.text = classifyNavigationModel.name;
    
    [self.loadingView setHidden:YES];
    
    return cell;
}
#pragma mark - 选择某一个item执行的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    VideoDetailViewController *videoDetailVC = [[VideoDetailViewController alloc]init];
    ClassifyNavigationModel *classifyNavigationModel = self.allModelArray[indexPath.section][indexPath.row];
    videoDetailVC.tag = classifyNavigationModel.tag;
    [self showViewController:videoDetailVC sender:nil];
}
#pragma mark - 返回区的数量
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.allTitleArray.count;
}
#pragma mark - 每个区的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.allModelArray[section] count];
}
#pragma mark - 每个item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.commentaryVideoView.frame.size.width / 5, self.commentaryVideoView.frame.size.height / 6);
}
#pragma mark 每个区头的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(self.commentaryVideoView.frame.size.width, 25);
}
#pragma mark - 每个区的头标题
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    MyReusableView *myReusableView;
    if ([kind isEqual:UICollectionElementKindSectionHeader]) {
        myReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        [myReusableView setLabelText:[NSString stringWithFormat:@"%@",self.allTitleArray[indexPath.section]]];
    }
    return myReusableView;
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
