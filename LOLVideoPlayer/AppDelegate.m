//
//  AppDelegate.m
//  LOLVideoPlayer
//
//  Created by lanou3g on 16/3/1.
//  Copyright © 2016年 Henry. All rights reserved.
//

#import "AppDelegate.h"
#import "ConsultViewController.h"
#import "CommentaryVideoViewController.h"
#import "CyclopediaViewController.h"
#import "DownLoadViewController.h"

#import "Reachability.h"

@interface AppDelegate ()
{
    Reachability *hostReach;
}

@property (nonatomic, strong) UIAlertController *alertController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [NSThread sleepForTimeInterval:1];
    
    UITabBarController *tbc = [[UITabBarController alloc]init];
    
    UINavigationController *consultNC = [[UINavigationController alloc]initWithRootViewController:[[ConsultViewController alloc]init]];
    consultNC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"资讯" image:[UIImage imageNamed:@"icon_nav_consult"] selectedImage:nil];
    
    UINavigationController *commentaryVideoNC = [[UINavigationController alloc]initWithRootViewController:[[CommentaryVideoViewController alloc]init]];
    commentaryVideoNC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"解说视频" image:[UIImage imageNamed:@"icon_nav_video"] selectedImage:nil];
    
    UINavigationController *cyclopediaNC = [[UINavigationController alloc]initWithRootViewController:[[CyclopediaViewController alloc]init]];
    cyclopediaNC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"联盟百科" image:[UIImage imageNamed:@"icon_nav_keyborad"] selectedImage:nil];
    
    UINavigationController *userNC = [[UINavigationController alloc]initWithRootViewController:[[DownLoadViewController alloc]init]];
    userNC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"下载" image:[UIImage imageNamed:@"icon_download"] selectedImage:nil];
    
    tbc.viewControllers = @[consultNC,commentaryVideoNC,cyclopediaNC];
    [tbc.tabBar setTintColor:[UIColor colorWithRed:0.94 green:0.34 blue:0.07 alpha:1]];
    
    [[UITabBar appearance] setBarTintColor:[UIColor colorWithRed:0.16 green:0.16 blue:0.16 alpha:1]];
    
    self.window.rootViewController = tbc;
    
    
    //网络
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    hostReach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    [hostReach startNotifier];

    return YES;
}
-(void)reachabilityChanged:(NSNotification *)note {
    
    Reachability *curReach = [note object];
    
    NSCParameterAssert([curReach isKindOfClass:[Reachability class]]);
    
    NetworkStatus status = [curReach currentReachabilityStatus];
    
    if (status == NotReachable) {
        
        [self getNewAlertController];
        self.alertController.title = @"找不到网络";
        [[NSUserDefaults standardUserDefaults] setValue:@"meiwang" forKey:@"ifConnection"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:self.alertController animated:YES completion:nil];
        
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerClick) userInfo:nil repeats:NO];
        
        
    }
    else if (status == ReachableViaWiFi){
        NSLog(@"-------wifi");
        [self getNewAlertController];
        self.alertController.title = @"当前使用:wifi";
        [[NSUserDefaults standardUserDefaults] setValue:@"wifi" forKey:@"ifConnection"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:self.alertController animated:YES completion:nil];
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerClick) userInfo:nil repeats:NO];
    }
    else if (status == ReachableViaWWAN) {
        NSLog(@"------wwan");
        
        [self getNewAlertController];
        self.alertController.title = @"当前使用:wwan";
        [[NSUserDefaults standardUserDefaults] setValue:@"wofeng" forKey:@"ifConnection"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:self.alertController animated:YES completion:nil];
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerClick) userInfo:nil repeats:NO];
    }
    
}

- (void)timerClick{
    
    [[UIApplication sharedApplication].delegate.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
    
    self.alertController = nil;
}

- (void)getNewAlertController
{
    self.alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    // Create the actions.
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
//    }];
    
    // Add the actions.
    //[self.alertController addAction:cancelAction];
    
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
