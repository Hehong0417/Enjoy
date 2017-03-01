//
//  HJLoginAPI.h
//  Cancer
//
//  Created by IMAC on 16/2/17.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"
#import "HJUser.h"

@interface HJLoginAPI : HJBaseAPI

@property (nonatomic, strong) HJLoginModel *data;

+ (instancetype)loginWithAccount:(NSString *)account loginType:(NSNumber *)loginType password:(NSString *)password;

@end
