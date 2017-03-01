//
//  HJMessageCell.h
//  Enjoy
//
//  Created by IMAC on 16/2/27.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJMyMessageAPI.h"

@interface HJMessageCell : UITableViewCell
@property (nonatomic, strong) HJMessageListlModel *model;
+ (HJMessageCell *)cellWithTableView:(UITableView *)tableView;
@end
