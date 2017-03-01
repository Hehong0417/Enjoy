//
//  HJMyOrderCell.h
//  Enjoy
//
//  Created by IMAC on 16/2/26.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HJMyOrderListModel;
@class HJMyOrderDetailModel;
@interface HJMyOrderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *orderCode;
@property (weak, nonatomic) IBOutlet UILabel *orderState;
@property (nonatomic, strong) HJMyOrderDetailModel *detailModel;
@property (nonatomic, strong) NSDictionary *data;
+ (HJMyOrderCell *)myOrderCellWithTableView:(UITableView *)tableView;

@end
