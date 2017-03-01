//
//  HJAuitFoodListAPI.h
//  Enjoy
//
//  Created by IMAC on 16/4/25.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"
@class HJSuitFoodListModel;
@interface HJSuitFoodListAPI : HJBaseAPI
@property (nonatomic, strong) HJSuitFoodListModel *data;
+(instancetype)getSuitFoodListWithEatType:(NSNumber *)eatType;
@end
@interface HJSuitFoodListModel : HJBaseModel

@property (nonatomic, copy) NSString *calory;

@property (nonatomic, strong) NSArray *foodList;

@property (nonatomic, assign) NSInteger suitId;

@property (nonatomic, assign) NSString *eatState;



@end
@interface HJSuitModel : HJBaseModel

@property (nonatomic, assign) NSInteger calory;

@property (nonatomic, assign) NSInteger weight;

@property (nonatomic, copy) NSString *remark;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger foodCategoryId;

@property (nonatomic, copy) NSString *ico;

@property (nonatomic, copy) NSString *foodCaloryList;

@property (nonatomic, copy) NSString *foodNutritionList;

@property (nonatomic, copy) NSString *name;

@end