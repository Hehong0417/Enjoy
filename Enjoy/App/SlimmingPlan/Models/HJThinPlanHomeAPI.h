//
//  HJThinPlanHomeAPI.h
//  Enjoy
//
//  Created by IMAC on 16/4/23.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"
@class HJThinPlanHomeModel;
@interface HJThinPlanHomeAPI : HJBaseAPI
@property (nonatomic, strong) HJThinPlanHomeModel *data;
+(instancetype)getThinPlanHomeData;
@end
@interface HJThinPlanHomeModel: HJBaseModel
@property (nonatomic, copy) NSString *weight;

@property (nonatomic, copy) NSString *target;

@property (nonatomic, strong) NSArray *bigFoodRecordList;

@property (nonatomic, assign) NSInteger changeWeight;

@property (nonatomic, assign) NSInteger totalCalory;

@property (nonatomic, assign) NSInteger designCalory;

@property (nonatomic, assign) NSInteger designSportCalory;

@property (nonatomic, copy) NSString *sportOutCalory;

@property (nonatomic, assign) NSInteger continueDays;

@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *isMember;
@property (nonatomic, strong) NSString *isMenstruation;
@end
@interface HJBigFoodRecordModel : HJBaseModel

@property (nonatomic, strong) NSArray *foodRecordList;
@property (nonatomic, assign) NSInteger eatType;

@property (nonatomic, copy) NSString *eatTypeMsg;

@property (nonatomic, assign) CGFloat height;

@end
@interface HJFoodRecord : HJBaseModel
@property (nonatomic, strong) NSString *foodName;

@property (nonatomic, strong) NSString *quantity;

@property (nonatomic, strong) NSString *inCalory;

@property (nonatomic, strong) NSString *outCalory;

@property (nonatomic, strong) NSNumber *foodId;

@end