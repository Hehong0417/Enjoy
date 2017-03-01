//
//  HJsetPwdVC.h
//  Enjoy
//
//  Created by IMAC on 16/2/25.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import "HJViewController.h"

@interface HJsetPwdVC : HJViewController
@property (nonatomic, strong) NSString *shortMsgCode;
@property (nonatomic, strong) NSString *phoneNum;
@property (nonatomic, assign) HJReg_ForgetPwd_Type reg_ForgetPwd_Type;
@property (nonatomic, assign) HJRegular_OtherLogin_Type loginType;
@end
