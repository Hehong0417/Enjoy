//
//  HJDeleteFamilyUserAPI.m
//  Enjoy
//
//  Created by 邓朝文 on 16/4/27.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJDeleteFamilyUserAPI.h"

@implementation HJDeleteFamilyUserAPI

+ (instancetype)deleteFamilyUserWithFamilyUserIdArray:(NSArray *)familyUserIdArray
{
    HJDeleteFamilyUserAPI *api = [[HJDeleteFamilyUserAPI alloc] init];
    NSMutableString *UserStr = [NSMutableString string];
    UserStr = familyUserIdArray[0];
    [api.parameters setObject:UserStr forKey:@"familyUserIdArray"];
    api.subUrl = API_DELETE_FAMILY_USER;
    return api;
}
@end
