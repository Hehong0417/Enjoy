//
//  MovementListCell.h
//  Enjoy
//
//  Created by IMAC on 16/3/21.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJSportCategoryListAPI.h"
#import "HJFoodCategoryListAPI.h"

@interface MovementListCell : UITableViewCell

+ (instancetype)initWithMovementListCellXib;

@property (nonatomic, strong) HJSportCategoryModel *SportCategoryModel;
@property (strong, nonatomic) IBOutlet UIImageView *icoImg;
@property (strong, nonatomic) IBOutlet UILabel *nameLab;

@property (nonatomic, strong) HJfoodCategoryModel *foodCategoryModel;

@end
