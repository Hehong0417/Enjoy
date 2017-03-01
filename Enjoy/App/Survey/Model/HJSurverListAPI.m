//
//  HJSurverListAPI.m
//  Enjoy
//
//  Created by IMAC on 16/4/30.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJSurverListAPI.h"

@implementation HJSurverListAPI

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"data" : [HJSurverListModel class]};
}

+(instancetype)getList:(NSString *)healthId AndPage:(NSNumber *)page rows:(NSNumber *)rows{
    
    HJSurverListAPI *api = [self new];
    [api.parameters setObject:healthId forKey:@"healthId"];
    [api.parameters setObject:page forKey:@"page"];
    [api.parameters setObject:rows forKey:@"rows"];
    api.subUrl = API_QUESTION_LIST;
    return api;
    
}
@end


@implementation HJSurverListModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"questionList" : [HJquestionListModel class]};
}
@end


@implementation HJquestionListModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"answerList" :[HJanswerListModel class]};
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"Id" : @"id"};
}
@end

@implementation HJanswerListModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"Id" : @"id"};
}
@end
