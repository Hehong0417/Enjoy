//
//  HJFamilyUserDetailAPI.m
//  Enjoy
//
//  Created by 邓朝文 on 16/4/23.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJFamilyUserDetailAPI.h"

@implementation HJFamilyUserDetailAPI
+ (instancetype)getFamilyUserDetailWithFamilyUserId:(NSNumber *)familyUserId
{
    HJFamilyUserDetailAPI *api = [self new];
    [api.parameters setObject:familyUserId forKey:@"familyUserId"];
    api.subUrl = API_FAMILY_USER_DETAIL;
    return api;
}
@end

@implementation HJFamilyUserDetailModel


@end
