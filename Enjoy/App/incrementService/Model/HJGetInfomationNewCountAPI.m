//
//  HJGetInfomationNewCountAPI.m
//  Enjoy
//
//  Created by 邓朝文 on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJGetInfomationNewCountAPI.h"

@implementation HJGetInfomationNewCountAPI
+ (instancetype)getInfomationNewCount
{
    HJGetInfomationNewCountAPI *api = [[HJGetInfomationNewCountAPI alloc] init];
    api.subUrl = API_GET_INFOMATION_NEW_COUNT;
    return api;
}
@end
