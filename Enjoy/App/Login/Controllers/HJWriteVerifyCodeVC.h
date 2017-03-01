//
//  HJWriteVerifyCodeVC.h
//  Enjoy
//
//  Created by IMAC on 16/2/25.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import "HJViewController.h"
#import "HJUserInfoSTVC.h"

@interface HJWriteVerifyCodeVC : HJViewController
@property (nonatomic, weak) id<ReturnDataDelagate> dataDelegate;
@property (nonatomic, strong) NSString *phoneNum;
@property (nonatomic, assign) NSInteger startTime;
@property (nonatomic, assign) HJReg_ForgetPwd_Type reg_ForgetPwd_Type ;
@property (nonatomic, assign) HJRegular_OtherLogin_Type loginType;
@end
