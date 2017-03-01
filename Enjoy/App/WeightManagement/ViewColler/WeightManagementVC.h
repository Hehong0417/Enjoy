//
//  WeightManagementVC.h
//  Enjoy
//
//  Created by IMAC on 16/3/22.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJViewController.h"

//体重管理师底部按钮类型
typedef enum : NSUInteger {
    IncreceService_Type,//增值服务
    Detail_Type,//详情
    Charge_Target_Type,//选择计划
} HJconsantType;

@interface WeightManagementVC : HJViewController
@property (nonatomic, strong) NSNumber *puserId;
@property (strong, nonatomic) IBOutlet UIButton *D28Btn;
@property (nonatomic, assign) HJconsantType consantType;
@end
