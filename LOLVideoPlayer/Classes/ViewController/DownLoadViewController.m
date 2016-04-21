//
//  DownLoadViewController.m
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/8.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "DownLoadViewController.h"
#import "DownLoadView.h"
#import "AFHTTPRequestOperation.h"
#import "DownLoadCell.h"
#import "DownLoadHelper.h"
#import "DownLoadModel.h"
#import "VideoPlayer.h"

@interface DownLoadViewController () <UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic,strong)DownLoadView *downLoadView;
//@property (nonatomic,strong)NSMutableArray *allDownLoaingArray;

@property (nonatomic,copy)NSString *pictureString;
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,assign)BOOL isDelete;

@end

@implementation DownLoadViewController

- (void)handleData{
    NSString *downLoadPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *path = nil;//[documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4",self.vid]];
    NSDirectoryEnumerator *enumerator_1 = [manager enumeratorAtPath:downLoadPath];
    while((path = [enumerator_1 nextObject]) != nil){
        if ([path hasSuffix:@"mp4"]) {
            if (![[DownLoadHelper shareDownLoadHelper].allDownLoadedArray containsObject:path]) {
                if ([DownLoadHelper shareDownLoadHelper].allDownLoadingArray.count == 0) {
                    [[DownLoadHelper shareDownLoadHelper].allDownLoadedArray addObject:path];
                }else if (![[DownLoadHelper shareDownLoadHelper].allDownLoadingArray[0][1] isEqualToString:[path substringToIndex:path.length - 4]]) {
                    [[DownLoadHelper shareDownLoadHelper].allDownLoadedArray addObject:path];
                }
                
                
            }
            
        }
        
    }
    

    if (self.vid != nil) {
        [[CDHttpHelper defaultCDHttpHelper] get:[videoDetailUrlString stringByAppendingString:self.vid] params:nil success:^(id responseObj) {
            
            
            
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObj options:(NSJSONReadingAllowFragments) error:nil];
            NSString *urlString = dic[@"result"][@"items"][self.distinct][@"transcode"][@"urls"][0];
            self.pictureString = dic[@"result"][@"cover"];
            if (urlString != nil && self.vid != 0) {
                
                //下载视频
                [self downloadFileURL:urlString savePath:downLoadPath fileName:[NSString stringWithFormat:@"%@.mp4",self.aTitle] tag:[self.vid integerValue]];
                
                
            }else{
                
                self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerClick) userInfo:nil repeats:YES];
                
            }
            
            
        } failure:^(NSError *error) {
            
        }];

    }else{
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerClick) userInfo:nil repeats:YES];
    }
    
}

- (void)timerClick{
    [self.downLoadView.aTableView reloadData];
    if ([DownLoadHelper shareDownLoadHelper].allDownLoadingArray.count == 0) {
        
        [self.timer invalidate];
        self.timer = nil;
        [self.downLoadView.bTableView reloadData];
    }
}

- (void)loadView{
    self.downLoadView = [[DownLoadView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.downLoadView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    [self setNavigationBar];
    [self handleData];
    [self.downLoadView.segment addTarget:self action:@selector(segmentClick:) forControlEvents:(UIControlEventValueChanged)];
    
    self.downLoadView.aTableView.delegate = self;
    self.downLoadView.aTableView.dataSource = self;
    self.downLoadView.bTableView.delegate = self;
    self.downLoadView.bTableView.dataSource = self;
    self.downLoadView.pageScrollView.delegate = self;
    [self.downLoadView.aTableView registerNib:[UINib nibWithNibName:@"DownLoadCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    
}

- (void)segmentClick:(UISegmentedControl *)segment{
    if (segment.selectedSegmentIndex == 1) {
        [self.downLoadView.pageScrollView setContentOffset:CGPointMake(self.downLoadView.frame.size.width, 0) animated:YES];
    }
    if (segment.selectedSegmentIndex == 0) {
        [self.downLoadView.pageScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.downLoadView.segment.selectedSegmentIndex = self.downLoadView.pageScrollView.contentOffset.x / self.downLoadView.frame.size.width;
}

- (void)setNavigationBar{
    //设置导航栏颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.281 green:0.281 blue:0.281 alpha:1]];
    //设置导航栏为不透明
    self.navigationController.navigationBar.translucent = NO;
    //自定义导航栏
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    label.text = @"下载";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    //设置title
    self.navigationItem.titleView = label;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:(UIBarButtonItemStyleDone) target:self action:@selector(editClick)];
    
}

- (void)editClick{
    [self.downLoadView.bTableView setEditing:!self.downLoadView.bTableView.editing animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    self.downLoadView.bTableView.editing = NO;
    if ([self.downLoadView.bTableView indexPathForSelectedRow] != nil) {
        [self.downLoadView.bTableView deselectRowAtIndexPath:[self.downLoadView.bTableView indexPathForSelectedRow] animated:YES];
    }
    if ([DownLoadHelper shareDownLoadHelper].allDownLoadingArray.count != 0) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerClick) userInfo:nil repeats:YES];
    }else{
        [self.downLoadView.bTableView reloadData];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)downloadFileURL:(NSString *)aUrl savePath:(NSString *)aSavePath fileName:(NSString *)aFileName tag:(NSInteger)aTag{
    NSFileManager *manager = [NSFileManager defaultManager];
    //检查本地文件是否已存在
    NSString *fileName = [NSString stringWithFormat:@"%@/%@",aSavePath,aFileName];
    //检查附件是否存在
    if ([manager fileExistsAtPath:fileName]) {
        //NSData *videoData = [NSData dataWithContentsOfFile:fileName];
        self.downLoadView.segment.selectedSegmentIndex = 1;
        self.downLoadView.pageScrollView.contentOffset = CGPointMake(self.downLoadView.frame.size.width, 0);
        NSLog(@"已存在");
    }
    else{
        //创建附件目录
        if (![manager fileExistsAtPath:aSavePath]) {
           BOOL result = [manager createDirectoryAtPath:aSavePath withIntermediateDirectories:YES attributes:nil error:nil];
            NSLog(@"%d",result);
        }
        //下载附件
        NSURL *url = [[NSURL alloc]initWithString:aUrl];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
        operation.inputStream = [NSInputStream inputStreamWithURL:url];
        operation.outputStream = [NSOutputStream outputStreamToFileAtPath:fileName append:NO];
        //下载进度控制
        [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
            
            if (self.isDelete == YES) {
                [operation pause];
                return ;
            }
            NSMutableArray *array = [NSMutableArray arrayWithObjects:self.pictureString,self.aTitle,[NSString stringWithFormat:@"%f",(float)totalBytesRead / totalBytesExpectedToRead], nil];
            [[DownLoadHelper shareDownLoadHelper].allDownLoadingArray removeLastObject];
            [[DownLoadHelper shareDownLoadHelper].allDownLoadingArray addObject:array];
            
            [self.downLoadView.aTableView reloadData];
        }];
        //已完成下载
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            // NSData *videoData = [NSData dataWithContentsOfFile:fileName];
            //下载完毕操作
            NSLog(@"完成");
            [[DownLoadHelper shareDownLoadHelper].allDownLoadingArray removeAllObjects];
            [self.downLoadView.aTableView reloadData];
//            NSMutableArray *array = [NSMutableArray arrayWithObjects:self.pictureString,self.aTitle, nil];
//            [[DownLoadHelper shareDownLoadHelper].allDownLoadedArray addObject:array];
            
            if (![[DownLoadHelper shareDownLoadHelper].allDownLoadedArray containsObject:[NSString stringWithFormat:@"%@.mp4",self.aTitle]]) {
                [[DownLoadHelper shareDownLoadHelper].allDownLoadedArray addObject:[NSString stringWithFormat:@"%@.mp4",self.aTitle]];
                [self.downLoadView.bTableView reloadData];
            }
            
            
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
        [operation start];
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.downLoadView.aTableView]) {
        DownLoadCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[DownLoadCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
        }
        
        NSArray *array = [DownLoadHelper shareDownLoadHelper].allDownLoadingArray[indexPath.row];
        [cell.picImageView sd_setImageWithURL:[NSURL URLWithString:array[0]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        cell.nameLabel.text = array[1];
        [cell.progressView setProgress:[array[2] floatValue] animated:YES];
        [cell.startAndStop addTarget:self action:@selector(delClick) forControlEvents:(UIControlEventTouchUpInside)];
        
        return cell;
    }else if ([tableView isEqual:self.downLoadView.bTableView]){
        UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
        }
        
        NSString *string = [DownLoadHelper shareDownLoadHelper].allDownLoadedArray[indexPath.row];
        cell.textLabel.text = string;

        
        return cell;
    }
    return nil;
}

- (void)delClick{
    [[DownLoadHelper shareDownLoadHelper].allDownLoadingArray removeAllObjects];
    [self.downLoadView.aTableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:(UITableViewRowAnimationBottom)];
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *downLoadPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    
    [manager removeItemAtPath:[downLoadPath stringByAppendingPathComponent:[self.aTitle stringByAppendingString:@".mp4"]] error:nil];
    self.isDelete = YES;
    
    [self.downLoadView.aTableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.downLoadView.aTableView]) {
        
    }else if ([tableView isEqual:self.downLoadView.bTableView]){
        NSString *documents = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        NSString *videoPath = [documents stringByAppendingPathComponent:[DownLoadHelper shareDownLoadHelper].allDownLoadedArray[indexPath.row]];
        
        
        NSURL *theurl=[NSURL fileURLWithPath:videoPath];
        [[VideoPlayer shareVideoPlayer] playWithUrlString:[NSString stringWithFormat:@"%@",theurl] andTarget:self];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.downLoadView.aTableView]) {
        return 90;
    }else if ([tableView isEqual:self.downLoadView.bTableView]){
        return 50;
    }
    return 90;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:self.downLoadView.aTableView]) {
        return [DownLoadHelper shareDownLoadHelper].allDownLoadingArray.count;
    }else if ([tableView isEqual:self.downLoadView.bTableView]){
        return [DownLoadHelper shareDownLoadHelper].allDownLoadedArray.count;
    }
    return [DownLoadHelper shareDownLoadHelper].allDownLoadingArray.count;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.downLoadView.aTableView]) {
        return NO;
    }else if ([tableView isEqual:self.downLoadView.bTableView]){
        return YES;
    }
    return NO;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.downLoadView.aTableView]) {
//
    }else if ([tableView isEqual:self.downLoadView.bTableView]){
        
    }                                                                                                                                                                    
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *downLoadPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    [manager removeItemAtPath:[downLoadPath stringByAppendingPathComponent:[DownLoadHelper shareDownLoadHelper].allDownLoadedArray[indexPath.row]] error:nil];
    [[DownLoadHelper shareDownLoadHelper].allDownLoadedArray removeObjectAtIndex:indexPath.row];
    [self.downLoadView.bTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationBottom)];
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
