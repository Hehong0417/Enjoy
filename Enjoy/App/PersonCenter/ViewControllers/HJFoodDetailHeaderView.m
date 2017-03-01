//
//  HJFoodDetailHeaderView.m
//  Enjoy
//
//  Created by 邓朝文 on 16/5/4.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJFoodDetailHeaderView.h"
#import "HJFoodDetailAPI.h"
#import "HJSportDetailAPI.h"

@interface HJFoodDetailHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *heatLabel;

@end
@implementation HJFoodDetailHeaderView

+ (HJFoodDetailHeaderView *)foodDetailHeaderView
{
    HJFoodDetailHeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"HJFoodDetailHeaderView" owner:nil options:nil] firstObject];
    return headerView;
}

- (void)setFoodmodel:(HJFoodDetailModel *)foodmodel
{
    _foodmodel = foodmodel;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(foodmodel.ico)] placeholderImage:kImageNamed(@"")];
    self.nameLabel.text = foodmodel.name;
    self.heatLabel.text = [NSString stringWithFormat:@"热量评估：%d大卡/100克", foodmodel.calory];
}

- (void)setSportModel:(SportModel *)sportModel
{
    _sportModel = sportModel;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(sportModel.ico)] placeholderImage:kImageNamed(@"")];
    self.nameLabel.text = sportModel.name;
    self.heatLabel.text = [NSString stringWithFormat:@"可消耗：%d大卡/小时", sportModel.calory];
}

@end
