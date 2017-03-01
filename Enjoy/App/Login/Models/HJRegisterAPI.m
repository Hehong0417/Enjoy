//
//  HJRegisterAPI.m
//  Cancer
//
//  Created by IMAC on 16/2/17.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import "HJRegisterAPI.h"

@implementation HJRegisterAPI
+ (instancetype)registerWithPhone:(NSString *)telephone captcha:(NSString *)shortMsgCode pwd:(NSString *)password qqAccount:(NSString *)qqAccount qqNick:(NSString *)qqNick wxAccount:(NSString *)wxAccount wxNick:(NSString *)wxNick icon:(NSString *)icon
{
    HJRegisterAPI *api = [self new];
    [api.parameters setObject:telephone forKey:@"telephone"];
    [api.parameters setObject:shortMsgCode forKey:@"shortMsgCode"];
    if (icon) {
        [api.parameters setObject:icon forKey:@"icon"];
    }
    if (password) {
        [api.parameters setObject:password forKey:@"password"];
    }
    if (qqAccount) {
        [api.parameters setObject:qqAccount forKey:@"qqAccount"];
    }
    if (qqNick) {
        [api.parameters setObject:qqNick forKey:@"qqNick"];
    }
    if (wxAccount) {
        [api.parameters setObject:wxAccount forKey:@"wxAccount"];
    }
    if (wxNick) {
        [api.parameters setObject:wxNick forKey:@"wxNick"];
    }
    api.subUrl = API_REGIST;
    return api;

}
@end
@implementation RegisterModel


@end