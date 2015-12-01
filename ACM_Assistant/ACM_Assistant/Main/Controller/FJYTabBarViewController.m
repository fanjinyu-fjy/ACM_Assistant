//
//  FJYTabBarViewController.m
//  ACM_Assistant
//
//  Created by 幻月瑶琴 on 15/12/2.
//  Copyright © 2015年 幻月瑶琴. All rights reserved.
//

#import "FJYTabBarViewController.h"
#import "FJYNavigationController.h"

#import "FJYContestTableViewController.h"

@interface FJYTabBarViewController ()

@end

@implementation FJYTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FJYContestTableViewController *contestVC = [[FJYContestTableViewController alloc]init];
    contestVC.title = @"比赛";
    contestVC.tabBarItem.title = @"比赛";
    
    FJYNavigationController *NVC = [[FJYNavigationController alloc]init];
    [NVC pushViewController:contestVC animated:YES];
    [self addChildViewController:NVC];
    
    
    
}



@end
