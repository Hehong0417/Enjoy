//
//  HJMyMessageAPI.h
//  Enjoy
//
//  Created by 邓朝文 on 16/4/25.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@class HJmessageModel;
@interface HJMyMessageAPI : HJBaseAPI
+ (instancetype)getMyMessageWithPage:(NSNumber *)page rows:(NSNumber *)rows;
@property (nonatomic, strong) HJmessageModel *data;
@end

@interface HJmessageModel : HJBaseModel
@property (nonatomic, strong) NSArray *messageList;
@end
@interface HJMessageListlModel : HJBaseModel
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *hasRead;
@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, copy) NSString *pushTime;
@end