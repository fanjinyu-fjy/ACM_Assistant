//
//  ContestModel.m
//  ACM_Assistant
//
//  Created by 幻月瑶琴 on 16/3/28.
//  Copyright © 2016年 幻月瑶琴. All rights reserved.
//

#import "ContestModel.h"

@implementation ContestModel

+ (instancetype)contestWithDict:(NSDictionary *)dict{
    ContestModel *model = [ContestModel new];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

@end
