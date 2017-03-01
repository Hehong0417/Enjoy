//
//  HJAddCommentAPI.h
//  Enjoy
//
//  Created by IMAC on 16/5/5.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@interface HJAddCommentAPI : HJBaseAPI
+(instancetype)addCommentWithInformationId:(NSString *)informationId content:(NSString *)content;
@end
