//
//  HJFoodDetailCell.m
//  Enjoy
//
//  Created by 邓朝文 on 16/5/4.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJFoodDetailCell.h"
#import "HJFoodDetailAPI.h"

@interface HJFoodDetailCell ()

@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *centerLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;


@end
@implementation HJFoodDetailCell

- (void)awakeFromNib {
    // Initialization code
}


+ (HJFoodDetailCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"foodDetailCell";
    HJFoodDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HJFoodDetailCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)setFoodCaloryModel:(HJFoodCaloryListModel *)foodCaloryModel
{
    _foodCaloryModel = foodCaloryModel;
    self.leftLabel.text = foodCaloryModel.standard;
    self.centerLabel.text = [NSString stringWithFormat:@"%d克", foodCaloryModel.weight];
    self.rightLabel.text = [NSString stringWithFormat:@"%d大卡", foodCaloryModel.calory];
}

- (void)setFoodNutritionModel:(HJFoodNutritionListModel *)foodNutritionModel
{
    _foodNutritionModel = foodNutritionModel;
    self.leftLabel.text = foodNutritionModel.name;
    self.centerLabel.text = foodNutritionModel.contain;
    self.rightLabel.text = foodNutritionModel.remark;
}

@end
