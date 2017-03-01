//
//  UserInfoObject.m
//  GameH
//
//  Created by IMAC on 16/4/12.
//  Copyright © 2016年 FR. All rights reserved.
//

#import "UserInfoObject.h"

@implementation UserInfoObject

+(UserInfoObject *)currentUser
{
    static UserInfoObject *_share=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _share=[[UserInfoObject alloc] init];
    });
    return _share;
}

-(id)init
{
    if (self=[super init]) {
        NSString *token=[[NSUserDefaults standardUserDefaults] stringForKey:k_UserInfo_token];
        NSString *userId=[[NSUserDefaults standardUserDefaults] stringForKey:k_UserInfo_userId];
        NSString *userName=[[NSUserDefaults standardUserDefaults] stringForKey:k_UserInfo_userName];
        NSString *userDateBirth = [[NSUserDefaults standardUserDefaults] valueForKey:k_UserInfo_userDateBirth];
        NSString *userHeight = [[NSUserDefaults standardUserDefaults] valueForKey:k_UserInfo_userHeight];
        NSString *userJoin = [[NSUserDefaults standardUserDefaults] valueForKey:k_UserInfo_userJoin];
        NSString *userAddress = [[NSUserDefaults standardUserDefaults] valueForKey:k_UserInfo_userAddress];
        NSString *userSex = [[NSUserDefaults standardUserDefaults] valueForKey:k_UserInfo_userSex];
        
        self.token=token;
        self.userId=userId;
        self.userName=userName;
        self.userDateBirth=userDateBirth;
        self.userHeight=userHeight;
        self.userJoin=userJoin;
        self.userAddress=userAddress;
        self.userSex=userSex;
    }
    return self;
}

/**
 *  退出登录
 */
-(void)logOut
{
    self.token=@"";
    self.userId=@"";
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:k_UserInfo_userId];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:k_UserInfo_token];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:k_UserInfo_userName];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:k_UserInfo_userDateBirth];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:k_UserInfo_userHeight];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:k_UserInfo_userJoin];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:k_UserInfo_userAddress];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:k_UserInfo_userSex];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 *  保存用户ID
 */
-(void)saveUserId:(NSString *)userID{
    self.userId=userID;
    NSUserDefaults * ud =[NSUserDefaults standardUserDefaults];
    [ud setObject:userID forKey:k_UserInfo_userId];
    [ud synchronize];
}

/**
 *  保存token
 */
-(void)saveUserToken:(NSString *)token{
    self.token=token;
    NSUserDefaults * ud =[NSUserDefaults standardUserDefaults];
    [ud setObject:token forKey:k_UserInfo_token];
    [ud synchronize];
}

/**
 *  一键保存用户个人资料所有信息
 */
-(void)saveUserInfo:(HJUserDetailModel *)model{
    [self saveUserName:model.name];
    [self saveUserBirth:model.birthday];
    [self saveUserHeight:model.height];
    [self saveUserJoin:model.job];
    [self saveUserSex:[NSString stringWithFormat:@"%ld",(long)model.sex]];
}

/**
 *  保存用户昵称
 */
-(void)saveUserName:(NSString *)name{
    self.userName=name;
    NSUserDefaults * ud =[NSUserDefaults standardUserDefaults];
    [ud setObject:name forKey:k_UserInfo_userName];
    [ud synchronize];
}

/**
 *  保存用户出生年月
 */
-(void)saveUserBirth:(NSString *)birth{
    self.userDateBirth=birth;
    NSUserDefaults * ud =[NSUserDefaults standardUserDefaults];
    [ud setObject:birth forKey:k_UserInfo_userDateBirth];
    [ud synchronize];
}

/**
 *  保存用户身高
 */
-(void)saveUserHeight:(NSString *)height{
    self.userHeight=height;
    NSUserDefaults * ud =[NSUserDefaults standardUserDefaults];
    [ud setObject:height forKey:k_UserInfo_userHeight];
    [ud synchronize];
}

/**
 *  保存用户职业
 */
-(void)saveUserJoin:(NSString *)join{
    self.userJoin=join;
    NSUserDefaults * ud =[NSUserDefaults standardUserDefaults];
    [ud setObject:join forKey:k_UserInfo_userJoin];
    [ud synchronize];
}

/**
 *  保存用户地区
 */
-(void)saveUserAddress:(NSString *)address{
    self.userAddress=address;
    NSUserDefaults * ud =[NSUserDefaults standardUserDefaults];
    [ud setObject:address forKey:k_UserInfo_userAddress];
    [ud synchronize];
}

/**
 *  保存用户性别
 */
-(void)saveUserSex:(NSString *)sex{
    self.userSex=sex;
    NSUserDefaults * ud =[NSUserDefaults standardUserDefaults];
    [ud setObject:sex forKey:k_UserInfo_userSex];
    [ud synchronize];
}



@end
