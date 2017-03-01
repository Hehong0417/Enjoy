//
//  HJFoodListAPI.m
//  Enjoy
//
//  Created by IMAC on 16/4/25.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJFoodListAPI.h"

@implementation HJFoodListAPI
+(instancetype)getFoodListWithfoodName:(NSString *)foodName foodCategoryId:(NSNumber *)foodCategoryId page:(NSNumber *)page rows:(NSNumber *)rows {
    
    HJFoodListAPI *api = [self new];
    if (foodName) {
        [api.parameters setObject:foodName forKey:@"foodName"];
    }
    [api.parameters setObject:foodCategoryId forKey:@"foodCategoryId"];
    [api.parameters setObject:page forKey:@"page"];
    [api.parameters setObject:rows forKey:@"rows"];
    api.subUrl = API_FOOD_LIST;
    
    return api;
}
@end
@implementation HJFoodListModel
+(NSDictionary *)mj_objectClassInArray {
    
    return @{@"foodList":[HJFoodModel class]};
}

@end
@implementation HJFoodModel

+(NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"Id":@"id"};
}

@end