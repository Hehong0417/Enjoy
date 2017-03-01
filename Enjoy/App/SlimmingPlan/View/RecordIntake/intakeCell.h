//
//  intakeCell.h
//  Enjoy
//
//  Created by IMAC on 16/3/15.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJThinPlanHomeAPI.h"

typedef void(^deleteBlock2)(NSInteger section,NSInteger row);

@protocol intakeCellDelegate <NSObject>
-(void)intakeCellPush;
@end

@class intakeFrame;

@interface intakeCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) intakeFrame *statusFrame;

@property(nonatomic,weak)id<intakeCellDelegate>delegate;
@property (nonatomic, strong) HJThinPlanHomeModel *thinPlanHomeModel;
@property (nonatomic, copy) deleteBlock2 deleteBlock;
@end
