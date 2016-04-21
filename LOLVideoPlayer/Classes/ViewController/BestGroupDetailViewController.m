//
//  BestGroupDetailViewController.m
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/5.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "BestGroupDetailViewController.h"
#import "BestGroupDetailView.h"
#import "HeroDetailViewController.h"

@interface BestGroupDetailViewController ()

@property (nonatomic,strong)BestGroupDetailView *bestGroupDetailView;

@property (nonatomic,strong)LoadingView *loadingView;

@end

@implementation BestGroupDetailViewController

- (void)setData{
    self.bestGroupDetailView.titleLabel.text = self.aTitle;
    
    [self.bestGroupDetailView.aImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:heroPictureUrlString,self.hero1]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    [self.bestGroupDetailView.bImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:heroPictureUrlString,self.hero2]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    [self.bestGroupDetailView.cImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:heroPictureUrlString,self.hero3]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    [self.bestGroupDetailView.dImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:heroPictureUrlString,self.hero4]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    [self.bestGroupDetailView.eImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:heroPictureUrlString,self.hero5]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    UITapGestureRecognizer *tap5 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    self.bestGroupDetailView.aImageView.tag = 200;
    self.bestGroupDetailView.bImageView.tag = 201;
    self.bestGroupDetailView.cImageView.tag = 202;
    self.bestGroupDetailView.dImageView.tag = 203;
    self.bestGroupDetailView.eImageView.tag = 204;
    [self.bestGroupDetailView.aImageView addGestureRecognizer:tap1];
    [self.bestGroupDetailView.bImageView addGestureRecognizer:tap2];
    [self.bestGroupDetailView.cImageView addGestureRecognizer:tap3];
    [self.bestGroupDetailView.dImageView addGestureRecognizer:tap4];
    [self.bestGroupDetailView.eImageView addGestureRecognizer:tap5];
    
    
    self.bestGroupDetailView.desLabel.text = self.des;
    CGFloat desHeight = [self getHeightWithString:self.des andWidth:[UIScreen mainScreen].bounds.size.width - 20 andFontSize:13];
    //获取高度后调整frame
    self.bestGroupDetailView.desLabel.frame = CGRectMake(CGRectGetMinX(self.bestGroupDetailView.titleLabel.frame), CGRectGetMaxY(self.bestGroupDetailView.aImageView.frame) + 10, [UIScreen mainScreen].bounds.size.width - 20, desHeight);
    //调整lineView的frame
    self.bestGroupDetailView.lineView.frame = CGRectMake(0, CGRectGetMaxY(self.bestGroupDetailView.desLabel.frame) + 10, [UIScreen mainScreen].bounds.size.width, 5);
    //调整heroTitle的frame
    self.bestGroupDetailView.heroTitleLabel.frame = CGRectMake(CGRectGetMinX(self.bestGroupDetailView.titleLabel.frame), CGRectGetMaxY(self.bestGroupDetailView.lineView.frame) + 10, 100, 20);
    //调整aImageView2的frame并且设置值
    [self.bestGroupDetailView.aImageView2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:heroPictureUrlString,self.hero1]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.bestGroupDetailView.aImageView2.frame = CGRectMake(CGRectGetMinX(self.bestGroupDetailView.titleLabel.frame), CGRectGetMaxY(self.bestGroupDetailView.heroTitleLabel.frame) + 10, 50, 50);
    //调整hero1Label的frame并且设置数据
    CGFloat hero1LabelHeght = [self getHeightWithString:self.des1 andWidth:[UIScreen mainScreen].bounds.size.width - 75 andFontSize:12];
    self.bestGroupDetailView.hero1Label.frame = CGRectMake(CGRectGetMaxX(self.bestGroupDetailView.aImageView2.frame) + 5, CGRectGetMinY(self.bestGroupDetailView.aImageView2.frame), [UIScreen mainScreen].bounds.size.width - 75, hero1LabelHeght);
    self.bestGroupDetailView.hero1Label.text = self.des1;
    //调整bImageView2的frame并且设置值
    self.bestGroupDetailView.bImageView2.frame = CGRectMake(CGRectGetMinX(self.bestGroupDetailView.titleLabel.frame), CGRectGetMaxY(self.bestGroupDetailView.hero1Label.frame) + 10, 50, 50);
    [self.bestGroupDetailView.bImageView2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:heroPictureUrlString,self.hero2]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    //调整hero2Label的frame并设置数据
    CGFloat hero2LabelHeght = [self getHeightWithString:self.des2 andWidth:[UIScreen mainScreen].bounds.size.width - 75 andFontSize:12];
    self.bestGroupDetailView.hero2Label.frame = CGRectMake(CGRectGetMaxX(self.bestGroupDetailView.aImageView2.frame) + 5, CGRectGetMinY(self.bestGroupDetailView.bImageView2.frame), [UIScreen mainScreen].bounds.size.width - 75, hero2LabelHeght);
    self.bestGroupDetailView.hero2Label.text = self.des2;
    //调整cImageView2的frame并且设置值
    self.bestGroupDetailView.cImageView2.frame = CGRectMake(CGRectGetMinX(self.bestGroupDetailView.titleLabel.frame), CGRectGetMaxY(self.bestGroupDetailView.hero2Label.frame) + 10, 50, 50);
    [self.bestGroupDetailView.cImageView2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:heroPictureUrlString,self.hero3]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    //调整hero3Label的frame并设置数据
    CGFloat hero3LabelHeght = [self getHeightWithString:self.des3 andWidth:[UIScreen mainScreen].bounds.size.width - 75 andFontSize:12];
    self.bestGroupDetailView.hero3Label.frame = CGRectMake(CGRectGetMaxX(self.bestGroupDetailView.aImageView2.frame) + 5, CGRectGetMinY(self.bestGroupDetailView.cImageView2.frame), [UIScreen mainScreen].bounds.size.width - 75, hero3LabelHeght);
    self.bestGroupDetailView.hero3Label.text = self.des3;
    //调整dImageView2的frame并且设置值
    self.bestGroupDetailView.dImageView2.frame = CGRectMake(CGRectGetMinX(self.bestGroupDetailView.titleLabel.frame), CGRectGetMaxY(self.bestGroupDetailView.hero3Label.frame) + 10, 50, 50);
    [self.bestGroupDetailView.dImageView2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:heroPictureUrlString,self.hero4]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    //调整hero4Label的frame并设置数据
    CGFloat hero4LabelHeght = [self getHeightWithString:self.des4 andWidth:[UIScreen mainScreen].bounds.size.width - 75 andFontSize:12];
    self.bestGroupDetailView.hero4Label.frame = CGRectMake(CGRectGetMaxX(self.bestGroupDetailView.aImageView2.frame) + 5, CGRectGetMinY(self.bestGroupDetailView.dImageView2.frame), [UIScreen mainScreen].bounds.size.width - 75, hero4LabelHeght);
    self.bestGroupDetailView.hero4Label.text = self.des4;
    //调整eImageView2的frame并且设置值
    self.bestGroupDetailView.eImageView2.frame = CGRectMake(CGRectGetMinX(self.bestGroupDetailView.titleLabel.frame), CGRectGetMaxY(self.bestGroupDetailView.hero4Label.frame) + 10, 50, 50);
    [self.bestGroupDetailView.eImageView2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:heroPictureUrlString,self.hero5]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    //调整hero5Label的frame并设置数据
    CGFloat hero5LabelHeght = [self getHeightWithString:self.des5 andWidth:[UIScreen mainScreen].bounds.size.width - 75 andFontSize:12];
    self.bestGroupDetailView.hero5Label.frame = CGRectMake(CGRectGetMaxX(self.bestGroupDetailView.aImageView2.frame) + 5, CGRectGetMinY(self.bestGroupDetailView.eImageView2.frame), [UIScreen mainScreen].bounds.size.width - 75, hero5LabelHeght);
    self.bestGroupDetailView.hero5Label.text = self.des5;
    
    CGFloat pageScrollContentHeight = CGRectGetMaxY(self.bestGroupDetailView.hero5Label.frame);
    //设置pageScrollView的滚动范围
    self.bestGroupDetailView.pageScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, pageScrollContentHeight);
    
    UITapGestureRecognizer *tap11 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    UITapGestureRecognizer *tap12 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    UITapGestureRecognizer *tap13 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    UITapGestureRecognizer *tap14 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    UITapGestureRecognizer *tap15 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    self.bestGroupDetailView.aImageView2.tag = 200;
    self.bestGroupDetailView.bImageView2.tag = 201;
    self.bestGroupDetailView.cImageView2.tag = 202;
    self.bestGroupDetailView.dImageView2.tag = 203;
    self.bestGroupDetailView.eImageView2.tag = 204;
    [self.bestGroupDetailView.aImageView2 addGestureRecognizer:tap11];
    [self.bestGroupDetailView.bImageView2 addGestureRecognizer:tap12];
    [self.bestGroupDetailView.cImageView2 addGestureRecognizer:tap13];
    [self.bestGroupDetailView.dImageView2 addGestureRecognizer:tap14];
    [self.bestGroupDetailView.eImageView2 addGestureRecognizer:tap15];
    
    
    [self.loadingView setHidden:YES];
    
}

- (void)tapClick:(UITapGestureRecognizer *)tap{
    HeroDetailViewController *heroDetailVC = [[HeroDetailViewController alloc]init];
    switch ([tap view].tag) {
        case 200:
            heroDetailVC.enName = self.hero1;
            break;
        case 201:
            heroDetailVC.enName = self.hero2;
            break;
        case 202:
            heroDetailVC.enName = self.hero3;
            break;
        case 203:
            heroDetailVC.enName = self.hero4;
            break;
        case 204:
            heroDetailVC.enName = self.hero5;
            break;
    }
    [self showViewController:heroDetailVC sender:nil];
}

#pragma mark - 自适应高度
- (CGFloat)getHeightWithString:(NSString *)string andWidth:(CGFloat)width andFontSize:(NSInteger)fontSize{
    CGRect temp = [string boundingRectWithSize:CGSizeMake(width, 1000) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    return temp.size.height;
}

#pragma mark - 设置导航栏
- (void)setNavigationBar{
    //设置导航栏颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.281 green:0.281 blue:0.281 alpha:1]];
    //设置导航栏为不透明
    self.navigationController.navigationBar.translucent = NO;
    //自定义导航栏
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    label.text = @"阵容详情";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    //设置title
    self.navigationItem.titleView = label;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    //设置返回按钮
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:(UIBarButtonItemStyleDone) target:nil action:nil];
    
}


- (void)loadView{
    self.bestGroupDetailView = [[BestGroupDetailView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.bestGroupDetailView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.loadingView = [[LoadingView alloc]initWithFrame:CGRectMake(0, 0, self.bestGroupDetailView.frame.size.width, self.bestGroupDetailView.frame.size.height - 64)];
    [self.bestGroupDetailView addSubview:self.loadingView];
    
    [self setNavigationBar];
    //给布局设置数据
    [self setData];
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
