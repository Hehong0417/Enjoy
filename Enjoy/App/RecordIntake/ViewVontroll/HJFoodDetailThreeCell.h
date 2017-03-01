//
//  HJFoodDetailThreeCell.h
//  Enjoy
//
//  Created by IMAC on 16/4/26.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJFoodDetailAPI.h"
#import "HJSportDetailAPI.h"

@interface HJFoodDetailThreeCell : UITableViewCell
@property (nonatomic, strong) SportModel *sportModel;
@property (nonatomic, strong) HJFoodDetailModel *foodDetailModel;
@property (strong, nonatomic) IBOutlet UITextView *remarkLab;

@end
