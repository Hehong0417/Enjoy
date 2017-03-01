//
//  HJJobListAPI.m
//  Enjoy
//
//  Created by IMAC on 16/4/22.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJJobListAPI.h"

@implementation HJJobListAPI
+(instancetype)getJobListWithPage:(NSNumber *)page rows:(NSNumber *)rows {
    HJJobListAPI *api = [self new];
    [api.parameters setObject:page forKey:@"page"];
    [api.parameters setObject:rows forKey:@"rows"];
    api.subUrl = API_JOB_LIST;
    return api;
}
@end
