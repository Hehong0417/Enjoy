//
//  HJFindPasswordAPI.h
//  Enjoy
//
//  Created by IMAC on 16/4/23.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@interface HJFindPasswordAPI : HJBaseAPI
+(instancetype)findPassword:(NSString *)telephone shortMsgCode:(NSString *)shortMsgCode newPwd:(NSString *)newPwd;
@end
