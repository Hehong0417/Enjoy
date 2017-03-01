//
//  Global.h
//  BLE_AiCare
//
//  Created by percy on 15/11/9.
//  Copyright © 2015年 com.percy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import <UIKit/UIKit.h>


@interface Global : NSObject

+ (Global *)SharedInstance;
+ (UIViewController *)getDrawerViewcontroller;

@property (nonatomic)NSString *tmp;
@property (nonatomic)NSString *weightUnit;       //重量单位
@property (nonatomic)NSString *currentHeight;    //目前身高
@property (nonatomic)float currentAge;           //当前时代
@property (nonatomic)BOOL isBabyModen;           //婴儿模式
@property (nonatomic)BOOL isGuestModen;          //游客模式




//#error 补全全球文件集
#warning 其实蓝牙出现可以直接share->BLE文件，把暴露的方法直接调用到蓝牙测试页面，取得他们的名字和地址，后点击链接回调回主页面进行测试。


+ (float)getBMIVaule:(NSString *)height weight:(NSString *)weight;

@end
