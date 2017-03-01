//
//  HJRegisterVC.m
//  Enjoy
//
//  Created by IMAC on 16/2/25.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import "HJRegisterVC.h"
#import "HJWriteVerifyCodeVC.h"
#import "HJcheckPhoneAPI.h"
#import "HJGetCaptchaAPI.h"

@interface HJRegisterVC ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *phoneTF;
@property (strong, nonatomic) IBOutlet UIButton *nextBtn;
@end

@implementation HJRegisterVC

#pragma mark - HJViewControllerProtocol
- (void)doSomeThingInViewDidLoad {
  self.title = @"填写手机号";
    self.phoneTF.delegate = self;
    [self.nextBtn setTitleColor:kGrayColor forState:UIControlStateNormal];
    self.nextBtn.backgroundColor = KbtnBackColor;
}
#pragma mark - Actions
- (IBAction)next:(id)sender {
    if (self.phoneTF.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"手机号不能为空！"];
    }else {
    BOOL isValid = [self isvalidateMobile:self.phoneTF.text];
      if (isValid) {
        [self checkPhoneOnly];
      }else {
        [SVProgressHUD showInfoWithStatus:@"手机号无效！"];
      }
   }
}
#pragma mark - Methods

#pragma mark-判断是否为有效的手机号
-(BOOL)isvalidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}
#pragma mark - textfieldDelegate限制手机号为11位
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (toBeString.length > 11 && range.length!=1){
        textField.text = [toBeString substringToIndex:11];
        return NO;
    }
    
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.nextBtn.backgroundColor = APP_COMMON_COLOR;
    [self.nextBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
}
#pragma mark-手机号唯一性验证
- (void)checkPhoneOnly
{
    HJCheckPhoneAPI *api = [HJCheckPhoneAPI checkPhoneWith:self.phoneTF.text];
    [[api netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
        HJCheckPhoneAPI *api = responseObject;
        if (self.Reg_ForgetPwd_Type == HJRegisterType) {
            
            if (self.logintype == HJRegular_Login_Type) {
                //普通账号注册
                if (api.code == 1) {
                    //发送验证码
                    [self sendverifyCodeRequest];
                }else {
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    [SVProgressHUD showInfoWithStatus:@"手机号已注册"];
                }

            }else {
                //第三方注册
                [self sendverifyCodeRequest];
                            }
            //==========//
           
        }else {//忘记密码
            if (api.code == 0) {
                //发送验证码
                [self sendverifyCodeRequest];
            }else {
                [SVProgressHUD showInfoWithStatus:@"请先进行注册"];
            }
            
        }
    
    }];
}

#pragma mark-发送验证码请求
- (void)sendverifyCodeRequest
{
    [[[HJGetCaptchaAPI getCaptchaWith:self.phoneTF.text] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
        HJGetCaptchaAPI *api = responseObject;
            if (api.code == 1) {
                HJWriteVerifyCodeVC *verifyCodeVC = (HJWriteVerifyCodeVC *)[UIViewController lh_createFromStoryboardName:@"Login" WithIdentifier:@"HJWriteVerifyCodeVC"];
                verifyCodeVC.phoneNum = self.phoneTF.text;
                verifyCodeVC.startTime = api.data;
                //注册
                if (self.Reg_ForgetPwd_Type == HJRegisterType) {
                    verifyCodeVC.reg_ForgetPwd_Type = HJRegisterType;
                    
                    verifyCodeVC.loginType = self.logintype;
                    
                    [SVProgressHUD showSuccessWithStatus:@"发送验证码成功！"];
                    [self.navigationController pushVC:verifyCodeVC];

                }else {
                    //忘记密码
                    verifyCodeVC.reg_ForgetPwd_Type = HJForgetType;
                        [SVProgressHUD showSuccessWithStatus:@"发送验证码成功！"];
                    
                    [self.navigationController pushVC:verifyCodeVC];
                }
            }else
            {
                [SVProgressHUD showErrorWithStatus:@"获取短信验证码失败！"];
            }
            }];
}

#pragma mark - HJDataHandlerProtocol



#pragma mark - Setter&Getter



@end
