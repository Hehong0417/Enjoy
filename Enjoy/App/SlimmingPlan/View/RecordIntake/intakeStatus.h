//
//  intakeStatus.h
//  Enjoy
//
//  Created by IMAC on 16/3/15.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HJThinPlanHomeAPI.h"
@class intakeStatus;
@interface intakeStatus : NSObject
/**
 *  早餐
 */
@property (nonatomic, copy) HJThinPlanHomeModel *breakfastDic;
/**
 *  午餐
 */
@property (nonatomic, copy) HJThinPlanHomeModel *lunchDic;
/**
 *  晚餐
 */
@property (nonatomic, copy) HJThinPlanHomeModel *dinnerDic;
/**
 *  额外
 */
@property (nonatomic, copy) HJThinPlanHomeModel *additionalDic;

-(void)initIntakeStatus:(HJThinPlanHomeModel  *)thinPlanHomeModel;
@end
