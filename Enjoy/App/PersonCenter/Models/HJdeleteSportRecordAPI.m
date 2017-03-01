//
//  HJdeleteSportRecordAPI.m
//  Enjoy
//
//  Created by IMAC on 16/5/27.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJdeleteSportRecordAPI.h"

@implementation HJdeleteSportRecordAPI

+(instancetype)deleteSportRecordWithSportIdArray:(NSString *)sportIdArray {
    
    HJdeleteSportRecordAPI *api = [self new];
    
    [api.parameters setObject:sportIdArray forKey:@"sportRecordIdArray"];
    
    api.subUrl = API_DELETE_RECORD;
    
    return api;
}
@end
