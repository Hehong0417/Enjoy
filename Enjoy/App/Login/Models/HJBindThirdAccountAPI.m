
//
//  HJBindThirdAccountAPI.m
//  Enjoy
//
//  Created by IMAC on 16/5/4.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBindThirdAccountAPI.h"

@implementation HJBindThirdAccountAPI
+(instancetype)bindThirdAccountWithtelephone:(NSString *)telephone account:(NSString *)account  thirdNickName:(NSString *)thirdNickName type:(NSNumber *)type icon:(NSString *)icon{
    
    HJBindThirdAccountAPI *api = [self new];
    
    [api.parameters setObject:telephone forKey:@"telephone"];
    [api.parameters setObject:account forKey:@"account"];
    [api.parameters setObject:thirdNickName forKey:@"thirdNickName"];
    [api.parameters setObject:type forKey:@"type"];
    [api.parameters setObject:icon forKey:@"icon"];

    api.subUrl = API_BIND_THIRD_ACCOUNT;
    
    return api;
}
@end
@implementation HJBindModel


@end
