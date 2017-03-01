//
//  HJMyOrderListAPI.m
//  Enjoy
//
//  Created by 邓朝文 on 16/4/23.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJMyOrderListAPI.h"

@implementation HJMyOrderListAPI

+(NSDictionary *)mj_objectClassInArray {
    
    return @{@"data":[HJMyOrderListModel class]};
}

+ (instancetype)getMyOrderListWithPage:(NSNumber *)pageNo phone:(NSString *)phone rows:(NSNumber *)pageSize
{
    HJMyOrderListAPI *api = [self new];
    api.parametersAddToken = NO;
    [api.parameters setObject:pageNo forKey:@"pageNo"];
    [api.parameters setObject:pageSize forKey:@"pageSize"];
    [api.parameters setObject:phone forKey:@"phone"];
    api.subUrl = @"http://58.248.16.52:37771/WebService/GetOrderByPhone.ashx";
    return api;
}
@end

@implementation HJMyOrderListModel


@end
