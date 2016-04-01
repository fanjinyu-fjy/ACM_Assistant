//
//  ContestModel.m
//  ACM_Assistant
//
//  Created by 幻月瑶琴 on 16/3/28.
//  Copyright © 2016年 幻月瑶琴. All rights reserved.
//

#import "ContestModel.h"
#import "ContestCell.h"

@implementation ContestModel
{
    CGFloat _cellHeight;
}

- (id)init{
    if (self == [super init]) {
        _star = NO;
    }
    return self;
}

+ (instancetype)contestWithDict:(NSDictionary *)dict{
    ContestModel *model = [ContestModel new];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

/** 计算cell的高度 */
- (CGFloat)cellHeight{
    if (!_cellHeight) {
        
        // 文字左边的
        CGFloat leadingMargin = 15.0f;
        CGFloat trailingMargin = 45.0f;
        // 文字的最大尺寸
        CGSize maxSize = CGSizeMake(FJYScreenWidth - leadingMargin - trailingMargin, MAXFLOAT);
        // 计算文字的高度
        NSMutableDictionary *attr = [NSMutableDictionary dictionary];
        attr[NSFontAttributeName] = [UIFont fontWithName:@"Avenir Next Medium" size:16.0];
        CGFloat nameH = [self.name boundingRectWithSize:maxSize
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:attr
                                                context:nil].size.height;
        // 文字自身的Y值
        CGFloat nameLabelY = 55;

        _cellHeight = nameLabelY + nameH + 15.0;
        
    }
    
    return _cellHeight;
}

@end
