//
//  HJCheckPhoneAPI.m
//  Cancer
//
//  Created by IMAC on 16/2/17.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import "HJCheckPhoneAPI.h"

@implementation HJCheckPhoneAPI
+(instancetype)checkPhoneWith:(NSString *)telephone
{
    HJCheckPhoneAPI *api = [self new];
    [api.parameters setObject:telephone forKey:@"telephone"];
    api.subUrl = API_CHECK_PHONE;
    return api;
}
- (void)mbShowText:(NSString *)text {
    
    
}
@end
