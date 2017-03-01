//
//  HJFoodDetailAPI.h
//  Enjoy
//
//  Created by IMAC on 16/4/26.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@class HJFoodDetailModel;
@interface HJFoodDetailAPI : HJBaseAPI
@property (nonatomic, strong) HJFoodDetailModel *data;

+(instancetype)getFoodDetailWithfoodId:(NSNumber *)foodId;
@end
//
@interface HJFoodDetailModel : HJBaseModel

@property (nonatomic, assign) NSInteger calory;

@property (nonatomic, assign) NSInteger weight;

@property (nonatomic, copy) NSString *remark;

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, assign) NSInteger foodCategoryId;

@property (nonatomic, copy) NSString *ico;

@property (nonatomic, strong) NSArray *foodCaloryList;

@property (nonatomic, strong) NSArray *foodNutritionList;

@property (nonatomic, copy) NSString *name;

@end
//
@interface HJFoodCaloryListModel : HJBaseModel

@property (nonatomic, copy) NSString *standard;

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, assign) NSInteger calory;

@property (nonatomic, assign) NSInteger weight;

@property (nonatomic, assign) NSInteger foodId;

@end
//
@interface HJFoodNutritionListModel : HJBaseModel

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, copy) NSString *contain;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger foodId;

@property (nonatomic, copy) NSString *remark;

@end
