//
//  HJMyMessageAPI.m
//  Enjoy
//
//  Created by 邓朝文 on 16/4/25.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJMyMessageAPI.h"

@implementation HJMyMessageAPI

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"data":[HJmessageModel class]};
}

+ (instancetype)getMyMessageWithPage:(NSNumber *)page rows:(NSNumber *)rows
{
    HJMyMessageAPI *api = [[HJMyMessageAPI alloc] init];
    [api.parameters setObject:page forKey:@"page"];
    [api.parameters setObject:rows forKey:@"rows"];
    api.subUrl = API_SYS_MESSAGE_LIST;
    return api;
}
@end

@implementation HJmessageModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"messageList":[HJMessageListlModel class]};
}

@end

@implementation HJMessageListlModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"Id" : @"id"};
}

@end
