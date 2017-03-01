//
//  HJWriteVerifyCodeVC.m
//  Enjoy
//
//  Created by IMAC on 16/2/25.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import "HJWriteVerifyCodeVC.h"
#import "HJsetPwdVC.h"
#import "LHVerifyCodeButton.h"
#import "HJGetCaptchaAPI.h"
#import "HJCheckShortMsgCodeAPI.h"
#import "HJBindThirdAccountAPI.h"
#import "HJQQInfoModel.h"
#import "HJwriteUserInfoTVC.h"
#import "HJTabBarController.h"
#import "ChangeTarget.h"
#import "HJSurver.h"
#import "HJConnectFatScaleVC.h"
#import "HJWXInfoModel.h"
#import "HJUser.h"

@interface HJWriteVerifyCodeVC ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet LHVerifyCodeButton *sendAgainBtn;
@property (strong, nonatomic) IBOutlet UILabel *sendVerifyHintLab;
@property (strong, nonatomic) IBOutlet UITextField *verifyCodeTF;
@property (strong, nonatomic) IBOutlet UIButton *nextBtn;
@end
@implementation HJWriteVerifyCodeVC

#pragma mark - HJViewControllerProtocol
- (void)doSomeThingInViewDidLoad
{
  self.title = @"填写验证码";
  self.sendVerifyHintLab.text = [NSString stringWithFormat:@"我们已给你的手机号码%@发送了一条验证短信",self.phoneNum];
  self.nextBtn.backgroundColor = KbtnBackColor;
  [self.nextBtn setTitleColor:kGrayColor forState:UIControlStateNormal];
  [self.sendAgainBtn startTimer:self.startTime];
  [self.sendAgainBtn setBackgroundColor:kLightGrayColor];
  self.verifyCodeTF.delegate = self;
}
#pragma mark - Actions
- (IBAction)sendAginAct:(UIButton *)sender {

    [[[HJGetCaptchaAPI getCaptchaWith:self.phoneNum] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
        HJGetCaptchaAPI *api = responseObject;
        if (api.code == 1) {
            [SVProgressHUD showInfoWithStatus:@"短信验证码已发送！"];
            //data整数
            [self.sendAgainBtn startTimer:api.data];
            [self.sendAgainBtn setBackgroundColor:kLightGrayColor];
        }else
        {
            [SVProgressHUD showErrorWithStatus:@"获取短信验证码失败！"];
        }
     }];
}
#pragma mark - textfieldDelegate限制手机号为11位
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (toBeString.length > 6 && range.length!=1){
        textField.text = [toBeString substringToIndex:6];
        return NO;
    }
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.nextBtn.backgroundColor = APP_COMMON_COLOR;
    [self.nextBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
}
- (IBAction)next:(id)sender {
    if (self.verifyCodeTF.text.length == 0) {
        
        [SVProgressHUD showInfoWithStatus:@"请填写验证码"];
    }else {
        //验证验证码
        [[[HJCheckShortMsgCodeAPI checkShortMsgCodeWithtelephone:self.phoneNum shortMsgCode:self.verifyCodeTF.text] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
            HJCheckShortMsgCodeAPI *api = responseObject;
            if (api.code == 1) {
                if (api.data == 1) {
                    if (self.reg_ForgetPwd_Type == HJForgetType) {
                       [self  validVerifyCodeSuccess];
                    }else {
                  //手机号存在，直接调用绑定接口
                     if (self.loginType == HJQQ_login_Type) {
                      HJQQInfoModel *qqModel = [HJQQInfoModel read];
                         
                      [self bindThirdWithAcount:qqModel.account NickName:qqModel.name icon:qqModel.icon];
                         
                        }else {
                            HJWXInfoModel *wxModel = [HJWXInfoModel read];
                            [self bindThirdWithAcount:wxModel.account NickName:wxModel.name icon:wxModel.icon];
                        }
                    }
                }else {
                    //继续执行注册操作
                     [self validVerifyCodeSuccess];
                }

            }else {
                [SVProgressHUD showInfoWithStatus:@"短信验证码输入错误!"];
            }
        }];
        
    }
}

#pragma mark - Methods

- (void)bindThirdWithAcount:(NSString *)account NickName:(NSString *)nickName icon:(NSString *)icon{
    
    [[[HJBindThirdAccountAPI bindThirdAccountWithtelephone:self.phoneNum account:account thirdNickName:nickName type:@2 icon:icon] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
            HJBindThirdAccountAPI *api =  responseObject;
            if (api.code == 1) {
                //绑定手机号成功-->
                HJUser *user = [HJUser sharedUser];
                user.loginModel = [HJLoginModel new];
                user.loginModel.token = api.data.token;
                user.loginModel.userId = api.data.userId;
                user.loginModel.regInfoTag = api.data.regInfoTag;
                user.loginModel.isVip = api.data.isVip;
                user.loginModel.age = api.data.age;
                user.loginModel.name = api.data.name;
                user.loginModel.sex = api.data.sex;
                user.loginModel.height = api.data.height;
                [user write];
                [self saveDataToFatScale:api.data];
                switch ([api.data.regInfoTag integerValue]) {
                    case -10000:{
                        HJTabBarController *tab = [[HJTabBarController alloc]init];
                        [UIApplication sharedApplication].keyWindow.rootViewController = tab;
                    }
                        break;
                    case -10001:{
                        [self.navigationController pushVC:[ChangeTarget new]];
                    }
                        break;
                    case -10002:{
                        HJSurver *vc = [HJSurver new];
                        [self.navigationController pushVC:vc];
                    }
                        break;
                    case -10003:{
                        HJConnectFatScaleVC *fatScalVC = (HJConnectFatScaleVC *)[UIViewController lh_createFromStoryboardName:SB_LOGIN  WithIdentifier:@"HJConnectFatScaleVC"];
                        fatScalVC.puserId = api.data.userId;
                        fatScalVC.userType = 1;
                        fatScalVC.fatScaleType = 1;
                        [self.navigationController pushVC:fatScalVC];
                    }
                        break;
                    case -10004:{
                        HJwriteUserInfoTVC *userInfoVC = [[HJwriteUserInfoTVC alloc]init];
                        userInfoVC.userId = api.data.userId;
                        userInfoVC.token = api.data.token;
                        [self.navigationController pushVC:userInfoVC];
                    }
                        break;
                }
                
            }else {
                [SVProgressHUD showSuccessWithStatus:@"绑定失败！"];
            }
        }];
}
- (void)saveDataToFatScale:(HJBindModel *)bindModel{
    
    MasterSHAinfo *model = [MasterSHAinfo read];
    
    NSString *userSex = bindModel.sex?@"女":@"男";
    NSString *userAge = bindModel.age;
    NSString *userHeight = bindModel.height;
    
    model.userSex = userSex;
    model.userAge = userAge;
    model.userHeight = userHeight;
    [model write];
    if ( [self.dataDelegate respondsToSelector:@selector(responeData:)]) {
        [self.dataDelegate responeData:model];
    }
}

- (void)validVerifyCodeSuccess{
    
    HJsetPwdVC *setPwdVC = (HJsetPwdVC *)[UIViewController lh_createFromStoryboardName:SB_LOGIN WithIdentifier:@"HJsetPwdVC"];
    setPwdVC.shortMsgCode = self.verifyCodeTF.text;
    setPwdVC.phoneNum = self.phoneNum;
    
    if (self.reg_ForgetPwd_Type == HJRegisterType) {
        //快速注册
        setPwdVC.reg_ForgetPwd_Type = HJRegisterType;
        
        setPwdVC.loginType = self.loginType;
        
        [self.navigationController pushVC:setPwdVC];
        
    }else {
        //忘记密码
        setPwdVC.reg_ForgetPwd_Type = HJForgetType;
        [self.navigationController pushVC:setPwdVC];
    }
  
}

#pragma mark - HJDataHandlerProtocol



#pragma mark - Setter&Getter


@end
