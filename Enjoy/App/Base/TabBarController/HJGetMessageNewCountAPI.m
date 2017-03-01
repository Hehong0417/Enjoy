//
//  HJGetMessageNewCountAPI.m
//  Enjoy
//
//  Created by 邓朝文 on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJGetMessageNewCountAPI.h"

@implementation HJGetMessageNewCountAPI
+ (instancetype)getMessageNewCount
{
    HJGetMessageNewCountAPI *api = [[HJGetMessageNewCountAPI alloc] init];
    api.subUrl = API_GET_MESSAGE_NEW_COUNT;
    return api;
}
@end
