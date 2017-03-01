
//
//  HJsportCategoryListAPI.m
//  Enjoy
//
//  Created by IMAC on 16/4/26.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJSportCategoryListAPI.h"

@implementation HJSportCategoryListAPI
+(instancetype)getSportCategoryList{
    HJSportCategoryListAPI  *api = [self new];
    api.subUrl = API_SPORT_CATEGORY_LIST;
    return api;
}
@end
@implementation HJSportCategoryListModel

+(NSDictionary *)mj_objectClassInArray {
    
    return @{@"sportCategoryList":[HJSportCategoryModel class]};
}
@end
@implementation HJSportCategoryModel

+(NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"Id":@"id"};
}
@end