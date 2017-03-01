//
//  HJBodyReportDetailAPI.m
//  Enjoy
//
//  Created by 邓朝文 on 16/4/23.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBodyReportDetailAPI.h"

@implementation HJBodyReportDetailAPI

+ (instancetype)getHJBodyReportDetailWithBodyReportId:(NSNumber *)bodyReportId
{
    HJBodyReportDetailAPI *api = [self new];
    [api.parameters setObject:bodyReportId forKey:@"bodyReportId"];
    api.subUrl = API_BODY_REPORT_DETAIL;
    return api;
}
@end

@implementation HJBodyReportDetailModel


@end
