
//
//  HJCheckShortMsgCodeAPI.m
//  Enjoy
//
//  Created by IMAC on 16/5/4.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJCheckShortMsgCodeAPI.h"

@implementation HJCheckShortMsgCodeAPI
+(instancetype)checkShortMsgCodeWithtelephone:(NSString *)telephone shortMsgCode:(NSString *)shortMsgCode {
    
    HJCheckShortMsgCodeAPI *api = [self new];
    
    [api.parameters setObject:telephone forKey:@"telephone"];
    [api.parameters setObject:shortMsgCode forKey:@"shortMsgCode"];

    api.subUrl = API_CHECK_SHORT_CODE;
    
    return api;
}
@end
