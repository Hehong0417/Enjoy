//
//  HJBeginSportAPI.m
//  Enjoy
//
//  Created by IMAC on 16/4/25.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBeginSportAPI.h"

@implementation HJBeginSportAPI
+(instancetype)getBeginSportData {
    HJBeginSportAPI *api = [self new];
    api.subUrl = API_BEGIN_SPORT;
    return api;
}
@end
@implementation HJBeginSportModel
+(NSDictionary *)mj_objectClassInArray {
    
    return @{@"sportRecordList":[HJSportrecordModel class]};
}
@end
@implementation HJRecommentSportModel

+(NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"ID":@"id"};
}

@end
@implementation HJSportrecordModel

+(NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"ID":@"id"};
}
@end