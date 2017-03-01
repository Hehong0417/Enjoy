//
//  HJLoginVC.m
//  Enjoy
//
//  Created by IMAC on 16/2/25.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import "HJLoginVC.h"
#import "HJRegisterVC.h"
#import "HJTabBarController.h"
#import "HJwriteUserInfoTVC.h"
#import "HJLoginAPI.h"
#import "HJUserDetailAPI.h"
#import "MasterSHAinfo.h"

#import "UMSocial.h"
#import "WXApiObject.h"
#import "WXApi.h"
#import "HJQQInfoModel.h"
#import "HJWXInfoModel.h"
#import "BluetoothManager.h"
#import "HJConnectFatScaleVC.h"

#import "HJSurver.h"
#import "ChangeTarget.h"

@interface HJLoginVC ()<UITextFieldDelegate, WXApiDelegate>
{
    HJUser *user1;
}
@property (strong, nonatomic) IBOutlet UITextField *phoneNumTF;
@property (strong, nonatomic) IBOutlet UITextField *PwdTF;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@end

@implementation HJLoginVC


#pragma mark - HJViewControllerProtocol

- (void)doSomeThingInViewDidLoad {
    self.phoneNumTF.delegate = self;
    self.iconView.image = kImageNamed(@"ic_logo");
    [self.iconView lh_setCornerRadius:39 borderWidth:0 borderColor:kClearColor];
}

#pragma mark - Actions

- (IBAction)registerQuick:(id)sender {
    //HJwriteUserInfoTVC *userInfoVC = [[HJwriteUserInfoTVC alloc]init];
   // [self.navigationController pushVC:userInfoVC];
    
    HJRegisterVC *wPhoneNumVC = (HJRegisterVC *)[UIViewController lh_createFromStoryboardName:SB_LOGIN WithIdentifier:@"HJRegisterVC"];
    wPhoneNumVC.Reg_ForgetPwd_Type = HJRegisterType;
    wPhoneNumVC.logintype = HJRegular_Login_Type;
    [self.navigationController pushVC:wPhoneNumVC];

}
- (IBAction)forgetPwd:(id)sender {
    
    HJRegisterVC *wPhoneNumVC = (HJRegisterVC *)[UIViewController lh_createFromStoryboardName:SB_LOGIN WithIdentifier:@"HJRegisterVC"];
    wPhoneNumVC.Reg_ForgetPwd_Type = HJForgetType;
    [self.navigationController pushVC:wPhoneNumVC];
}
- (NSString *)isValid {
    
    if (self.phoneNumTF.text.length == 0) {
        return @"请输入手机号！";
    }else if (self.PwdTF.text.length == 0){
        return @"请输入6-20位密码！";
    }
    return nil;
}
- (IBAction)login:(id)sender {
    
    NSString *isValid = [self isValid];
    if (isValid) {
        [SVProgressHUD showInfoWithStatus:isValid];
    }else {
    NSString *account = self.phoneNumTF.text;
    NSString *pwdMd5 = [self.PwdTF.text md5String];
    [[[HJLoginAPI loginWithAccount:account loginType:@1 password:pwdMd5] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
        HJLoginAPI *api = responseObject;
        if (api.code == 1) {
            
            user1 = [HJUser sharedUser];
            user1.loginModel = api.data;
            
            if ([user1.loginModel.regInfoTag integerValue]==-10000) {
                user1.isLogin = YES;
                
            }else{
                user1.isLogin = NO;
            }
            
            [user1 write];
            [self loginsuccess];
        }
    }];
    }
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

#pragma mark- methods
- (void)loginsuccess {

        switch ([user1.loginModel.regInfoTag integerValue]) {
            case -10000:{
                MasterSHAinfo *model = [MasterSHAinfo read];
                
                NSString *userSex = user1.loginModel.sex?@"女":@"男";
                NSString *userAge = user1.loginModel.age;
                NSString *userHeight = user1.loginModel.height;
                
                model.userSex = userSex;
                model.userAge = userAge;
                model.userHeight = userHeight;
                [model write];
                
                if ( [self.dataDelegate respondsToSelector:@selector(responeData:)]) {
                    [self.dataDelegate responeData:model];
                }
                
                HJTabBarController *tab = [[HJTabBarController alloc]init];
                [UIApplication sharedApplication].keyWindow.rootViewController = tab;
            }
                break;
            case -10001:{
                MasterSHAinfo *model = [MasterSHAinfo read];
                
                NSString *userSex = user1.loginModel.sex?@"女":@"男";
                NSString *userAge = user1.loginModel.age;
                NSString *userHeight = user1.loginModel.height;
                
                model.userSex = userSex;
                model.userAge = userAge;
                model.userHeight = userHeight;
                [model write];
                
                if ( [self.dataDelegate respondsToSelector:@selector(responeData:)]) {
                    [self.dataDelegate responeData:model];
                }
                [self.navigationController pushVC:[ChangeTarget new]];
            }
                break;
            case -10002:{
                MasterSHAinfo *model = [MasterSHAinfo read];
                
                NSString *userSex = user1.loginModel.sex?@"女":@"男";
                NSString *userAge = user1.loginModel.age;
                NSString *userHeight = user1.loginModel.height;
                
                model.userSex = userSex;
                model.userAge = userAge;
                model.userHeight = userHeight;
                [model write];
                
                if ( [self.dataDelegate respondsToSelector:@selector(responeData:)]) {
                    [self.dataDelegate responeData:model];
                }
    
                HJSurver *vc = [HJSurver new];
                [self.navigationController pushVC:vc];
            }
                break;
            case -10003:{
                MasterSHAinfo *model = [MasterSHAinfo read];
                
                NSString *userSex = user1.loginModel.sex?@"女":@"男";
                NSString *userAge = user1.loginModel.age;
                NSString *userHeight = user1.loginModel.height;
                
                model.userSex = userSex;
                model.userAge = userAge;
                model.userHeight = userHeight;
                [model write];
                
                if ( [self.dataDelegate respondsToSelector:@selector(responeData:)]) {
                    [self.dataDelegate responeData:model];
                }
                HJConnectFatScaleVC *fatScalVC = (HJConnectFatScaleVC *)[UIViewController lh_createFromStoryboardName:SB_LOGIN  WithIdentifier:@"HJConnectFatScaleVC"];
                fatScalVC.puserId = user1.loginModel.userId;
                fatScalVC.userType = 1;
                fatScalVC.fatScaleType = 1;
                [self.navigationController pushVC:fatScalVC];
            }
                break;
            case -10004:{
                HJwriteUserInfoTVC *userInfoVC = [[HJwriteUserInfoTVC alloc]init];
                userInfoVC.userId = user1.loginModel.userId;
                userInfoVC.token = user1.loginModel.token;
                [self.navigationController pushVC:userInfoVC];
            }
                break;
        }
        
        
    //}];
}


#pragma mark - action
- (IBAction)QQloginClick:(id)sender {
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey: UMShareToQQ];
            NSLog(@"username is %@\n, uid is %@\n, token is %@\n url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);

            HJQQInfoModel *model = [[HJQQInfoModel alloc]init];
            model.name = snsAccount.userName;
            model.account = snsAccount.usid;
            model.icon = snsAccount.iconURL;
            [model write];
            
            //请求qq登录接口
            [[[HJLoginAPI loginWithAccount:snsAccount.usid loginType:@2 password:nil] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
                HJLoginAPI *api = responseObject;
                if (api.code == -2) {
                    //第三方注册
                    HJRegisterVC *wPhoneNumVC = (HJRegisterVC *)[UIViewController lh_createFromStoryboardName:SB_LOGIN WithIdentifier:@"HJRegisterVC"];
                    wPhoneNumVC.Reg_ForgetPwd_Type = HJRegisterType;
                    wPhoneNumVC.logintype = HJQQ_login_Type;
                    [self.navigationController pushVC:wPhoneNumVC];
                    
                }else if(api.code == 1){
                    
                    //账号存在直接登录
                    user1 = [HJUser sharedUser];
                    user1.loginModel = api.data;
                    
                    if ([user1.loginModel.regInfoTag integerValue]==-10000) {
                        user1.isLogin = YES;
                        
                    }else{
                        user1.isLogin = NO;
                    }
                    
                    [user1 write];
                    [self loginsuccess];
                    //
                }
                
            }];
            
        }
    });
    
}
- (IBAction)weichatLoginClick:(id)sender {
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary]valueForKey:UMShareToWechatSession];
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            
            HJWXInfoModel *WxModel = [HJWXInfoModel new];
            WxModel.name = snsAccount.userName;
            WxModel.account = snsAccount.usid;
            WxModel.icon = snsAccount.iconURL;
            [WxModel write];
            //请求微信登录接口
            [[[HJLoginAPI loginWithAccount:snsAccount.usid loginType:@2 password:nil] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
                HJLoginAPI *api = responseObject;
                if (api.code == -2) {
                    //第三方注册
                    HJRegisterVC *wPhoneNumVC = (HJRegisterVC *)[UIViewController lh_createFromStoryboardName:SB_LOGIN WithIdentifier:@"HJRegisterVC"];
                    wPhoneNumVC.Reg_ForgetPwd_Type = HJRegisterType;
                    wPhoneNumVC.logintype = HJWX_login_Type;
                    [self.navigationController pushVC:wPhoneNumVC];
                    
                }else if(api.code == 1){
                    
                    //账号存在直接登录
                    user1 = [HJUser sharedUser];
                    user1.loginModel = api.data;
                    
                    if ([user1.loginModel.regInfoTag integerValue]==-10000) {
                        user1.isLogin = YES;
                        
                    }else{
                        user1.isLogin = NO;
                    }
                    
                    [user1 write];
                    [self loginsuccess];
                    //
                }
                
            }];
        }
    });
    
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.phoneNumTF resignFirstResponder];
    [self.PwdTF resignFirstResponder];
}
#pragma mark - Methods
- (NSData *)setUpMasterDataWithWeight:(NSString *)weight withHight:(NSString *)hight withSex:(NSString *)sex
{
    Byte kByt[8] = {'\0'};
    kByt[0] = 0xac;
    kByt[1] = 0x02;
    kByt[2] = 0xfa;
    if (sex == 0)
    {
        kByt[3] = 0x01;
    }else
    {
        kByt[3] = 0x02;
    }
    kByt[3] = 0x01;
    kByt[4] = 0x00;
    kByt[5] = 0x00;
    kByt[6] = 0xcc;
    kByt[7] = 0xc7;
    
    NSData *data = [[NSData alloc] initWithBytes:kByt length:8];
    return data;
}






#pragma mark - HJDataHandlerProtocol



#pragma mark - Setter&Getter


@end
