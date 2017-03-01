//
//  HJAddSportRecordAPI.h
//  Enjoy
//
//  Created by 邓朝文 on 16/4/28.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@interface HJAddSportRecordAPI : HJBaseAPI
+ (instancetype)addSportRecordWithSportId:(NSNumber *)sportId continueTime:(NSNumber *)continueTime;
@end
