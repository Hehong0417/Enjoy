//
//  Constant.h
//  Enjoy
//
//  Created by IMAC on 16/3/14.
//  Copyright © 2016年 hejing. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

//设备宽高
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define KDeviceHeight [UIScreen mainScreen].bounds.size.height

//获得RGB颜色
#define IWColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

//判断是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

#endif /* Constant_h */
