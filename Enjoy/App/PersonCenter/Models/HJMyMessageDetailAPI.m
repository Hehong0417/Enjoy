//
//  HJMyMessageDetailAPI.m
//  Enjoy
//
//  Created by 邓朝文 on 16/4/25.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJMyMessageDetailAPI.h"

@implementation HJMyMessageDetailAPI
+ (instancetype)getMyMessageDetailWithMessageId:(NSNumber *)messageId
{
    HJMyMessageDetailAPI *api = [[HJMyMessageDetailAPI alloc] init];
    [api.parameters setObject:messageId forKey:@"messageId"];
    api.subUrl = API_SYS_MESSAGE_DETAIL;
    return api;
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"data" : [HJMyMessageDetailModel class]};
}
@end

@implementation HJMyMessageDetailModel


@end
