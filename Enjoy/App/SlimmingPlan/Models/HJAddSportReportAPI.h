//
//  HJAddSportReportAPI.h
//  Enjoy
//
//  Created by IMAC on 16/4/28.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@interface HJAddSportReportAPI : HJBaseAPI
+(instancetype)addSportRecordWithContinueTime:(NSString *)continueTime sportId:(NSNumber *)sportId;

@end
