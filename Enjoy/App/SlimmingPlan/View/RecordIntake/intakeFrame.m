//
//  intakeFrame.m
//  Enjoy
//
//  Created by IMAC on 16/3/15.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "intakeFrame.h"
#import "intakeStatus.h"
#import "HJThinPlanHomeAPI.h"
@implementation intakeFrame
/**
 *  获得模型数据之后, 根据数据计算子控件frame
 */
-(void)setStatus:(intakeStatus *)status{
    _status = status;
    HJBigFoodRecordModel *mode1 = (HJBigFoodRecordModel*)status.breakfastDic;
    HJBigFoodRecordModel *mode2 = (HJBigFoodRecordModel*)status.lunchDic;
    HJBigFoodRecordModel *mode3 = (HJBigFoodRecordModel*)status.dinnerDic;
    HJBigFoodRecordModel *mode4 = (HJBigFoodRecordModel*)status.additionalDic;
    
    float height = 150;
    //早餐是否有数据
    NSArray *breakfastArr = mode1.foodRecordList;
    if (breakfastArr.count!=0) {
        height = height+38+breakfastArr.count*30;
    }
    
    //午餐是否有数据
    NSArray *lunchtArr = mode2.foodRecordList;
    if (lunchtArr.count!=0) {
        height = height+38+lunchtArr.count*30;
    }
    
    //晚餐是否有数据
    NSArray *dinnerArr = mode3.foodRecordList;
    if (dinnerArr.count!=0) {
        height = height+38+dinnerArr.count*30;
    }
    
    //额外是否有数据
    NSArray *additionalArr = mode4.foodRecordList;
    if (additionalArr.count!=0) {
        height = height+38+additionalArr.count*30;
    }
    _cellHeight = height;
}

@end
