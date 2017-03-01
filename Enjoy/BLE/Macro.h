//
//  Macro.h
//  BLE_AiCare
//
//  Created by gorson on 7/20/15.
//  Copyright (c) 2015 percy_yang. All rights reserved.
//

#ifndef BLE_AiCare_Macro_h
#define BLE_AiCare_Macro_h

// self的宽度和高度
#define selfWidth self.bounds.size.width
#define selfHeight self.bounds.size.height

// 物理屏幕高度和宽度
#define IphoneWidth [UIScreen mainScreen].bounds.size.width
#define IphoneHeight [UIScreen mainScreen].bounds.size.height

// 判断是否系统版本小于IOS7的
#define LessThanIOS7 __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
// 判断是否系统版本大于等于IOS7的
#define MoreThanIOS7 __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_7_0

// 程序主窗体
#define KeyWindow [UIApplication sharedApplication].keyWindow

// 用户登录状态(unlogin/login)
#define LOGINSTATUS [[NSUserDefaults standardUserDefaults]valueForKey:@"loginStatus"]

#endif
