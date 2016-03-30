//
//  ContestDetailController.m
//  ACM_Assistant
//
//  Created by 幻月瑶琴 on 16/3/28.
//  Copyright © 2016年 幻月瑶琴. All rights reserved.
//

#import "ContestDetailController.h"
#import "ContestModel.h"

#import "UIButton+FJY.h"
#import "UIView+FJY.h"

#import <UMSocial.h>
#import <UMSocialData.h>
#import <SafariServices/SafariServices.h>

#import "UINavigationBar+FJY.h"
@interface ContestDetailController()<SFSafariViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *contestName;
@property (weak, nonatomic) IBOutlet UIButton *openSafari;
@property (weak, nonatomic) IBOutlet UIView *NameView;

@end

@implementation ContestDetailController

- (void)viewDidLoad{
    
   self.title = self.contestModel.oj;
    [self setupVC];
    
    
}


- (void)setupVC{
    
    [self.openSafari setButtonAnimation];
    self.title = self.contestModel.oj;
    
    self.contestName.text = self.contestModel.name;
    
    UIButton *shareButton = [[UIButton alloc]init];
    [shareButton setImage:[UIImage imageNamed:@"icon_more"]
                 forState:UIControlStateNormal];
    [shareButton sizeToFit];
    [shareButton addTarget:self
                    action:@selector(socialShare)
          forControlEvents:UIControlEventTouchUpInside];
    [shareButton setButtonAnimation];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:shareButton];
}


/** 分享 */
- (void)socialShare{
    ContestModel *contest = self.contestModel;
    
    // 设置跳转链接
    [UMSocialData defaultData].extConfig.wechatSessionData.url = contest.link;
    [UMSocialData defaultData].extConfig.wechatSessionData.title = [NSString stringWithFormat:@"%@:%@",contest.oj, contest.name];
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = contest.link;
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = [NSString stringWithFormat:@"%@\n%@\n%@",contest.oj,contest.name, contest.start_time];
    
    [UMSocialData defaultData].extConfig.qqData.url = contest.link;
    [UMSocialData defaultData].extConfig.qqData.title = contest.oj;
    [UMSocialData defaultData].extConfig.qzoneData.url = contest.link;
    [UMSocialData defaultData].extConfig.qzoneData.title = contest.oj;
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"56fa2d8de0f55a3b6900338b"
                                      shareText:[NSString stringWithFormat:@"%@ \n%@",contest.name, contest.start_time]
                                     shareImage:[UIImage imageNamed:@"shareIcon"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToQQ,UMShareToWechatTimeline,UMShareToQzone, nil] delegate:nil];
}



/** 打开SFSafariViewController */
- (IBAction)openSafari:(UIButton *)sender {
    SFSafariViewController *VC = [[SFSafariViewController alloc]initWithURL:[NSURL URLWithString:self.contestModel.link ]];
    
    [self.navigationController presentViewController:VC animated:YES completion:nil];
    
}



#pragma mark - SFSafariViewControllerDelegate

- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller{

    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
