//
//  HJAddFeedBackAPI.m
//  Enjoy
//
//  Created by 邓朝文 on 16/4/25.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJAddFeedBackAPI.h"

@implementation HJAddFeedBackAPI



+ (instancetype)addFeedBackWithContent:(NSString *)content phone:(NSString *)phone
{
    HJAddFeedBackAPI *api = [[HJAddFeedBackAPI alloc] init];
    [api.parameters setObject:content forKey:@"content"];
    [api.parameters setObject:phone forKey:@"phone"];
    api.subUrl = API_ADD_Feed_Back;
    return api;
}
@end
