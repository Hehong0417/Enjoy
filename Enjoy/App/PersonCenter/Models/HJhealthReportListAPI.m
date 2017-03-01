
//
//  HJhealthReportListAPI.m
//  Enjoy
//
//  Created by IMAC on 16/4/29.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJhealthReportListAPI.h"

@implementation HJhealthReportListAPI
+(instancetype)getHealthReportListWithPage:(NSNumber *)page rows:(NSNumber *)rows {
    
    HJhealthReportListAPI *api = [self new];
    [api.parameters setObject:page forKey:@"page"];
    [api.parameters setObject:rows forKey:@"rows"];
    api.subUrl = API_HEALTH_REPORT_LIST;
    return api;
}
@end
@implementation healthReportListModel
+(NSDictionary *)mj_objectClassInArray {
    
    return @{@"healthReportList":[healthArrModel class]};
}

@end
@implementation healthArrModel
+(NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"Id":@"id"};
}

@end