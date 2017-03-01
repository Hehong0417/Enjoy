//
//  HJhealthReportListAPI.h
//  Enjoy
//
//  Created by IMAC on 16/4/29.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"
@class healthReportListModel;
@interface HJhealthReportListAPI : HJBaseAPI
@property (nonatomic, strong) healthReportListModel *data;
+(instancetype)getHealthReportListWithPage:(NSNumber *)page rows:(NSNumber *)rows;
@end
@interface healthReportListModel : HJBaseModel

@property (nonatomic, strong) NSArray *healthReportList;
@end
@interface healthArrModel : HJBaseModel

@property (nonatomic, copy) NSString *foodProject;

@property (nonatomic, assign) NSInteger userId;

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, copy) NSString *sportProject;

@property (nonatomic, copy) NSString *gegeContent;

@property (nonatomic, copy) NSString *deadline;

@property (nonatomic, copy) NSString *healthContent;

@property (nonatomic, copy) NSString *telephone;

@property (nonatomic, copy) NSString *createTime;

@end