//
//  MainTabBarController.m
//  ACM_Assistant
//
//  Created by 幻月瑶琴 on 16/3/28.
//  Copyright © 2016年 幻月瑶琴. All rights reserved.
//

#import "MainTabBarController.h"
#import "MainNavigationController.h"
#import "ContestTableViewController.h"

#import "UIImage+FJY.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //向UITabBarController中添加子控制器
    //最近比赛
    [self addChildVC:[[ContestTableViewController alloc]init] title:@"比赛" ImageName:nil SelectImageName:nil];
    //
    //
    //
    
    
}


/** 向UITabBarController中添加子控制器 */
- (void)addChildVC:(UIViewController *)vc title:(NSString *)title ImageName:(NSString *)imageName SelectImageName:(NSString *)selectedImageName{
    //vc.title = title;
    //设置TabBar的文字 图片
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageWithOriginalName:imageName];
    vc.tabBarItem.selectedImage = [UIImage imageWithOriginalName:selectedImageName];
    //    vc.view.backgroundColor = [UIColor whiteColor];
    
    //将导航控制器添加到UITabBarController中
    MainNavigationController *NVC = [[MainNavigationController alloc]initWithRootViewController:vc];
    [self addChildViewController:NVC];
}

@end
