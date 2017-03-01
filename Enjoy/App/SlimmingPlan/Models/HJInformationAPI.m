//
//  HJInformationAPI.m
//  Enjoy
//
//  Created by IMAC on 16/5/30.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJInformationAPI.h"

@implementation HJInformationAPI
+(instancetype)getInformationListWithColumnId:(NSString *)columnId page:(NSNumber *)page rows:(NSNumber *)rows {
    
    HJInformationAPI *api = [self new];
    [api.parameters setObject:columnId forKey:@"columnId"];
    [api.parameters setObject:page forKey:@"page"];
    [api.parameters setObject:rows forKey:@"rows"];
    api.subUrl = API_INFORMATION_LIST;
    return api;
}
@end
@implementation HJDataModel

+ (NSDictionary *)objectClassInArray{
    return @{@"informationList" : [HJInformationModel class]};
}

@end
@implementation HJInformationModel
+(NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"informationId":@"id"};
    
}

@end