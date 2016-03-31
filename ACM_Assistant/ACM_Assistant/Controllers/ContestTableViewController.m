//
//  ContestTableViewController.m
//  ACM_Assistant
//
//  Created by 幻月瑶琴 on 16/3/28.
//  Copyright © 2016年 幻月瑶琴. All rights reserved.
//

#import "ContestTableViewController.h"
#import "ContestDetailController.h"
#import "ContestCell.h"
#import "ContestModel.h"

#import <AFNetworking.h>
#import <MBProgressHUD.h>
#import <MJRefresh.h>
#import <MJExtension.h>
#import <FMDB.h>
#import "UIColor+FJY.h"
#import "UIView+FJY.h"
#import "UINavigationBar+FJY.h"


#define NAVBAR_CHANGE_POINT 50
static NSString * const ContestCellID = @"contest";


@interface ContestTableViewController ()

/** ContestModel对象 */
@property (nonatomic, strong) NSMutableArray *contests;
/** contest数据表路径 */
@property (nonatomic, copy) NSString *dbPath;

@end

@implementation ContestTableViewController

#pragma mark - 懒加载
- (NSMutableArray *)contests
{
    if (!_contests) {
        self.contests = [[NSMutableArray alloc]init];
    }
    return _contests;
}

#pragma mark - 数据库

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

// 插入数据
- (void)insertData{
    
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        NSString * sql = @"insert into contest (id, oj, link, name, start_time, week) values(?, ?, ?, ?, ?, ?)";
        for (ContestModel *contest in self.contests) {
            BOOL res = [db executeUpdate:sql, [NSNumber numberWithInteger:contest.id], contest.oj, contest.link, contest.name, contest.start_time, contest.week];
            if (!res) {
                FJYLog(@"error to insert data");
            } else {
                FJYLog(@"succ to insert data");
            }
        }
        [db close];
    }
}


#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated{
//    FJYLog(@"%s", __func__);
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar fjy_setNavigatdionBarTranslation:0];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self scrollViewDidScroll:self.tableView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ContestCell  class]) bundle:nil] forCellReuseIdentifier:ContestCellID];
    // 数据库路径
    NSString * doc = PATH_OF_DOCUMENT;
    NSString * path = [doc stringByAppendingPathComponent:@"contest.sqlite"];
    self.dbPath = path;
    
    // 配置TableView
    [self setupTableView];
    // 配置下拉控件
    [self setupRefresh];
    

    
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController.navigationBar fjy_setNavigatdionBarTranslation:0];
    [self.navigationController.navigationBar fjy_reset];
}



// 配置TableView
- (void)setupTableView{
    
    self.tableView.backgroundColor = ColorGlobalBG;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIColor * color = [UIColor customBlueColor];
    [self.navigationController.navigationBar fjy_setBackgroundColor:color];
    
    // 增添 历史比赛按钮
//    UIBarButtonItem *historyButton = [UIBarButtonItem new];
    
}


// 配置下拉控件
- (void)setupRefresh{
    // 下拉刷新数据
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(downData)];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:self.dbPath] == NO) {
        // 马上进入刷新状态
        [self.tableView.mj_header beginRefreshing];
    }else{

        // 从数据库中导出数据
        FMDatabase *db = [FMDatabase databaseWithPath:self.dbPath];
        if ([db open]) {
            NSString *sql = @"select * from contest c Where strftime(start_time) > CURRENT_TIMESTAMP ORDER By c.id";
            FMResultSet *rs = [db executeQuery:sql];
            [self.contests removeAllObjects];
            while ([rs next]) {
                ContestModel *contest = [[ContestModel alloc]init];
                contest.id = [rs intForColumn:@"id"];
                contest.oj = [rs stringForColumn:@"oj"];
                contest.link = [rs stringForColumn:@"link"];
                contest.name = [rs stringForColumn:@"name"];
                contest.start_time = [rs stringForColumn:@"start_time"];
                contest.week = [rs stringForColumn:@"week"];
                [self.contests addObject:contest];
            }
            [self.tableView reloadData];
            [db close];
        }
    }
    
}

#pragma mark - 下载刷新数据
- (void)downData
{
    // url链接
    static NSString *URLStr = @"http://contests.acmicpc.info/contests.json";
    //
    [[AFHTTPSessionManager manager]GET:URLStr parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSArray *contestArray = responseObject;
        for (NSDictionary *contestDict in contestArray) {
            ContestModel *contest = [ContestModel contestWithDict:contestDict];
            [self.contests addObject:contest];
        }
        [self createTable];
        [self insertData];
        // 刷新表格
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}



#pragma mark - UITabBar自动消失
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    FJYLog(@"%s", __func__);
    CGFloat offsetY = scrollView.contentOffset.y;
//    FJYLog(@"----%f", offsetY);
    if (offsetY > 0) {
        [self.navigationController.navigationBar fjy_setNavigatdionBarTranslation: offsetY > 44 ? 1 : (offsetY/44)];
    }else{
        [self.navigationController.navigationBar fjy_setNavigatdionBarTranslation:0];
    }
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contests.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContestCell *cell = [self.tableView dequeueReusableCellWithIdentifier:ContestCellID forIndexPath:indexPath];
    cell.contestModel = self.contests[indexPath.row];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ContestModel *contestModel = self.contests[indexPath.row];
    return contestModel.cellHeight;
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ContestDetailController *detailVC = [ContestDetailController new];
    detailVC.contestModel = self.contests[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
    

}


@end
