//
//  HJAuitFoodListAPI.m
//  Enjoy
//
//  Created by IMAC on 16/4/25.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJSuitFoodListAPI.h"

@implementation HJSuitFoodListAPI
+(instancetype)getSuitFoodListWithEatType:(NSNumber *)eatType {
    
    HJSuitFoodListAPI *api = [self new];
    
    [api.parameters setObject:eatType forKey:@"eatType"];
    api.subUrl = API_SUIT_FOODLIST;
    return api;
    
}
@end
@implementation HJSuitFoodListModel
+(NSDictionary *)mj_objectClassInArray {
    
    return @{@"foodList":[HJSuitModel class]};
    
}

@end
@implementation HJSuitModel


@end