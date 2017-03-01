//
//  HJaddWaistHipAPI.h
//  Enjoy
//
//  Created by IMAC on 16/5/7.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@interface HJaddWaistHipAPI : HJBaseAPI
+(instancetype)addWaistHipWithUserId:(NSNumber *)userId token:(NSString *)token puserId:(NSNumber *)puserId  waistline:(NSString *)waistline hipline:(NSString *)hipline
                           userType :(NSNumber *)userType;
@end
