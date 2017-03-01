//
//  HJBeginSportAPI.h
//  Enjoy
//
//  Created by IMAC on 16/4/25.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"
@class HJRecommentSportModel,HJBeginSportModel;
@interface HJBeginSportAPI : HJBaseAPI
@property (nonatomic, strong) HJBeginSportModel *data;
+(instancetype)getBeginSportData;
@end
@interface HJBeginSportModel : HJBaseModel
@property (nonatomic, copy) NSString *advice;

@property (nonatomic, copy) NSString *caloryTime;

@property (nonatomic, strong) NSArray *sportRecordList;

@property (nonatomic, strong) HJRecommentSportModel *recommentSport;
@end

@interface HJRecommentSportModel : HJBaseModel

@property (nonatomic, copy) NSString *remark;

@property (nonatomic, assign) NSInteger calory;

@property (nonatomic, assign) NSInteger time;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) NSInteger sportCategoryId;

@property (nonatomic, copy) NSString *ico;

@property (nonatomic, copy) NSString *gottenTime;

@property (nonatomic, copy) NSString *name;

@end
@interface HJSportrecordModel : HJBaseModel

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *continueTime;

@property (nonatomic, assign) NSInteger outCalory;

@property (nonatomic, assign) NSInteger userId;

@property (nonatomic, assign) NSInteger sportId;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *name;
@end