//
//  HJFoodCell.h
//  Enjoy
//
//  Created by 邓朝文 on 16/4/27.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HJFoodCell;
@protocol HJFoodCellDelegate <NSObject>
- (void)foodCellClickRecordButton:(HJFoodCell *)cell;
- (void)sportCellClickRecordButton:(HJFoodCell *)cell;
@end

@class HJFoodModel;
@class HJSportModel;

@interface HJFoodCell : UITableViewCell
+ (HJFoodCell *)CellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) HJFoodModel *foodModel;
@property (nonatomic, strong) HJSportModel *sportModel;
@property (nonatomic, weak) id<HJFoodCellDelegate> delegate;

@end
