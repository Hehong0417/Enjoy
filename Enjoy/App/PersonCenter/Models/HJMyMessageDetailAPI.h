//
//  HJMyMessageDetailAPI.h
//  Enjoy
//
//  Created by 邓朝文 on 16/4/25.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@class HJMyMessageDetailModel;
@interface HJMyMessageDetailAPI : HJBaseAPI
+ (instancetype)getMyMessageDetailWithMessageId:(NSNumber *)messageId;
@property (nonatomic, strong) HJMyMessageDetailModel *data;
@end

@interface HJMyMessageDetailModel : HJBaseModel
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *pushTime;
@end

