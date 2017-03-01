//
//  HJAddSuitRecordAPI.m
//  Enjoy
//
//  Created by 邓朝文 on 16/5/6.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJAddSuitRecordAPI.h"

@implementation HJAddSuitRecordAPI
+ (instancetype)addSuitRecordWithSuitId:(NSNumber *)suitId eatType:(NSNumber *)eatType
{
    HJAddSuitRecordAPI *api = [[HJAddSuitRecordAPI alloc] init];
    [api.parameters setObject:suitId forKey:@"suitId"];
    [api.parameters setObject:eatType forKey:@"eatType"];
    api.subUrl = API_ADD_SUIT_RECORD;
    return api;
}
@end
