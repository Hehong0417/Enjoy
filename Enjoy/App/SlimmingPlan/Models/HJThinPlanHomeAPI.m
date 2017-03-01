//
//  HJThinPlanHomeAPI.m
//  Enjoy
//
//  Created by IMAC on 16/4/23.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJThinPlanHomeAPI.h"
#import "HJUser.h"

@implementation HJThinPlanHomeAPI
+(instancetype)getThinPlanHomeData {
    HJThinPlanHomeAPI *api = [self new];
    //api.parametersAddToken = YES;
    
    HJUser *user = [HJUser read];
//   NSString *userId = [uDefault objectForKey:@"userId"];
//    NSString *token = [uDefault objectForKey:@"token"];
    NSString *userId = user.loginModel.userId;
    NSString *token = user.loginModel.token;

    [api.parameters setObject:userId forKey:@"userId"];
    [api.parameters setObject:token forKey:@"token"];
    
    api.subUrl = API_THINPLAN_HOME;
    return api;
}
@end
@implementation HJThinPlanHomeModel
+(NSDictionary *)mj_objectClassInArray {
    
    return @{@"bigFoodRecordList":[HJBigFoodRecordModel class]};
}
- (void)mj_keyValuesDidFinishConvertingToObject {
    
    self.height = 150 + self.bigFoodRecordList.count*38;
}
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property
{
    
    if (oldValue == nil || [oldValue isKindOfClass:[NSNull class]]) {
        
        return @"";
    }
    return oldValue;
}
@end
@implementation HJBigFoodRecordModel
+(NSDictionary *)mj_objectClassInArray {
    
    return @{@"foodRecordList":[HJFoodRecord class]};
}
- (void)mj_keyValuesDidFinishConvertingToObject {
    
    self.height = self.foodRecordList.count*44;
}
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property
{
    
    if (oldValue == nil || [oldValue isKindOfClass:[NSNull class]]) {
        
        return @"";
    }
    return oldValue;
}
@end
@implementation HJFoodRecord
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property
{
    
    if (oldValue == nil || [oldValue isKindOfClass:[NSNull class]]) {
        
        return @"";
    }
    return oldValue;
}
@end
