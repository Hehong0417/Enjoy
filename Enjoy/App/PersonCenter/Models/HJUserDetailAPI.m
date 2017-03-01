//
//  HJUserDetailAPI.m
//  Enjoy
//
//  Created by 邓朝文 on 16/4/25.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJUserDetailAPI.h"

@implementation HJUserDetailAPI
+ (instancetype)getUserDetail
{
    HJUserDetailAPI *api = [HJUserDetailAPI new];
    api.parametersAddToken = YES;
    api.subUrl = API_USER_DETAIL;
    return api;
}

@end

@implementation HJUserDetailModel
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property
{

    if (oldValue == nil || [oldValue isKindOfClass:[NSNull class]]) {
        
        return @"";
    }
    return oldValue;
}
@end
