
//
//  HJFoodDetailAPI.m
//  Enjoy
//
//  Created by IMAC on 16/4/26.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJFoodDetailAPI.h"

@implementation HJFoodDetailAPI
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"data" : [HJFoodDetailModel class]};
}
+(instancetype)getFoodDetailWithfoodId:(NSNumber *)foodId {
    HJFoodDetailAPI *api = [self new];
    [api.parameters setObject:foodId forKey:@"foodId"];
    api.subUrl = API_FOOD_DETAIL;
    return api;
}
@end

@implementation HJFoodDetailModel
+(NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"Id":@"id"};
}
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"foodCaloryList" : [HJFoodCaloryListModel class], @"foodNutritionList" : [HJFoodNutritionListModel class]};
}

@end

@implementation HJFoodCaloryListModel
+(NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"Id":@"id"};
}
@end

@implementation HJFoodNutritionListModel

+(NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"Id":@"id"};
}
@end
