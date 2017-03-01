//
//  HJFoodListAPI.h
//  Enjoy
//
//  Created by IMAC on 16/4/25.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"
@class HJFoodListModel;
@interface HJFoodListAPI : HJBaseAPI
@property (nonatomic, strong) HJFoodListModel *data;
+(instancetype)getFoodListWithfoodName:(NSString *)foodName foodCategoryId:(NSNumber *)foodCategoryId page:(NSNumber *)page rows:(NSNumber *)rows;
@end
@interface HJFoodListModel : HJBaseModel
@property (nonatomic, strong) NSArray *foodList;
@end
@interface HJFoodModel : HJBaseModel

@property (nonatomic, assign) NSInteger calory;

@property (nonatomic, assign) NSInteger weight;

@property (nonatomic, copy) NSString *remark;

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, assign) NSInteger foodCategoryId;

@property (nonatomic, copy) NSString *ico;

@property (nonatomic, copy) NSString *foodCaloryList;

@property (nonatomic, copy) NSString *foodNutritionList;

@property (nonatomic, copy) NSString *name;

@end