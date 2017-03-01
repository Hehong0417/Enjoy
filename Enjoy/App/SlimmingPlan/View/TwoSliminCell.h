//
//  TwoSliminCell.h
//  Enjoy
//
//  Created by IMAC on 16/3/14.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJThinPlanHomeAPI.h"


@protocol HJTwoSliminCellDelegate <NSObject>
- (void)addWeightSuccess;
@end

@interface TwoSliminCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *fatSaid;
@property (strong, nonatomic) IBOutlet UILabel *weightLab;
@property (weak, nonatomic) IBOutlet UIButton *recordWeight;
@property (nonatomic, weak) id<HJTwoSliminCellDelegate> delegate;
+ (instancetype)initWithTwoSliminCellXib;
@property (nonatomic, strong) HJThinPlanHomeModel *thinPlanHomeModel;
@property (nonatomic, copy) voidBlock fatBlock;
@end
