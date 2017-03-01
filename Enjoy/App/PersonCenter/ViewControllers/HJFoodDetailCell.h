//
//  HJFoodDetailCell.h
//  Enjoy
//
//  Created by 邓朝文 on 16/5/4.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HJFoodCaloryListModel;
@class HJFoodNutritionListModel;
@interface HJFoodDetailCell : UITableViewCell
+ (HJFoodDetailCell *)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) HJFoodCaloryListModel *foodCaloryModel;
@property (nonatomic, strong) HJFoodNutritionListModel *foodNutritionModel;
@end
