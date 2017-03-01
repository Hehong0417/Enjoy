//
//  HJMyOrderCell.m
//  Enjoy
//
//  Created by IMAC on 16/2/26.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import "HJMyOrderCell.h"
#import "HJMyOrderListAPI.h"
#import "HJMyOrderDetailAPI.h"

@interface HJMyOrderCell ()


@end

@implementation HJMyOrderCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setData:(NSDictionary *)data {
    _data = data;
    self.title.text = data[@"goodsName"];
    self.orderCode.text = [NSString stringWithFormat:@"订单号: %@", data[@"orderNo"]];
    self.orderState.text = data[@"orderState"];
    
}

+ (HJMyOrderCell *)myOrderCellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"order";
    HJMyOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HJMyOrderCell" owner:self options:nil] firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



- (void)setDetailModel:(HJMyOrderDetailModel *)detailModel{
    _detailModel = detailModel;
    self.title.text = detailModel.title;
    switch (detailModel.orderState) {
        case 0:
            self.orderState.text = @"未支付";
            break;
        case 1:
            self.orderState.text = @"已支付";
        default:
            break;
    }
    self.orderCode.text = detailModel.orderCode;
}

@end
