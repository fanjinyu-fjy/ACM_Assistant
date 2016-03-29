//
//  ContestDetailController.m
//  ACM_Assistant
//
//  Created by 幻月瑶琴 on 16/3/28.
//  Copyright © 2016年 幻月瑶琴. All rights reserved.
//

#import "ContestDetailController.h"
#import "ContestModel.h"

#import <SafariServices/SafariServices.h>

@interface ContestDetailController()<SFSafariViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *contestName;
@property (weak, nonatomic) IBOutlet UIButton *openSafari;

@end

@implementation ContestDetailController

- (void)viewDidLoad{
    
    [self setupVC];
}

- (void)setupVC{
    
    self.title = self.contestModel.oj;
    self.contestName.text = self.contestModel.name;
}

- (IBAction)openSafari:(UIButton *)sender {
    SFSafariViewController *VC = [[SFSafariViewController alloc]initWithURL:[NSURL URLWithString:self.contestModel.link ]];
    
    [self.navigationController presentViewController:VC animated:YES completion:nil];
    
    
}


#pragma mark - SFSafariViewControllerDelegate

- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller{

    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
