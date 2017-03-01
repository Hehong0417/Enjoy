
//
//  HJaddWeightAPI.m
//  Enjoy
//
//  Created by IMAC on 16/4/25.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJAddWeightAPI.h"
#import "HJUser.h"
@implementation HJAddWeightAPI
+(instancetype)addWeightWithWeight:(NSString *)weight {
    HJAddWeightAPI *api = [self new];
    [api.parameters setObject:weight forKey:@"weight"];
    if (![[HJUser sharedUser].loginModel.regInfoTag isEqualToString:@"-10000"]) {
        [api.parameters setObject:@"-10002" forKey:@"regInfoTag"];
    }
    api.subUrl = API_THINPLAN_ADD_WEIGHT;
    return api;
}

@end
