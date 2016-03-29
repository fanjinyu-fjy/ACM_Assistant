//
//  ContestModel.h
//  ACM_Assistant
//
//  Created by 幻月瑶琴 on 16/3/28.
//  Copyright © 2016年 幻月瑶琴. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ContestCell;

@interface ContestModel : NSObject

/** 比赛ID */
@property (nonatomic, assign) int id;
/** 比赛OJ */
@property (nonatomic, copy) NSString *oj;
/** 比赛链接 */
@property (nonatomic, copy) NSString *link;
/** 比赛名称 */
@property (nonatomic, copy) NSString *name;
/** 比赛开始时间 */
@property (nonatomic, copy) NSString *start_time;
/** 比赛周几 */
@property (nonatomic, copy) NSString *week;
/** 比赛访问权限 */
@property (nonatomic, copy) NSString *access;



/** cell的高度 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;


@property (nonatomic, strong) ContestCell *contestCell;


+ (instancetype)contestWithDict:(NSDictionary *)dict;

@end
