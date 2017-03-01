//
//  HJsetPwdVC.m
//  Enjoy
//
//  Created by IMAC on 16/2/25.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import "HJsetPwdVC.h"
#import "HJwriteUserInfoTVC.h"
#import "HJRegisterAPI.h"
#import "HJLoginAPI.h"
#import "HJLoginVC.h"
#import "HJFindPasswordAPI.h"
#import "HJUserDetailAPI.h"
#import "HJQQInfoModel.h"
#import "HJWXInfoModel.h"

@interface HJsetPwdVC ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *setPwd;
@property (strong, nonatomic) IBOutlet UITextField *commitPwd;
@property (strong, nonatomic) IBOutlet UIButton *commitBtn;

@end

@implementation HJsetPwdVC


#pragma mark - HJViewControllerProtocol
- (void)doSomeThingInViewDidLoad
{
    if (self.reg_ForgetPwd_Type == HJRegisterType){
         self.title = @"设置密码";
         self.setPwd.placeholder = @"设置密码";
         self.commitPwd.placeholder = @"确认密码";
    }else {
        self.title = @"重置密码";
        self.setPwd.placeholder = @"设置密码";
        self.commitPwd.placeholder = @"确认密码";
    }
    self.setPwd.delegate = self;
    self.commitPwd.delegate = self;
    [self.commitBtn setTitleColor:kGrayColor forState:UIControlStateNormal];
    [self.commitBtn setBackgroundColor:KbtnBackColor];
}
#pragma mark - Actions


#pragma mark - Methods
- (IBAction)commit:(id)sender {
    NSString *isvalid = [self validAllMsg];
    if (isvalid) {
        [SVProgressHUD showInfoWithStatus:isvalid];
     }else {
         if (self.reg_ForgetPwd_Type == HJRegisterType) {
             //注册
             NSString *commitPwdMd5 = [self.commitPwd.text md5String];
             NSString *qqAccount = nil;
             NSString *qqNick = nil;
             NSString *wxAccount = nil;
             NSString *wxNick = nil;
             NSNumber *loginType;
             NSString *account;
             NSString *icon;
             switch (self.loginType) {
                 case HJQQ_login_Type:{
                     HJQQInfoModel *qqModel = [HJQQInfoModel read];
                     qqAccount = qqModel.account;
                     qqNick = qqModel.name;
                     icon = qqModel.icon;
                     loginType = @2;
                     account = qqAccount;
                 }
                     break;
                 case HJWX_login_Type:{
                     HJWXInfoModel *wxModel = [HJWXInfoModel read];
                     wxAccount = wxModel.account;
                     icon = wxModel.icon;
                     wxNick = wxModel.name;
                     loginType = @3;
                     account = wxAccount;

                 }
                     break;
                 default:{
                     //普通登录
                     loginType = @1;
                     account = self.phoneNum;
                 }
                     break;
             }
             
             [[[HJRegisterAPI registerWithPhone:self.phoneNum  captcha:self.shortMsgCode pwd:commitPwdMd5 qqAccount:qqAccount qqNick:qqNick wxAccount:wxAccount wxNick:wxNick icon:icon] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
                 HJRegisterAPI *api = responseObject;
                 if (api.code == 1) {
                     [self login:loginType account:account];
                     
             }else {
                     [SVProgressHUD showErrorWithStatus:@"注册失败！"];
                 }
             }];

         }else {
             //找回密码
            // NSString *setPwd = [self.setPwd.text md5String];
             NSString *newPwdMd5 = [self.commitPwd.text md5String];
             [[[HJFindPasswordAPI findPassword:self.phoneNum shortMsgCode:self.shortMsgCode newPwd:newPwdMd5] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
                 HJFindPasswordAPI *api = responseObject;
                 if (api.code == 1) {
                HJLoginVC *loginVC = (HJLoginVC *)[UIViewController lh_createFromStoryboardName:SB_LOGIN WithIdentifier:@"HJLoginVC"];
                     [SVProgressHUD showSuccessWithStatus:@"修改密码成功！"];
                [self.navigationController pushVC:loginVC];
                 }
             }];
          }
     }
}
- (void)login:(NSNumber *)loginType account:(NSString *)account{
    
    //*****登录******//
    NSString *commitPwdMd5 = [self.commitPwd.text md5String];
    [[[HJLoginAPI loginWithAccount:account loginType:loginType password:commitPwdMd5] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
        HJLoginAPI *api = responseObject;
        if (api.code == 1) {
            HJUser *user = [HJUser sharedUser];
            user.loginModel = api.data;
            user.isLogin = NO;
            [user write];

        //传useId-token
            HJwriteUserInfoTVC *userInfoVC = [[HJwriteUserInfoTVC alloc]init];
            
        //检查是否为空useId-token
            userInfoVC.userId = api.data.userId;
            userInfoVC.token = api.data.token;
            [SVProgressHUD showSuccessWithStatus:@"注册成功！"];
            [self.navigationController pushVC:userInfoVC];
            
        }
    }];
    
    //***************//
}
- (NSString *)validAllMsg{
    if (self.setPwd.text.length == 0) {
        
      return  @"设置密码不能为空！";
        
    }else if(self.setPwd.text.length<6){
        
     return  @"设置密码不能小于6位！";
        
    }else if(self.commitPwd.text.length<6){
        
       return  @"确认密码不能小于6位！";
        
    }else if(self.commitPwd.text.length == 0) {
        
     return  @"请再次输入密码！";
    }else if(![self.commitPwd.text isEqualToString:self.setPwd.text]){
       return  @"两次密码输入不一致";
    }
    return nil;
}
#pragma mark - textfieldDelegate限制手机号为11位

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (toBeString.length > 21 && range.length!=1){
        textField.text = [toBeString substringToIndex:21];
        return NO;
    }
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self.commitBtn setBackgroundColor:APP_COMMON_COLOR];
    [self.commitBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
}
#pragma mark - HJDataHandlerProtocol



#pragma mark - Setter&Getter


@end
