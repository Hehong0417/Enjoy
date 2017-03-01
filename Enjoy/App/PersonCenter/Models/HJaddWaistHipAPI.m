//
//  HJaddWaistHipAPI.m
//  Enjoy
//
//  Created by IMAC on 16/5/7.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJaddWaistHipAPI.h"

@implementation HJaddWaistHipAPI
+(instancetype)addWaistHipWithUserId:(NSNumber *)userId token:(NSString *)token puserId:(NSNumber *)puserId waistline:(NSString *)waistline hipline:(NSString *)hipline
                           userType :(NSNumber *)userType {
    
    HJaddWaistHipAPI *api = [self new];
    
    [api.parameters setObject:waistline forKey:@"waistline"];
    [api.parameters setObject:hipline forKey:@"hipline"];
    [api.parameters setObject:userType forKey:@"userType"];
    if (puserId) {
        [api.parameters setObject:puserId forKey:@"puserId"];
    }
    
    api.subUrl = API_ADD_WAISTHIP;
    
    return api;
}
@end
