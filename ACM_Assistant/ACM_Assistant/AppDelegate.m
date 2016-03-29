//
//  AppDelegate.m
//  ACM_Assistant
//
//  Created by 幻月瑶琴 on 15/11/20.
//  Copyright © 2015年 幻月瑶琴. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"


#import <AFNetworkActivityIndicatorManager.h>
#import <AFNetworkReachabilityManager.h>
#import <UMSocial.h>
#import <UMSocialWechatHandler.h>
#import <UMSocialQQHandler.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    MainTabBarController *MainVC = [[MainTabBarController alloc]init];
    self.window.rootViewController = MainVC;
    
    [self.window makeKeyAndVisible];
  
    
    // 网络
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 友盟
    [UMSocialData setAppKey:@"56fa2d8de0f55a3b6900338b"];
    [UMSocialWechatHandler setWXAppId:@"wx4868b35061f87885"
                            appSecret:@"64020361b8ec4c99936c0e3999a9f249"
                                  url:@"http://www.huanyueyaoqin.com"];
    [UMSocialQQHandler setQQWithAppId:@"1105220907" appKey:@"UolBxBLHapSgkBcf" url:@"http://www.huanyueyaoqin.com"];
    
    return YES;
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
