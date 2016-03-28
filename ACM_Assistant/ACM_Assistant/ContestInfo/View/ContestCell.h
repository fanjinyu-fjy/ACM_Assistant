//
//  FJYContestTableViewCell.h
//  ACM_Assistant
//
//  Created by 幻月瑶琴 on 15/12/5.
//  Copyright © 2015年 幻月瑶琴. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContestCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *oj;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *week;
@end
