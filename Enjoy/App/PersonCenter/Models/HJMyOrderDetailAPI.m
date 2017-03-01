//
//  HJMyOrderDetailAPI.m
//  Enjoy
//
//  Created by 邓朝文 on 16/4/23.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJMyOrderDetailAPI.h"

@implementation HJMyOrderDetailAPI

+ (instancetype)getMyOrderDetailWithOrderNo:(NSNumber *)orderNo
{
    HJMyOrderDetailAPI *api = [HJMyOrderDetailAPI new];
    [api.parameters setObject:orderNo forKey:@"orderNo"];
    api.subUrl = @"http://58.248.16.52:37771/WebService/GetOrderByNo.ashx";
    return api;
}
@end

@implementation HJMyOrderDetailModel


@end
