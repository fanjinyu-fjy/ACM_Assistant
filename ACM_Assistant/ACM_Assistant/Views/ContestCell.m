//
//  FJYContestTableViewCell.m
//  ACM_Assistant
//
//  Created by 幻月瑶琴 on 15/12/5.
//  Copyright © 2015年 幻月瑶琴. All rights reserved.
//

#import "ContestCell.h"
#import "ContestModel.h"
#import <pop/POP.h>
static CGFloat CellMargin = 1.0f;
@implementation ContestCell



- (void)setContestModel:(ContestModel *)contestModel{
    _contestModel = contestModel;
    
    self.oj.text = contestModel.oj;
    self.name.text = contestModel.name;
    self.time.text = contestModel.start_time;
    self.week.text = contestModel.week;
    self.imageStar.highlighted = _contestModel.star;
    FJYLog(@"%@", contestModel);
    
}

- (void)setFrame:(CGRect)frame{
    frame.origin.y += CellMargin;
    frame.size.height -= CellMargin;
    
    //一定要调用父类
    [super setFrame:frame];
}

//- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
//    [super setHighlighted:highlighted animated:animated];
//    if (highlighted) {
//        POPBasicAnimation *cellBasicAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
//        cellBasicAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(0.99, 0.99)];
//        [self.layer pop_addAnimation:cellBasicAnimation forKey:@"cellBasicAnimation"];
//    } else {
//        POPSpringAnimation *cellSpringAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
//        cellSpringAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.0, 1.0)];
//        cellSpringAnimation.springBounciness = 10.0;
////        cellSpringAnimation.velocity = [NSValue valueWithCGSize:CGSizeMake(3.0, 3.0)];
//        [self.layer pop_addAnimation:cellSpringAnimation forKey:@"cellSpringAnimation"];
//    }
//}
@end
