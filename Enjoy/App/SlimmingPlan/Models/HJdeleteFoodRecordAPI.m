
//
//  HJdeleteFoodRecordAPI.m
//  Enjoy
//
//  Created by IMAC on 16/4/29.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJdeleteFoodRecordAPI.h"

@implementation HJdeleteFoodRecordAPI

+(instancetype)deleteFoodRecordWithFoodIdArray:(NSArray *)foodIdArray {
    HJdeleteFoodRecordAPI *api = [self new];
    NSString *foodId = foodIdArray[0];
    [api.parameters setObject:foodId forKey:@"foodIdArray"];
    api.subUrl = API_DELETE_FOOD_RECORD;
    return api;
}
@end
