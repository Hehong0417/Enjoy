//
//  HJAddSuitRecordAPI.h
//  Enjoy
//
//  Created by 邓朝文 on 16/5/6.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@interface HJAddSuitRecordAPI : HJBaseAPI
+ (instancetype)addSuitRecordWithSuitId:(NSNumber *)suitId eatType:(NSNumber *)eatType;
@end
