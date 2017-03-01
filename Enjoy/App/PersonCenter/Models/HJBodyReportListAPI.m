//
//  HJBodyReportListAPI.m
//  Enjoy
//
//  Created by 邓朝文 on 16/4/23.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBodyReportListAPI.h"

@implementation HJBodyReportListAPI

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"data":[HJBodyReportModel class]};
}

+ (instancetype)getBodyReportListWithPage:(NSNumber *)page rows:(NSNumber *)rows userType:(NSNumber *)userType puserId:(NSNumber *)puserId
{
    HJBodyReportListAPI *api = [self new];
    [api.parameters setObject:page forKey:@"page"];
    [api.parameters setObject:rows forKey:@"rows"];
    [api.parameters setObject:userType forKey:@"userType"];
    [api.parameters setObject:puserId forKey:@"puserId"];
    api.subUrl = API_BODY_REPORT_LIST;
    return api;
}
@end

@implementation HJBodyReportModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"bodyReportList":[HJBodyReportListModel class]};
}
@end

@implementation HJBodyReportListModel
+(NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"Id":@"id"};
}
@end
