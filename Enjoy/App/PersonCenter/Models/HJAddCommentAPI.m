

//
//  HJAddCommentAPI.m
//  Enjoy
//
//  Created by IMAC on 16/5/5.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJAddCommentAPI.h"

@implementation HJAddCommentAPI
+(instancetype)addCommentWithInformationId:(NSString *)informationId content:(NSString *)content {
    
    HJAddCommentAPI *api = [self new];
    
    [api.parameters setObject:informationId forKey:@"informationId"];
    [api.parameters setObject:content forKey:@"content"];
    api.subUrl = API_ADD_COMMENT;
    
    return api;
}
@end
