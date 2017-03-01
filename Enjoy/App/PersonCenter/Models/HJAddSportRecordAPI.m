//
//  HJAddSportRecordAPI.m
//  Enjoy
//
//  Created by 邓朝文 on 16/4/28.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJAddSportRecordAPI.h"

@implementation HJAddSportRecordAPI
+ (instancetype)addSportRecordWithSportId:(NSNumber *)sportId continueTime:(NSNumber *)continueTime
{
    HJAddSportRecordAPI *api = [[HJAddSportRecordAPI alloc] init];
    [api.parameters setObject:sportId forKey:@"sportId"];
    [api.parameters setObject:continueTime forKey:@"continueTime"];
    api.subUrl = API_ADD_SPORT_RECORD;
    return api;
}
@end
