//
//  HJchooseThinProjectHJAPI.m
//  Enjoy
//
//  Created by IMAC on 16/4/25.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJChooseThinProjectAPI.h"

@implementation HJChooseThinProjectAPI
+(instancetype)chooseThinProject {
    HJChooseThinProjectAPI *api = [self new];
    api.subUrl = API_SYSTEMRECOMMEND;
    return api;
}
@end

@implementation HJChooseThinProjectModel
+(NSDictionary *)mj_objectClassInArray {
    
    return @{@"data":[HJChooseThinProjectModel class]};
}

+(NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"Id":@"id"};
}
@end
