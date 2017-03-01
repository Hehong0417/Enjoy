//
//  HJfirstLoginAPI.m
//  Cancer
//
//  Created by IMAC on 16/2/18.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import "HJfirstLoginAPI.h"

@implementation HJfirstLoginAPI
+(instancetype)firstLoginWithUserType:(NSString *)userType diseaseID:(NSString *)diseaseID remedy:(NSString *)remedy
{
    HJfirstLoginAPI *api = [self new];
    [api.parameters setObject:USER_ID forKey:@"userId"];
    [api.parameters setObject:USER_TOKEN forKey:@"token"];
    [api.parameters setObject:userType forKey:@"userType"];
    [api.parameters setObject:diseaseID forKey:@"diseaseID"];
    [api.parameters setObject:remedy forKey:@"remedy"];
   // api.subUrl = API_FIRST_LOGIN;
    return api;
}
@end
