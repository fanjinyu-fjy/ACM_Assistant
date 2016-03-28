//
//  ContestModel.h
//  ACM_Assistant
//
//  Created by 幻月瑶琴 on 16/3/28.
//  Copyright © 2016年 幻月瑶琴. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContestModel : NSObject

@property (nonatomic, assign) int id;
@property (nonatomic, copy) NSString *oj;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *start_time;
@property (nonatomic, copy) NSString *week;
@property (nonatomic, copy) NSString *access;




+ (instancetype)contestWithDict:(NSDictionary *)dict;

@end
