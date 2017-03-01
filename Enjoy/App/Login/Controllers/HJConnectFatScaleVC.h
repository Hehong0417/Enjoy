//
//  HJConnectFatScaleVC.h
//  Enjoy
//
//  Created by IMAC on 16/4/20.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJViewController.h"

@interface HJConnectFatScaleVC : UIViewController
@property (nonatomic, strong) NSString *puserId;
@property (nonatomic, assign) NSInteger userType;////1:本人 2:家庭用户 3.游客
@property (nonatomic, assign) NSInteger fatScaleType;//1:填写个人资料 2:瘦身计划 3:家庭用户

@property (nonatomic, assign) NSInteger visitorType;
@end
