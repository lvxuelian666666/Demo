//
//  AppDelegate.m
//  Demo
//
//  Created by Shelly on 2019/3/27.
//  Copyright © 2019年 Shelly. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "FourthViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
@interface AppDelegate ()

@property (assign, nonatomic) UIBackgroundTaskIdentifier backgroundUpdateTask;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    ThirdViewController *vc = [[ThirdViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"\n ===> 程序暂行 !");
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];

}


- (void)applicationDidEnterBackground:(UIApplication *)application {
   NSLog(@"\n ===> 程序进入后台 !");
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
     NSLog(@"\n ===> 程序进入前台 !");
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
   NSLog(@"\n ===> 程序重新激活 !");
}


- (void)applicationWillTerminate:(UIApplication *)application {
     NSLog(@"\n ===> 程序意外暂行 !");   
}

//- (void)beingBackgroundUpdateTask
//{
//    self.backgroundUpdateTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
//        [self endBackgroundUpdateTask];
//    }];
//}
//- (void)endBackgroundUpdateTask
//{
//    [[UIApplication sharedApplication] endBackgroundTask: self.backgroundUpdateTask];
//    self.backgroundUpdateTask = UIBackgroundTaskInvalid;
//}


@end
