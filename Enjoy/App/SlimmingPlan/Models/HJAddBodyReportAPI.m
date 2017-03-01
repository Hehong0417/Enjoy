//
//  HJAddBodyReportAPI.m
//  Enjoy
//
//  Created by IMAC on 16/4/27.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJAddBodyReportAPI.h"
#import "HJUser.h"

@implementation HJAddBodyReportAPI

+(instancetype)addBodyReportWithweight:(NSString *)weight bmi:(NSString *)bmi bfr:(NSString *)bfr sfr:(NSString *)sfr uvi:(NSString *)uvi rom:(NSString *)rom bmr:(NSString *)bmr bm:(NSString *)bm vwc:(NSString *)vwc  pp:(NSString *)pp userId:(NSNumber *)userId puserId:(NSNumber *)puserId userType:(NSNumber *)userType age:(NSNumber *)age smr:(NSString *)smr adc:(NSString *)adc{
    
    HJAddBodyReportAPI *api = [self new];
    if (![[HJUser sharedUser].loginModel.regInfoTag isEqualToString:@"-10000"]) {
        
        [api.parameters setObject:@"-10002" forKey:@"regInfoTag"];
    }
    
    [api.parameters setObject:weight forKey:@"weight"];
    [api.parameters setObject:bmi forKey:@"bmi"];
    [api.parameters setObject:bfr forKey:@"bfr"];
    [api.parameters setObject:sfr forKey:@"sfr"];
    [api.parameters setObject:uvi forKey:@"uvi"];
    [api.parameters setObject:rom forKey:@"rom"];
    [api.parameters setObject:bmr forKey:@"bmr"];
    [api.parameters setObject:bm forKey:@"bm"];
    [api.parameters setObject:vwc forKey:@"vwc"];
    [api.parameters setObject:pp forKey:@"pp"];
    [api.parameters setObject:age forKey:@"age"];
    [api.parameters setObject:smr forKey:@"smr"];
    [api.parameters setObject:adc forKey:@"adc"];

    if (userId) {
      [api.parameters setObject:userId forKey:@"userId"];
    }
    if (puserId) {
        [api.parameters setObject:puserId forKey:@"puserId"];
    }
    [api.parameters setObject:userType forKey:@"userType"];

    api.parametersAddToken = NO;
    api.subUrl = API_ADD_BODY_REPORT;
    return api;
}
@end
@implementation HJAddBodyReportModel


@end
@implementation HJSlimModel
+(NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"Id":@"id"};
}
@end
