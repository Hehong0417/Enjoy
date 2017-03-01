//
//  HJBodyReportDetailAPI.h
//  Enjoy
//
//  Created by 邓朝文 on 16/4/23.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@interface HJBodyReportDetailAPI : HJBaseAPI

+ (instancetype)getHJBodyReportDetailWithBodyReportId:(NSNumber *)bodyReportId;

@end

@interface HJBodyReportDetailModel : HJBaseModel
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *title;
@end

