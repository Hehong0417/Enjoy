//
//  HJAddShareAPI.m
//  Enjoy
//
//  Created by IMAC on 16/5/31.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJAddShareAPI.h"

@implementation HJAddShareAPI

+(instancetype)addShareInfo:(NSInteger)objectId AndbeenShareType:(NSInteger)beenShareType AndsharePlate:(NSInteger)sharePlate {
    
    HJAddShareAPI *api = [self new];
    
    [api.parameters setObject:@(objectId) forKey:@"objectId"];
    [api.parameters setObject:@(beenShareType) forKey:@"beenShareType"];
    [api.parameters setObject:@(sharePlate) forKey:@"sharePlate"];
    
    api.subUrl = API_ADD_SHARE;
    
    return api;
}

@end
