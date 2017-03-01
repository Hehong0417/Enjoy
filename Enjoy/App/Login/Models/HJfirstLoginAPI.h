//
//  HJfirstLoginAPI.h
//  Cancer
//
//  Created by IMAC on 16/2/18.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@interface HJfirstLoginAPI : HJBaseAPI
+(instancetype)firstLoginWithUserType:(NSString *)userType diseaseID:(NSString *)diseaseID remedy:(NSString *)remedy;
@end
