
//
//  HJSportDetailAPI.m
//  Enjoy
//
//  Created by IMAC on 16/4/28.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJSportDetailAPI.h"

@implementation HJSportDetailAPI
+ (instancetype)getSportDetailWithSportName:(NSString *)sportName sportCategoryId:(NSNumber *)sportCategoryId pageNo:(NSNumber *)pageNo pageSize:(NSNumber *)pageSize Id:(NSNumber *)Id
{
    HJSportDetailAPI *api = [self new];
    if (sportName) {
        [api.parameters setObject:sportName forKey:@"sportName"];
    }
    [api.parameters setObject:sportCategoryId forKey:@"sportCategoryId"];
    if (Id) {
        [api.parameters setObject:Id forKey:@"id"];
    }
    [api.parameters setObject:pageNo forKey:@"page"];
    [api.parameters setObject:pageSize forKey:@"rows"];
    api.subUrl = API_SPORT_LIST;
    
    return api;
}


@end
@implementation HJSportDetailModel


@end
@implementation SportModel

+(NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"Id":@"id"};
}

@end