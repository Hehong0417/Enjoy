//
//  HJfamilyUserCell.h
//  Enjoy
//
//  Created by IMAC on 16/2/26.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HJFamilyUserModel;
@interface HJfamilyUserCell : UITableViewCell
@property (nonatomic, strong) HJFamilyUserModel *model;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
