//
//  HJFindPasswordAPI.m
//  Enjoy
//
//  Created by IMAC on 16/4/23.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJFindPasswordAPI.h"

@implementation HJFindPasswordAPI
+(instancetype)findPassword:(NSString *)telephone shortMsgCode:(NSString *)shortMsgCode newPwd:(NSString *)newPwd {
    HJFindPasswordAPI *api = [self new];
    [api.parameters setObject:telephone forKey:@"telephone"];
    [api.parameters setObject:shortMsgCode forKey:@"shortMsgCode"];
    [api.parameters setObject:newPwd forKey:@"newPwd"];
    api.subUrl = API_FING_PASSWORD;
    return api;
}
@end
