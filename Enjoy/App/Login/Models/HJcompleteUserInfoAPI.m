//
//  HJcompleteUserInfoAPI.m
//  Enjoy
//
//  Created by IMAC on 16/4/23.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJcompleteUserInfoAPI.h"

@implementation HJcompleteUserInfoAPI
+(instancetype)completeUserInfoWithBirthday:(NSString *)birthday province:(NSString *)province city:(NSString *)city height:(NSString *)height job:(NSString *)job name:(NSString *)name sex:(NSString *)sex token:(NSString *)token userId:(NSString *)userId {
    HJcompleteUserInfoAPI *api = [self new];
    [api.parameters setObject:@"-10003" forKey:@"regInfoTag"];
    [api.parameters setObject:birthday forKey:@"birthday"];
    [api.parameters setObject:province forKey:@"province"];
    [api.parameters setObject:city forKey:@"city"];
    [api.parameters setObject:height forKey:@"height"];
    [api.parameters setObject:job forKey:@"job"];
    [api.parameters setObject:name forKey:@"name"];
    if ([sex isEqualToString:@"男"]) {
        [api.parameters setObject:@0 forKey:@"sex"];
    } else {
        [api.parameters setObject:@1 forKey:@"sex"];
    }
    if (token) {
        [api.parameters setObject:token forKey:@"token"];
    }
    if (userId) {
        [api.parameters setObject:userId forKey:@"userId"];
    }
    api.parametersAddToken = NO;
    api.subUrl = API_COMPLETE_USERINFO;
    return api;
}

+ (instancetype)completeUserInfoWithName:(NSString *)name sex:(NSInteger)sex birthday:(NSString *)birthday job:(NSString *)job height:(NSString *)height weight:(NSString *)weight waistline:(NSString *)waistline hipline:(NSString *)hipline province:(NSString *)province city:(NSString *)city photoFile:(NSData *)photoFile
{

    HJcompleteUserInfoAPI *api = [self new];
    if (name) {
        [api.parameters setObject:name forKey:@"name"];  
    }
    
    if (photoFile) {
        HJNetworkClientFile *file = [HJNetworkClientFile imageFileWithFileData:photoFile name:@"photoFile"];
        api.uploadFile = @[file];
    }
    [api.parameters setObject:[NSNumber numberWithInteger:sex] forKey:@"sex"];
    [api.parameters setObject:birthday forKey:@"birthday"];
    [api.parameters setObject:job forKey:@"job"];
    [api.parameters setObject:height forKey:@"height"];
    [api.parameters setObject:weight forKey:@"weight"];
    if (waistline) {
        [api.parameters setObject:waistline forKey:@"waistline"];
    }
    if (hipline) {
     [api.parameters setObject:hipline forKey:@"hipline"];
    }
    [api.parameters setObject:province forKey:@"province"];
    [api.parameters setObject:city forKey:@"city"];
    api.subUrl = API_COMPLETE_USERINFO;
    return api;

}
+ (instancetype)completeUserInfoWithIsMenstruation:(NSString *)isMenstruation {
    HJcompleteUserInfoAPI *api = [self new];

    [api.parameters setObject:isMenstruation forKey:@"isMenstruation"];
    
    api.subUrl = API_COMPLETE_USERINFO;
    
    return api;
}
@end
@implementation HJCompleteModel



@end
