
//
//  HJAddFoodRecordAPI.m
//  Enjoy
//
//  Created by 邓朝文 on 16/4/28.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJAddFoodRecordAPI.h"

@implementation HJAddFoodRecordAPI
+ (instancetype)addFoodRecordWtihFoodId:(NSNumber *)foodId quantity:(NSNumber *)quantity eatType:(NSNumber *)eatType
{
    HJAddFoodRecordAPI *api = [[HJAddFoodRecordAPI alloc] init];
    [api.parameters setObject:foodId forKey:@"foodId"];
    [api.parameters setObject:quantity forKey:@"quantity"];
    [api.parameters setObject:eatType forKey:@"eatType"];
    api.subUrl = API_ADD_FOOD_RECORD;
    return api;
}
@end
