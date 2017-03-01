//
//  HJBodyReportListAPI.h
//  Enjoy
//
//  Created by 邓朝文 on 16/4/23.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@class HJBodyReportModel;
@interface HJBodyReportListAPI : HJBaseAPI

+ (instancetype)getBodyReportListWithPage:(NSNumber *)page rows:(NSNumber *)rows userType:(NSNumber *)userType puserId:(NSNumber *)puserId;
@property (nonatomic, strong) HJBodyReportModel *data;

@end

@interface HJBodyReportModel : HJBaseModel
@property (nonatomic, strong) NSArray *bodyReportList;
@end

@interface HJBodyReportListModel : HJBaseModel

@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSString *Id;
@end
