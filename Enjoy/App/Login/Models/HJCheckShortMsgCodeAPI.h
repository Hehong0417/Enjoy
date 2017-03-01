//
//  HJCheckShortMsgCodeAPI.h
//  Enjoy
//
//  Created by IMAC on 16/5/4.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@interface HJCheckShortMsgCodeAPI : HJBaseAPI
@property (nonatomic, assign) NSInteger data;
+(instancetype)checkShortMsgCodeWithtelephone:(NSString *)telephone shortMsgCode:(NSString *)shortMsgCode;
@end
