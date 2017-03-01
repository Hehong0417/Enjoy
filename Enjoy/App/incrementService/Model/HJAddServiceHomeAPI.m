//
//  HJAddServiceHomeAPI.m
//  Enjoy
//
//  Created by 邓朝文 on 16/4/25.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJAddServiceHomeAPI.h"

@implementation HJAddServiceHomeAPI
+ (instancetype)getAddServiceHomeWithBannerQuantity:(NSNumber *)bannerQuantity infoQuantity:(NSNumber *)infoQuantity
{
    HJAddServiceHomeAPI *api = [[HJAddServiceHomeAPI alloc] init];
    [api.parameters setObject:bannerQuantity forKey:@"bannerQuantity"];
    [api.parameters setObject:infoQuantity forKey:@"infoQuantity"];
    api.subUrl = API_ADDSERVICE_HOME;
    return api;
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"data" : [HJAddServiceHomeModel class]};
}
@end

@implementation HJAddServiceHomeModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"bannerList" : [HJBannerList class], @"columnList" : [HJcolumnList class]};
}
@end

@implementation HJBannerList

+(NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"Id":@"id"};
}
@end

@implementation HJcolumnList
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"informationList" : [HJInformationList class]};
}
+(NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"Id":@"id"};
}
@end
@implementation HJInformationList
+(NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"Id":@"id"};
}
@end





