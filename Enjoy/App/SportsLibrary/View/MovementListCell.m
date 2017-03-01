//
//  MovementListCell.m
//  Enjoy
//
//  Created by IMAC on 16/3/21.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "MovementListCell.h"

@implementation MovementListCell

- (void)awakeFromNib {
    // Initialization code
}

+ (instancetype)initWithMovementListCellXib{
    return [[[NSBundle mainBundle] loadNibNamed:@"MovementListCell" owner:nil options:nil] lastObject];
}
- (void)setSportCategoryModel:(HJSportCategoryModel *)SportCategoryModel {
    
    _SportCategoryModel = SportCategoryModel;
    
    [self.icoImg sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(SportCategoryModel.ico)]placeholderImage:kImageNamed(@"placeholderImage")];
    self.nameLab.text = SportCategoryModel.name;
}


- (void)setFoodCategoryModel:(HJfoodCategoryModel *)foodCategoryModel {
    
    _foodCategoryModel = foodCategoryModel;
    
    [self.icoImg sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(foodCategoryModel.ico)]placeholderImage:kImageNamed(@"placeholderImage")];
    self.nameLab.text = foodCategoryModel.name;
    
}
@end
