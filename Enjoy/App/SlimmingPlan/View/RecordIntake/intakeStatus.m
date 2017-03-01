//
//  intakeStatus.m
//  Enjoy
//
//  Created by IMAC on 16/3/15.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "intakeStatus.h"
@implementation intakeStatus

-(void)initIntakeStatus:(HJThinPlanHomeModel  *)thinPlanHomeModel{
    /** 导入数据 */
    for (int i = 0; i<thinPlanHomeModel.bigFoodRecordList.count; i++) {
        HJBigFoodRecordModel *model= thinPlanHomeModel.bigFoodRecordList[i];
        switch (model.eatType) {
            case 1:
                _breakfastDic = (HJThinPlanHomeModel*)model;
                break;
            case 2:
                _lunchDic = (HJThinPlanHomeModel*)model;
                break;
            case 3:
                _dinnerDic = (HJThinPlanHomeModel*)model;
                break;
            default:
                _additionalDic = (HJThinPlanHomeModel*)model;
                break;
        }
    }
}
@end
