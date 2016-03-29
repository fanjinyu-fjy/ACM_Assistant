//
//  UIButton+FJY.m
//  ACM_Assistant
//
//  Created by 幻月瑶琴 on 16/3/28.
//  Copyright © 2016年 幻月瑶琴. All rights reserved.
//

#import "UIButton+FJY.h"
#import "UIImage+FJY.h"
#import "UIView+FJY.h"

#import <POP.h>

@implementation UIButton (FJY)

+ (UIButton *)buttonWithImageName:(NSString *)imageName SelectImageName:(NSString *)selectImageName target:(id)target action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageWithOriginalName:imageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithOriginalName:selectImageName] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.size = button.currentBackgroundImage.size;
    
    return button;
}

- (void)setButtonAnimation{
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    animation.toValue = [NSValue valueWithCGSize:CGSizeMake(0.85, 0.85)];
    animation.springBounciness = 18;
    [self pop_addAnimation:animation forKey:@"buttonSpringAnimation"];
    
    
}

@end
