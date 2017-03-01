//
//  HJAddFoodRecordAPI.h
//  Enjoy
//
//  Created by 邓朝文 on 16/4/28.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@interface HJAddFoodRecordAPI : HJBaseAPI
+ (instancetype)addFoodRecordWtihFoodId:(NSNumber *)foodId quantity:(NSNumber *)quantity eatType:(NSNumber *)eatType;
@end
