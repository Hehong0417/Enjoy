//
//  HJFoodDetailOneCell.h
//  Enjoy
//
//  Created by IMAC on 16/4/26.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HJFoodDetailModel;
@interface HJFoodDetailOneCell : UITableViewCell
@property (nonatomic, strong) HJFoodDetailModel *foodDetailModel;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
