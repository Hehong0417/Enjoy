//
//  UserInfoObject.h
//  GameH
//
//  Created by IMAC on 16/4/12.
//  Copyright © 2016年 FR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HJUserDetailAPI.h"
#define k_UserInfo_token @"token"
#define k_UserInfo_userId @"userId"
#define k_UserInfo_userName @"userName"
#define k_UserInfo_userDateBirth @"userDateBirth"
#define k_UserInfo_userHeight @"userHeight"
#define k_UserInfo_userJoin @"userJoin"
#define k_UserInfo_userAddress @"userAddress"
#define k_UserInfo_userSex @"userSex"
@interface UserInfoObject : HJBaseModel

@property(nonatomic,copy)   NSString *userId;
@property(nonatomic,copy)   NSString *token;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userDateBirth;
@property (nonatomic, strong) NSString *userHeight;
@property (nonatomic, strong) NSString *userJoin;
@property (nonatomic, strong) NSString *userAddress;
@property (nonatomic, strong) NSString *userSex;

+(UserInfoObject *)currentUser;

/**
 *  保存用户ID
 */
-(void)saveUserId:(NSString *)userID;

/**
 *  保存token
 */
-(void)saveUserToken:(NSString *)token;

/**
 *  一键保存用户个人资料所有信息
 */
-(void)saveUserInfo:(HJUserDetailModel *)model;

/**
 *  保存用户昵称
 */
-(void)saveUserName:(NSString *)name;

/**
 *  保存用户出生年月
 */
-(void)saveUserBirth:(NSString *)birth;

/**
 *  保存用户身高
 */
-(void)saveUserHeight:(NSString *)height;

/**
 *  保存用户职业
 */
-(void)saveUserJoin:(NSString *)join;

/**
 *  保存用户地区
 */
-(void)saveUserAddress:(NSString *)address;

/**
 *  保存用户性别
 */
-(void)saveUserSex:(NSString *)sex;

/**
 *  退出
 */
-(void)logOut;

@end
