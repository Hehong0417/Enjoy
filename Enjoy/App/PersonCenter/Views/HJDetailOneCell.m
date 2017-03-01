//
//  HJDetailOneCell.m
//  Enjoy
//
//  Created by IMAC on 16/2/26.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import "HJDetailOneCell.h"
#import "HJMyOrderDetailAPI.h"

@interface HJDetailOneCell ()
@property (weak, nonatomic) IBOutlet UILabel *packCode;
@property (weak, nonatomic) IBOutlet UILabel *express;
@property (weak, nonatomic) IBOutlet UILabel *price;

@end

@implementation HJDetailOneCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setMyOrderDetailModel:(HJMyOrderDetailModel *)myOrderDetailModel
{
    _myOrderDetailModel = myOrderDetailModel;
    self.packCode.text = [NSString stringWithFormat:@"订单号: %@", myOrderDetailModel.packCode];
    self.express.text = [NSString stringWithFormat:@"快递公司: %@", myOrderDetailModel.express];
    self.price.text = [NSString stringWithFormat:@"订单总额: %@", myOrderDetailModel.price];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
