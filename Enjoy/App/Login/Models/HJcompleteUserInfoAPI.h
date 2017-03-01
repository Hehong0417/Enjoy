//
//  HJcompleteUserInfoAPI.h
//  Enjoy
//
//  Created by IMAC on 16/4/23.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"
@class HJCompleteModel;
@interface HJcompleteUserInfoAPI : HJBaseAPI
@property (nonatomic, strong) HJCompleteModel *data;
+(instancetype)completeUserInfoWithBirthday:(NSString *)birthday province:(NSString *)province city:(NSString *)city height:(NSString *)height job:(NSString *)job name:(NSString *)name sex:(NSString *)sex token:(NSString *)token userId:(NSString *)userId;

+ (instancetype)completeUserInfoWithName:(NSString *)name sex:(NSInteger)sex birthday:(NSString *)birthday job:(NSString *)job  height:(NSString *)height weight:(NSString *)weight waistline:(NSString *)waistline hipline:(NSString *)hipline province:(NSString *)province city:(NSString *)city photoFile:(NSData *)photoFile;

+ (instancetype)completeUserInfoWithIsMenstruation:(NSString *)isMenstruation;
@end
@interface HJCompleteModel : HJBaseModel
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *userId;
@end