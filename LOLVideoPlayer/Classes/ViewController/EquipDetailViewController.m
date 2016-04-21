//
//  EquipDetailViewController.m
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/5.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "EquipDetailViewController.h"
#import "EquipDetailView.h"
#import "EquipDetailModel.h"
#import "EquipListViewController.h"


@interface EquipDetailViewController ()

@property (nonatomic,strong)EquipDetailView *equipDetailView;
@property (nonatomic,copy)void (^block)(EquipDetailModel *equipDetailModel);
@property (nonatomic,strong)NSMutableDictionary *dic;
@property (nonatomic,strong)NSMutableArray *allDicArray;
@property (nonatomic,strong)LoadingView *loadingView;


@end

@implementation EquipDetailViewController

- (void)loadView{
    self.equipDetailView = [[EquipDetailView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.equipDetailView;
}
#pragma mark - 设置导航栏
- (void)setNavigationBar{
    //设置导航栏颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.281 green:0.281 blue:0.281 alpha:1]];
    //设置导航栏为不透明
    self.navigationController.navigationBar.translucent = NO;
    //自定义导航栏
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    label.text = @"物品详情";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    //设置title
    self.navigationItem.titleView = label;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    //设置返回按钮
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:(UIBarButtonItemStyleDone) target:nil action:nil];
    
    //设置返回百科的方法
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"百科" style:(UIBarButtonItemStyleDone) target:self action:@selector(listClick)];
    
}
#pragma  mark - 返回列表的方法
- (void)listClick{

    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.loadingView = [[LoadingView alloc]initWithFrame:CGRectMake(0, 0, self.equipDetailView.frame.size.width, self.equipDetailView.frame.size.height - 64)];
    [self.equipDetailView addSubview:self.loadingView];
    
    [self setNavigationBar];
    [self handleData];
    
    //block调用
    __weak typeof (self) Self = self;
    self.block = ^(EquipDetailModel *equipDetailModel){
        [Self setData:equipDetailModel];
    };
}
#pragma mark - 处理数据
- (void)handleData{
    [[CDHttpHelper defaultCDHttpHelper] get:[equipDetailUrlString stringByAppendingFormat:@"%ld",(long)self.Id] params:nil success:^(id responseObj) {
        
        [FMDBSaveDataHelper FMDBSaveDataHelperWithData:responseObj andName:[NSString stringWithFormat:@"equipDetail%ld",(long)self.Id]];
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObj options:(NSJSONReadingAllowFragments) error:nil];
        EquipDetailModel *equipDetailModel = [[EquipDetailModel alloc]init];
        [equipDetailModel setValuesForKeysWithDictionary:dic];
        
        self.block(equipDetailModel);
    } failure:^(NSError *error) {
        FMDatabase *db = [FMDatabase databaseWithPath:[[GetDocumentsPathHelper shareGetDocumentsPathHelper] getDocumentsPath]];
        if ([db open]) {
            
            [db executeUpdate:@"create table if not exists videoPlayer (id integer primary key autoincrement NOT NULL,data blob NOT NULL,name text NOT NULL)"];
            
            FMResultSet *resultSet = [db executeQuery:@"select *from videoPlayer where name = ?",[NSString stringWithFormat:@"equipDetail%ld",(long)self.Id]];
            
            
            id data = nil;
            while ([resultSet next]) {
                data = [resultSet dataForColumn:@"data"];
            }
            if (data != nil) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
                EquipDetailModel *equipDetailModel = [[EquipDetailModel alloc]init];
                [equipDetailModel setValuesForKeysWithDictionary:dic];
                
                self.block(equipDetailModel);
                
                [db close];
                
            }
        }

    }];
}

#pragma mark - 给布局设置数据
- (void)setData:(EquipDetailModel *)equipDetailModel{
    [self.equipDetailView.picImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:equipPictureUrlString,(long)self.Id]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.equipDetailView.nameLabel.text = equipDetailModel.name;
    self.equipDetailView.priceLabel.text = [NSString stringWithFormat:@"价格:%ld",(long)equipDetailModel.price];
    self.equipDetailView.allPriceLabel.text = [NSString stringWithFormat:@"总价:%ld",(long)equipDetailModel.allPrice];
    self.equipDetailView.sellPriceLabel.text = [NSString stringWithFormat:@"售价:%ld",(long)equipDetailModel.sellPrice];
    self.equipDetailView.valueLabel.text = equipDetailModel.descriptions;
    //valueLabel自适应高度
    CGFloat valueLabelHeight = [self returnValueLabelHeight:equipDetailModel.descriptions];
    self.equipDetailView.valueLabel.frame = CGRectMake(15, CGRectGetMaxY(self.equipDetailView.picImageView.frame) + 45, self.equipDetailView.frame.size.width - 30, valueLabelHeight);
    //重新设置valueLabel下面控件的位置
    self.equipDetailView.needTitleLabel.frame = CGRectMake(15, CGRectGetMaxY(self.equipDetailView.valueLabel.frame) + 15, 100, 25);
    //根据需求设置view的高度
    CGFloat needViewHeight = 20;
    if (![equipDetailModel.need isEqualToString:@""]) {
        needViewHeight = 60;
        NSArray *array = [equipDetailModel.need componentsSeparatedByString:@","];
        for (int i = 0; i < array.count; i++) {
            UIImageView *equipImageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * 55 + 5, 5, 50, 50)];
            //设置tag值
            equipImageView.tag = 100 + i;
            [self.dic setValue:array[i] forKey:[NSString stringWithFormat:@"%ld",(long)equipImageView.tag]];
            [self.allDicArray addObject:self.dic];
            
            equipImageView.userInteractionEnabled = YES;
            [equipImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:equipPictureUrlString,(long)[array[i] integerValue]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
            [equipImageView addGestureRecognizer:tap];
            [self.equipDetailView.needView addSubview:equipImageView];
        }
    }
    self.equipDetailView.needView.frame = CGRectMake(CGRectGetMinX(self.equipDetailView.valueLabel.frame), CGRectGetMaxY(self.equipDetailView.needTitleLabel.frame) + 7, CGRectGetWidth(self.equipDetailView.valueLabel.frame), needViewHeight);
    //设置"可合成"的位置位置大小
    self.equipDetailView.composeTitleLabel.frame = CGRectMake(15, CGRectGetMaxY(self.equipDetailView.needView.frame) + 15, 100, 25);
    //设置composeView的位置大小
    CGFloat composeViewHeight = 20;
    if (![equipDetailModel.compose isEqualToString:@""]) {
        composeViewHeight = 60;
        NSArray *array = [equipDetailModel.compose componentsSeparatedByString:@","];
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.equipDetailView.needView.frame), 60)];
        scrollView.contentSize = CGSizeMake(array.count * 55 + 5, composeViewHeight);
        scrollView.showsHorizontalScrollIndicator = NO;
        for (int i = 0; i < array.count; i++) {
            
            
            UIImageView *equipImageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * 55 + 5, 5, 50, 50)];
            equipImageView.userInteractionEnabled = YES;
            
            //设置tag值
            equipImageView.tag = 200 + i;
            [self.dic setValue:array[i] forKey:[NSString stringWithFormat:@"%ld",(long)equipImageView.tag]];
            [self.allDicArray addObject:self.dic];
            
            
            [equipImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:equipPictureUrlString,[array[i] integerValue]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
            [equipImageView addGestureRecognizer:tap];
            [scrollView addSubview:equipImageView];

        }
        [self.equipDetailView.composeView addSubview:scrollView];
    }
    self.equipDetailView.composeView.frame = CGRectMake(CGRectGetMinX(self.equipDetailView.needView.frame), CGRectGetMaxY(self.equipDetailView.composeTitleLabel.frame) + 7, CGRectGetWidth(self.equipDetailView.needView.frame), composeViewHeight);
    
    [self.loadingView setHidden:YES];
    
}

#pragma mark - 懒加载
- (NSMutableArray *)allDicArray{
    if (_allDicArray == nil) {
        _allDicArray = [NSMutableArray array];
    }
    return _allDicArray;
}

- (NSMutableDictionary *)dic{
    if (_dic == nil) {
        _dic = [NSMutableDictionary dictionary];
    }
    return _dic;
}



#pragma mark - 图片手势事件
- (void)tapClick:(UITapGestureRecognizer *)tap{
    EquipDetailViewController *equipDetailVC = [[EquipDetailViewController alloc]init];
    
    equipDetailVC.Id = [self.dic[[NSString stringWithFormat:@"%ld",[tap view].tag]] integerValue];
    [self showViewController:equipDetailVC sender:nil];
    
}

#pragma mark - 自适应高度方法
- (CGFloat)returnValueLabelHeight:(NSString *)string{
    CGRect temp = [string boundingRectWithSize:CGSizeMake(self.equipDetailView.frame.size.width - 30, 1000) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
    return temp.size.height + 8;
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
