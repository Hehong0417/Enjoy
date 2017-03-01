//
//  HJSurverAPI.m
//  Enjoy
//
//  Created by IMAC on 16/4/29.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJSurverAPI.h"

@implementation HJSurverAPI

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"data" : [HJSurverModel class]};
}

+(instancetype)getSurverListpage:(NSNumber *)page rows:(NSNumber *)rows
{
    HJSurverAPI *api = [self new];
    [api.parameters setObject:page forKey:@"page"];
    [api.parameters setObject:rows forKey:@"rows"];
    api.subUrl = API_HEALTH_LIST;
    return api;
}
@end

@implementation HJSurverModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"healthList" : [HJSurverInfoModel class]};
}
@end

@implementation HJSurverInfoModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"Id" : @"id"};
}
@end
