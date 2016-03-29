//
//  MainNavigationController.m
//  ACM_Assistant
//
//  Created by 幻月瑶琴 on 16/3/28.
//  Copyright © 2016年 幻月瑶琴. All rights reserved.
//

#import "MainNavigationController.h"

#import "UIView+FJY.h"
#import "UIImage+FJY.h"
#import "UIColor+FJY.h"
@implementation MainNavigationController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //删除自带的UINavigationBarBackground
    [self deleteBarBackground];
    
    //自定义NavigationBar
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarTintColor: [UIColor customBlueColor]];
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont systemFontOfSize:21], NSFontAttributeName, nil]];
    
    
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

//// 改变push
//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    
//    if (self.childViewControllers.count > 0) {
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [btn setTitle:@"返回" forState:UIControlStateNormal];
//        [btn setImage:[UIImage imageWithOriginalName:@"navigationButtonReturn"] forState:UIControlStateNormal];
//        [btn setImage:[UIImage imageWithOriginalName:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
//        btn.size = CGSizeMake(50, 30);
//    
//        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
//        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 2, 0, 0);
//        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
//        
//        [btn addTarget:self action:@selector(black) forControlEvents:UIControlEventTouchUpInside];
//        
//        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
//        
//        viewController.hidesBottomBarWhenPushed = YES;
//    }
//    
//    [super pushViewController:viewController animated:animated];
//}
//
//- (void)black{
//    [super popViewControllerAnimated:YES];
//}

#pragma mark 删除_UINavigationBarBackground
- (void)deleteBarBackground
{
    UINavigationBar *bar =  self.navigationBar;
    for (UIView *view in bar.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
            [view removeFromSuperview];
        }
    }
}



#pragma mark 状态栏设置
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
