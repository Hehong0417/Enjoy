//
//  HJSystemAttributeAPI.m
//  Enjoy
//
//  Created by 邓朝文 on 16/4/29.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJSystemAttributeAPI.h"

@implementation HJSystemAttributeAPI
+ (instancetype)getAboutWeWithName:(NSString *)name Type:(NSString *)Type
{
    HJSystemAttributeAPI *api = [[HJSystemAttributeAPI alloc] init];
    [api.parameters setObject:name forKey:@"name"];
    [api.parameters setObject:Type forKey:@"Type"];
    api.subUrl = API_SYSTEM_ATTRIBUT;
    return api;
}
@end

@implementation HJAboutWeModel

@end
@implementation HJSystemAttributeModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"Id" : @"id"};
}
@end