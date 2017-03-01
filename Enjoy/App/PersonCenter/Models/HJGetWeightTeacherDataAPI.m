

//
//  HJGetWeightTeacherDataAPI.m
//  Enjoy
//
//  Created by IMAC on 16/5/5.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJGetWeightTeacherDataAPI.h"

@implementation HJGetWeightTeacherDataAPI
+(instancetype)getWeightTeacherDataWithPuserId:(NSNumber *)puserId {
    HJGetWeightTeacherDataAPI *api = [self new];
    [api.parameters setObject:puserId forKey:@"puserId"];
    api.subUrl = API_WEIGHT_TEACHER_OFUSER;
    return api;
}
@end
@implementation HJWeightTeacherModel

+(NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"Id":@"id"};
}

@end