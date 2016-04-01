//
//  ContestDB.m
//  ACM_Assistant
//
//  Created by 幻月瑶琴 on 16/3/31.
//  Copyright © 2016年 幻月瑶琴. All rights reserved.
//

#import "ContestDB.h"
#import <FMDB.h>

@interface ContestDB()

@property (nonatomic, copy) NSString *dbPath;

@end


@implementation ContestDB


// 创建数据库
- (void)createTable{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:self.dbPath] == NO) {
        // create it
        FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
        if ([db open]) {
            NSString * sql = @"CREATE TABLE 'Contest' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,'oj' VARCHAR(10),'link' VARCHAR(80),'name' VARCHAR(30), 'start_time' VARCHAR(30), 'week' VARCHAR(5), 'star' TINYINT DEFAULT 0)";
            BOOL res = [db executeUpdate:sql];
            if (!res) {
                FJYLog(@"error to create db");
            } else {
                FJYLog(@"succ to create db");
            }
            [db close];
        } else {
            
        }
    }
}


@end
