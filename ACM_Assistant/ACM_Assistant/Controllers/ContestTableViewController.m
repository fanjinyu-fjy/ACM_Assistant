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
#import "UIColor+FJY.h"
#import "UINavigationBar+FJY.h"


#define NAVBAR_CHANGE_POINT 50
static NSString * const ContestCellID = @"contest";

@interface ContestTableViewController ()

/** ContestModel对象 */
@property (nonatomic, strong) NSMutableArray *contests;

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


#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ContestCell  class]) bundle:nil] forCellReuseIdentifier:ContestCellID];
    // 配置TableView
    [self setupTableView];
    // 配置下拉控件
    [self setupRefresh];
    
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
    
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
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
        // 刷新表格
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

#pragma mark - UITabBar自动消失
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > 0) {
        if (offsetY > 44) {
            [self.navigationController.navigationBar fjy_setNavigatdionBarTranslation:1];
        }else{
            [self.navigationController.navigationBar fjy_setNavigatdionBarTranslation:(offsetY/44)];
        }
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
