//
//  HJfoodCategoryListAPI.m
//  Enjoy
//
//  Created by IMAC on 16/4/25.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJFoodCategoryListAPI.h"

@implementation HJFoodCategoryListAPI
+(instancetype)getfoodCategoryList {
    HJFoodCategoryListAPI *api = [self new];
    api.subUrl = API_FOOD_CATEGORY_LIST;
    return api;
}
@end
@implementation HJFoodCategoryListModel
+(NSDictionary *)mj_objectClassInArray {
    
    return @{@"foodCategoryList":[HJfoodCategoryModel class]};
}

@end
@implementation HJfoodCategoryModel
+(NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"Id":@"id"};
}
@end