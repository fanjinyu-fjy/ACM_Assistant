//
//  UINavigationBar+FJY.m
//  ACM_Assistant
//
//  Created by 幻月瑶琴 on 16/3/28.
//  Copyright © 2016年 幻月瑶琴. All rights reserved.
//

#import "UINavigationBar+FJY.h"
#import <objc/runtime.h>

#define StatusBarHeight 20

@implementation UINavigationBar (FJY)

#pragma mark - 定义属性
static char coverViewKey;

- (UIView *)coverView
{
    return objc_getAssociatedObject(self, &coverViewKey);
}

- (void)setCoverView:(UIView *)coverView
{
    objc_setAssociatedObject(self, &coverViewKey, coverView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// 设置背景颜色
- (void)fjy_setBackgroundColor:(UIColor *)backgroundColor
{
    if (!self.coverView) {
        [self setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
        self.coverView = [[UIView alloc]initWithFrame:CGRectMake(0, -StatusBarHeight, FJYScreenWidth, CGRectGetHeight(self.bounds) + StatusBarHeight)];
        self.coverView.userInteractionEnabled = NO;
        self.coverView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self insertSubview:self.coverView atIndex:0];
    }
    self.coverView.backgroundColor = backgroundColor;
}

- (void)fjy_setNavigatdionBarTranslation:(CGFloat)translation
{
    FJYLog(@"%f", translation);
    [self fjy_setTranslationY:-44*translation];
    [self fjy_setElementsAlpha:1-translation];
}

- (void)fjy_setTranslationY:(CGFloat)translationY
{
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}


// 将其余的view隐藏
- (void)fjy_setElementsAlpha:(CGFloat)alpha
{
    [[self valueForKey:@"_leftViews"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *view = (UIView *)obj;
        view.alpha = alpha;
    }];
    
    [[self valueForKey:@"_rightViews"]enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *view = (UIView *)obj;
        view.alpha = alpha;
    }];
    
    
    UIView *titleView = [self valueForKey:@"_titleView"];
    titleView.alpha = alpha;
    
}

- (void)fjy_reset
{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.coverView removeFromSuperview];
    self.coverView = nil;
}
@end
