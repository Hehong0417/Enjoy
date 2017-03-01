//
//  HJAddFeedBackAPI.h
//  Enjoy
//
//  Created by 邓朝文 on 16/4/25.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@interface HJAddFeedBackAPI : HJBaseAPI

+ (instancetype)addFeedBackWithContent:(NSString *)content phone:(NSString *)phone;
@end

