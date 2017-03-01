//
//  HJGetCaptchaAPI.h
//  Cancer
//
//  Created by IMAC on 16/2/17.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"
@class HJMsgCodeModel;
@interface HJGetCaptchaAPI : HJBaseAPI
@property (nonatomic, assign) NSInteger data;
+ (instancetype)getCaptchaWith:(NSString *)phone;
@end
@interface HJMsgCodeModel : HJBaseModel
//@property (nonatomic, copy) NSString *shortMsgCode;
@end