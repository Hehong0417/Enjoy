//
//  UserInfoModel.h
//  BLE_AiCare
//
//  Created by percy on 15/11/10.
//  Copyright © 2015年 com.percy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject


@property (nonatomic) float weightsum;           //重量

@property (nonatomic) float BMI;               //BMI

@property (nonatomic) float fatRate;           //体脂率

@property (nonatomic) float muscle;            //肌肉

@property (nonatomic) float moisture;          //水分

@property (nonatomic) float boneMass;          //骨量

@property (nonatomic) float subcutaneousFat;   //皮下脂肪

@property (nonatomic) float BMR;               //基础代谢率

@property (nonatomic) float proteinRate;       //蛋白率

@property (nonatomic) float visceralFat;       //内脏脂肪

@property (nonatomic) float physicalAge;       //生理年龄

@property (nonatomic) int newAdc;              //阻抗值

@property (nonatomic) double smr;               //骨骼机率

@property (nonatomic) NSString *cheng;        //设备的类型


-(void)saveData:(NSArray *)dataArr;


@end
