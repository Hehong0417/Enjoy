//
//  HJFoodsThreeSmallCell.h
//  Enjoy
//
//  Created by IMAC on 16/5/3.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJFoodDetailAPI.h"

@interface HJFoodsThreeSmallCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *oneLab;
@property (strong, nonatomic) IBOutlet UILabel *twoLab;
@property (strong, nonatomic) IBOutlet UILabel *threeLab;
@property (nonatomic, strong) HJFoodDetailModel *foodDetailModel;
@end
