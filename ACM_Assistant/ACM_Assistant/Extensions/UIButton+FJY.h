//
//  UIButton+FJY.h
//  ACM_Assistant
//
//  Created by 幻月瑶琴 on 16/3/28.
//  Copyright © 2016年 幻月瑶琴. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (FJY)
+ (UIButton *)buttonWithImageName:(NSString *)imageName SelectImageName:(NSString *)selectImageName target:(id)target action:(SEL)action;
@end
