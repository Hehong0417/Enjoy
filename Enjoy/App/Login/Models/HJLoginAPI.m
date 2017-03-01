//
//  HJLoginAPI.m
//  Cancer
//
//  Created by IMAC on 16/2/17.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import "HJLoginAPI.h"

@implementation HJLoginAPI
+ (instancetype)loginWithAccount:(NSString *)account loginType:(NSNumber *)loginType password:(NSString *)password
{
    HJLoginAPI *api = [self new];
    [api.parameters setObject:account forKey:@"account"];
    [api.parameters setObject:loginType forKey:@"loginType"];
    if (password) {
    [api.parameters setObject:password forKey:@"password"];  
    }

    api.parametersAddToken = NO;
    api.subUrl = API_LOGIN;
    return api;
}
@end

