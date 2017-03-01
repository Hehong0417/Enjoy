//
//  HJGetCaptchaAPI.m
//  Cancer
//
//  Created by IMAC on 16/2/17.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import "HJGetCaptchaAPI.h"

@implementation HJGetCaptchaAPI
+(instancetype)getCaptchaWith:(NSString *)phone
{
    HJGetCaptchaAPI *api = [self new];
    [api.parameters setObject:phone forKey:@"telephone"];
    api.subUrl = API_GET_SHORT_MSG_CODE;
    return api;
}
@end
@implementation HJMsgCodeModel


@end