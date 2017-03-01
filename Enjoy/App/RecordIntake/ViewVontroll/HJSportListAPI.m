//
//  HJSportListAPI.m
//  Enjoy
//
//  Created by IMAC on 16/4/26.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJSportListAPI.h"

@implementation HJSportListAPI
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"data" : [HJSportListModel class]};
}

+(instancetype)getSportListWithSportName:(NSString *)sportName sportCategoryId:(NSNumber *)sportCategoryId page:(NSNumber *)page rows:(NSNumber *)rows
{
    HJSportListAPI *api = [self new];
    if (sportName) {
        [api.parameters setObject:sportName forKey:@"sportName"];
    }
    [api.parameters setObject:sportCategoryId forKey:@"sportCategoryId"];
    [api.parameters setObject:page forKey:@"pageNo"];
    [api.parameters setObject:rows forKey:@"pageSize"];
    api.subUrl = API_SPORT_LIST;
    return api;
}
@end

@implementation HJSportListModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"sportList" : [HJSportModel class]};
}
@end

@implementation HJSportModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"Id" : @"id"};
}
@end
