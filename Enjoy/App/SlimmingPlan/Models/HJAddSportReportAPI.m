
//
//  HJAddSportReportAPI.m
//  Enjoy
//
//  Created by IMAC on 16/4/28.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJAddSportReportAPI.h"

@implementation HJAddSportReportAPI
+(instancetype)addSportRecordWithContinueTime:(NSString *)continueTime sportId:(NSNumber *)sportId {
    HJAddSportReportAPI *api = [self new];
    [api.parameters setObject:continueTime forKey:@"continueTime"];
    [api.parameters setObject:sportId forKey:@"sportId"];
    api.subUrl = API_ADD_SPORT_RECORD;
    return api;
}
@end
