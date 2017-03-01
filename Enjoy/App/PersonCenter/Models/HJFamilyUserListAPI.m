//
//  HJFamilyUserListAPI.m
//  Enjoy
//
//  Created by 邓朝文 on 16/4/23.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJFamilyUserListAPI.h"

@implementation HJFamilyUserListAPI
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"data":[HJFamilyUserListModel class]};
}

+ (instancetype)getFamilyUserListWithPage:(NSNumber *)page rows:(NSNumber *)rows
{
    HJFamilyUserListAPI *api = [self new];
    [api.parameters setObject:page forKey:@"page"];
    [api.parameters setObject:rows forKey:@"rows"];
    api.subUrl = API_FAMILY_USER_LIST;
    return api;
}
@end

@implementation HJFamilyUserListModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"familyUserList":[HJFamilyUserModel class]};
}
@end

@implementation HJFamilyUserModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"Id" : @"id"};
}
@end
