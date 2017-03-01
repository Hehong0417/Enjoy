//
//  HJConfirmpProjectAPI.m
//  Enjoy
//
//  Created by IMAC on 16/4/25.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJConfirmpProjectAPI.h"

@implementation HJConfirmpProjectAPI
+(instancetype)ConfirmpProjectWithThinProjectId:(NSNumber *)thinProjectId {
    HJConfirmpProjectAPI *api = [self new];
    [api.parameters setObject:@"-10000" forKey:@"regInfoTag"];
    [api.parameters setObject:thinProjectId forKey:@"thinProjectId"];
    api.subUrl = API_CONFIRM_PROJECT;
    return api;
}
@end
