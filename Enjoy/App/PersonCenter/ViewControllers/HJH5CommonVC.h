//
//  HJBodyDataDetailVC.h
//  Enjoy
//
//  Created by IMAC on 16/4/23.
//  Copyright © 2016年 hejing. All rights reserved.
//

typedef enum : NSUInteger {
    HJManage_Note,
    HJPublic_Class,
    HJThinBible,
} HJManageNoteType;

@interface HJH5CommonVC : UIViewController
@property (nonatomic, assign) BOOL hiddenNavigation;
@property (nonatomic, assign) HJH5_InterfaceType h5_InterfaceType;
@property (nonatomic, assign) HJManageNoteType manage_type;
//资讯列表参数栏目Id
@property (nonatomic, strong) NSString *columnId;
//减肥记录参数
@property (nonatomic, strong) NSString *bigTime;

//身体数据报告详情参数
@property (nonatomic, strong) NSString *bodyReportId;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *bodyUserType;

//健康报告详情参数
@property (nonatomic, strong) NSString *healthReportId;

//围度参数
@property (nonatomic, strong) NSNumber *purseId;
//1.本人  2.家庭用户  （围度)
@property (nonatomic, strong) NSNumber *userType;

//在线留言
@property (nonatomic, strong) NSString *wteacherId;
//
@property (nonatomic, assign) BOOL BtnIsShow;

//判断返回（使用）
@property (nonatomic,assign ) NSInteger bodyType;
@property (nonatomic, assign) NSInteger backType;
//

@end
