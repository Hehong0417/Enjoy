//
//  HJRecordAPI.m
//  Enjoy
//
//  Created by IMAC on 16/5/6.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJRecordAPI.h"
#import "HJUser.h"
@implementation HJRecordAPI
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"data" : [HJRecordModel class]};
}

+(instancetype)postQuestionListRecordAndquestionId:(NSArray *)date
{

    NSString *str = [date mj_JSONString];
    HJRecordAPI *api = [self new];
    if (![[HJUser sharedUser].loginModel.regInfoTag isEqualToString:@"-10000"]) {
        [api.parameters setObject:@"-10001" forKey:@"regInfoTag"];
    }
    [api.parameters setObject:str forKey:@"data"];
    api.subUrl = API_QUESTION_OVER;
    return api;
}
@end

@implementation HJRecordModel

@end
