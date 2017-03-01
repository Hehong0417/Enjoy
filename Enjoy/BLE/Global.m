//
//  Global.m
//  BLE_AiCare
//
//  Created by percy on 15/11/9.
//  Copyright © 2015年 com.percy. All rights reserved.
//

#import "Global.h"

@implementation Global

+ (Global *)SharedInstance
{
    static Global *global = nil;
    if (global == nil) {
//        global = [[Global alloc] init];
        global = [[super allocWithZone:NULL] init];
    }
    return global;
}




//计算BMI值
+ (float)getBMIVaule:(NSString *)height weight:(NSString *)weight
{
    float BMI = weight.floatValue/(height.floatValue/100 * height.floatValue/100);
    
    return BMI;
}

@end
