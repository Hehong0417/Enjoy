//
//  HJFoodDetailTwoCell.h
//  Enjoy
//
//  Created by IMAC on 16/4/26.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJFoodDetailAPI.h"

@interface HJFoodDetailTwoCell : UITableViewCell
@property (nonatomic, strong) HJFoodDetailModel *foodDetailModel;
@property (nonatomic, assign) NSInteger section;
+ (instancetype)cellWithTableView:(UITableView *)tableView;


@end
