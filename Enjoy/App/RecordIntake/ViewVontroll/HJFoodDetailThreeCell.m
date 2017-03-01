//
//  HJFoodDetailThreeCell.m
//  Enjoy
//
//  Created by IMAC on 16/4/26.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJFoodDetailThreeCell.h"

@implementation HJFoodDetailThreeCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
/**
 *  食物详情
 */
- (void)setFoodDetailModel:(HJFoodDetailModel *)foodDetailModel {
    _foodDetailModel = foodDetailModel;
    self.remarkLab.text = foodDetailModel.remark;
    
}
/**
 *  运动详情
 */
- (void)setSportModel:(SportModel *)sportModel {
    
    _sportModel = sportModel;
    self.remarkLab.text = sportModel.remark;

}
@end
