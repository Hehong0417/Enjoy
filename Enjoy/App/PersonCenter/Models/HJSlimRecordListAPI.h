//
//  HJSlimRecordListAPI.h
//  Enjoy
//
//  Created by IMAC on 16/4/26.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"
@class HJSlimRecordListModel;
@interface HJSlimRecordListAPI : HJBaseAPI
@property (nonatomic, strong) HJSlimRecordListModel *data;
+(instancetype)getSlimRecordListWithdate:(NSString *)date;
@end
@interface HJSlimRecordListModel : HJBaseModel

@property (nonatomic, strong) NSString *createTime;

@property (nonatomic, strong) NSString *advice;

@property (nonatomic, strong) NSString *inCalory;

@property (nonatomic, strong) NSString *outCalory;

@property (nonatomic, strong) NSString *weightChanges;
@property (nonatomic, strong) NSString *comment;

@end

