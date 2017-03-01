//
//  HJAddFamilyUserAPI.h
//  Enjoy
//
//  Created by 邓朝文 on 16/4/25.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@interface HJAddFamilyUserAPI : HJBaseAPI

+ (instancetype)addFamilyUserWithName:(NSString *)name sex:(NSNumber *)sex birthday:(NSString *)birthday job:(NSString *)job height:(NSString *)height photoFile:(NSData *)photoFile;

+ (instancetype)completeUserInfoWithID:(NSNumber *)ID name:(NSString *)name sex:(NSInteger)sex birthday:(NSString *)birthday job:(NSString *)job height:(NSString *)height weight:(NSString *)weight waistline:(NSString *)waistline hipline:(NSString *)hipline province:(NSString *)province city:(NSString *)city photoFile:(NSData *)photoFile;

@end


