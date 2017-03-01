//
//  HJUser.h
//  Bsh
//
//  Created by IMAC on 15/12/25.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import "HJBaseModel.h"
@interface HJLoginModel : HJBaseModel
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *isVip;
@property (nonatomic, strong) NSString *regInfoTag;
@property (nonatomic, strong) NSString *height;
@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *name;
@end

@interface HJUser : HJBaseModel {
    HJLoginModel *_userModel;
}

singleton_h(User)

@property (nonatomic, strong) HJLoginModel *loginModel;

@property (nonatomic, assign) BOOL isRememberPwd;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, assign) BOOL isLogin;

-(BOOL)isFirstEnterApp;
-(void)setIsFirstEnterApp:(BOOL)isFirstEnterApp;

@end
