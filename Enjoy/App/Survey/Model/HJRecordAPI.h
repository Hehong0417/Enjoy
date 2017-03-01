//
//  HJRecordAPI.h
//  Enjoy
//
//  Created by IMAC on 16/5/6.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@class HJRecordModel;

@interface HJRecordAPI : HJBaseAPI

@property (nonatomic, strong) HJRecordModel *data;

+(instancetype)postQuestionListRecordAndquestionId:(NSArray *)date;

@end

@interface HJRecordModel : HJBaseModel
@property (nonatomic, strong) NSString *healthReportId;
@end
