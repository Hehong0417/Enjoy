//
//  HJCheckNewOrderAPI.m
//  Enjoy
//
//  Created by IMAC on 16/5/12.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJCheckNewOrderAPI.h"

@implementation HJCheckNewOrderAPI
+(instancetype)checknewOrderWithPhone:(NSString *)phone {
    
    HJCheckNewOrderAPI *api = [HJCheckNewOrderAPI new];
    [api.parameters setObject:phone forKey:@"phone"];
    api.subUrl = @"http://58.248.16.52:37771/WebService/CheckNewOrderByPhone.ashx";
    return api;
    
}

@end
@implementation HJCheckModel


@end