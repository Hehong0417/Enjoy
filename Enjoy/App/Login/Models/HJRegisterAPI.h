//
//  HJRegisterAPI.h
//  Cancer
//
//  Created by IMAC on 16/2/17.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"
@class RegisterModel;
@interface HJRegisterAPI : HJBaseAPI
@property (nonatomic, strong) RegisterModel *data;
+ (instancetype)registerWithPhone:(NSString *)telephone captcha:(NSString *)shortMsgCode pwd:(NSString *)password qqAccount:(NSString *)qqAccount qqNick:(NSString *)qqNick wxAccount:(NSString *)wxAccount wxNick:(NSString *)wxNick icon:(NSString *)icon;
@end
@interface RegisterModel : HJBaseModel
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *userId;
@end