//
//  HJAddBodyReportAPI.h
//  Enjoy
//
//  Created by IMAC on 16/4/27.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@class HJSlimModel,HJAddBodyReportModel;

@interface HJAddBodyReportAPI : HJBaseAPI

@property (nonatomic, strong) HJAddBodyReportModel *data;

+(instancetype)addBodyReportWithweight:(NSString *)weight bmi:(NSString *)bmi bfr:(NSString *)bfr sfr:(NSString *)sfr uvi:(NSString *)uvi rom:(NSString *)rom bmr:(NSString *)bmr bm:(NSString *)bm vwc:(NSString *)vwc  pp:(NSString *)pp userId:(NSNumber *)userId puserId:(NSNumber *)puserId userType:(NSNumber *)userType age:(NSNumber *)age smr:(NSString *)smr adc:(NSString *)adc;
@end

@interface HJAddBodyReportModel : HJBaseModel

@property (nonatomic, assign) NSInteger quantity;

@property (nonatomic, strong) HJSlimModel *slim;

@property (nonatomic, strong) NSArray *slimRecordList;

@property (nonatomic, assign) NSInteger reportId;

@end
@interface HJSlimModel : HJBaseModel

@property (nonatomic, copy) NSString *Id;

@property (nonatomic, copy) NSString *endTime;

@property (nonatomic, copy) NSString *StartTime;

@property (nonatomic, assign) NSInteger userId;
@end