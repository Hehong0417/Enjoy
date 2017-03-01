
//
//  HJWaistHipListAPI.m
//  Enjoy
//
//  Created by IMAC on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJWaistHipListAPI.h"

@implementation HJWaistHipListAPI
+(instancetype)getWaistHipListWithPage:(NSNumber *)page rows:(NSNumber *)rows userType:(NSNumber *)userType puserId:(NSNumber *)puserId {
    
    HJWaistHipListAPI *api = [self new];
    [api.parameters setObject:page forKey:@"page"];
    [api.parameters setObject:rows forKey:@"rows"];
    [api.parameters setObject:userType forKey:@"userType"];
    [api.parameters setObject:puserId forKey:@"puserId"];
    api.subUrl = API_WAIST_HIP_LIST;
    return api;
}
@end
@implementation WaistHipModel
+(NSDictionary *)mj_objectClassInArray {
    
    return @{@"waistHipList":[WaistHipListModel class]};
}

@end
@implementation WaistHipListModel
+(NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"Id":@"id"};
}

@end