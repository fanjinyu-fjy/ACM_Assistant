//
//  ContestTableViewController.m
//  ACM_Assistant
//
//  Created by 幻月瑶琴 on 16/3/28.
//  Copyright © 2016年 幻月瑶琴. All rights reserved.
//

#import "ContestTableViewController.h"
#import "ContestCell.h"
#import "ContestModel.h"

#import <AFNetworking.h>
#import <MBProgressHUD.h>
#import <MJRefresh.h>

#import "UIColor+FJY.h"
#import "UINavigationBar+FJY.h"


#define NAVBAR_CHANGE_POINT 50

@interface ContestTableViewController ()

@property (nonatomic, strong) NSMutableArray *contests;  //存放 FJYcontest对象


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
    
    UIColor * color = [UIColor customBlueColor];
    [self.navigationController.navigationBar fjy_setBackgroundColor:color];
    
    //设置row的高度为自定义cell的高度
    self.tableView.rowHeight = 80;
    
    //下载刷新数据
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self downData];
    }];
    
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
}


- (NSString *) changeName:(NSString *) oj
{
    NSString *str = oj;
    if([str  isEqual: @"Codeforces"]) str = @"CF";
    if([str  isEqual: @"BestCoder"]) str = @"BC";
    if([str  isEqual: @"Codechef"]) str = @"CC";
    if([str  isEqual: @"ACdream"]) str = @"AC";
    if([str  isEqual: @"Topcoder"]) str = @"TC";
    
    return str;
}

#pragma mark - 下载刷新数据


- (void)downData
{
    //url链接
    static NSString *URLStr = @"http://contests.acmicpc.info/contests.json";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URLStr parameters:nil success:^(AFHTTPRequestOperation *  operation, id  responseObject) {
        NSArray *contestArray = responseObject;
        for (NSDictionary *contestDict in contestArray) {
             ContestModel   *contest = [ContestModel contestWithDict:contestDict];
            [self.contests addObject:contest];
        }
        // 刷新表格
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        
        
    } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
        
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUD.labelText = @"网络出现了点故障...";
        [HUD showAnimated:YES whileExecutingBlock:^{
            sleep(1.5);
        } completionBlock:^{
            [self.tableView.mj_header endRefreshing];
        }];
        
        
        
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
    static NSString *CellIdentifier = @"contest";
    ContestCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ContestCell" owner:self options:nil]lastObject];
    }
    
    ContestModel *contest = self.contests[indexPath.row];
    
    cell.oj.text = [self changeName:contest.oj];
    cell.oj.adjustsFontSizeToFitWidth = YES;
    cell.name.text = contest.name;
    cell.time.text = contest.start_time;
    cell.week.text = contest.week;
    
    return cell;
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    FJYContestDetailController *detailVC = [[FJYContestDetailController alloc]init];
//    [self.navigationController pushViewController:detailVC animated:YES];
//    
//    detailVC.currentContest = self.contests[indexPath.row];
}
@end
