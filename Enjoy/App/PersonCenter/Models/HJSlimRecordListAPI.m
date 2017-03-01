//
//  HJSlimRecordListAPI.m
//  Enjoy
//
//  Created by IMAC on 16/4/26.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJSlimRecordListAPI.h"

@implementation HJSlimRecordListAPI

+(instancetype)getSlimRecordListWithdate:(NSString *)date  {
    HJSlimRecordListAPI *api = [self new];
    [api.parameters setObject:date forKey:@"date"];
    
    api.subUrl = API_SLIM_RECORD_BYDATE;
    return api;
}
@end
@implementation HJSlimRecordListModel


@end


