//
//  HJAddFamilyUserAPI.m
//  Enjoy
//
//  Created by 邓朝文 on 16/4/25.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJAddFamilyUserAPI.h"

@implementation HJAddFamilyUserAPI
+ (instancetype)addFamilyUserWithName:(NSString *)name sex:(NSNumber *)sex birthday:(NSString *)birthday job:(NSString *)job height:(NSString *)height photoFile:(NSData *)photoFile
{
    HJAddFamilyUserAPI *api = [[HJAddFamilyUserAPI alloc] init];
    if (photoFile) {
        HJNetworkClientFile *file = [HJNetworkClientFile imageFileWithFileData:photoFile name:@"photoFile"];
        api.uploadFile = @[file];
    }
    [api.parameters setObject:birthday forKey:@"birthday"];
    [api.parameters setObject:sex forKey:@"sex"];
    [api.parameters setObject:height forKey:@"height"];
    [api.parameters setObject:job forKey:@"job"];
    [api.parameters setObject:name forKey:@"name"];
    api.subUrl = API_ADD_FAMILY_USER;
    return api;
}

+ (instancetype)completeUserInfoWithID:(NSNumber *)ID name:(NSString *)name sex:(NSInteger)sex birthday:(NSString *)birthday job:(NSString *)job height:(NSString *)height weight:(NSString *)weight waistline:(NSString *)waistline hipline:(NSString *)hipline province:(NSString *)province city:(NSString *)city photoFile:(NSData *)photoFile
{
    HJAddFamilyUserAPI *api = [self new];
    if (name) {
        [api.parameters setObject:name forKey:@"name"];
    }
    
    if (photoFile) {
        HJNetworkClientFile *file = [HJNetworkClientFile imageFileWithFileData:photoFile name:@"photoFile"];
        api.uploadFile = @[file];
    }
    [api.parameters setObject:ID forKey:@"id"];
    [api.parameters setObject:[NSNumber numberWithInteger:sex] forKey:@"sex"];
    [api.parameters setObject:birthday forKey:@"birthday"];
    [api.parameters setObject:job forKey:@"job"];
    [api.parameters setObject:height forKey:@"height"];
    [api.parameters setObject:weight forKey:@"weight"];
    [api.parameters setObject:waistline forKey:@"waistline"];
    [api.parameters setObject:hipline forKey:@"hipline"];
    [api.parameters setObject:province forKey:@"province"];
    [api.parameters setObject:city forKey:@"city"];
    api.subUrl = API_ADD_FAMILY_USER;
    return api;
}
@end
