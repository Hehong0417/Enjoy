//
//  WeightManagementVC.m
//  Enjoy
//
//  Created by IMAC on 16/3/22.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "WeightManagementVC.h"
#import "OnlineMessageVC.h"
#import "HJH5CommonVC.h"
#import "HJGetWeightTeacherDataAPI.h"
#import "HJUser.h"
#import "HJConfirmpProjectAPI.h"
#import "HJCallPhoneView.h"

@interface WeightManagementVC ()

@property (strong, nonatomic) IBOutlet UIImageView *photoImg;
@property (strong, nonatomic) IBOutlet UILabel *nameLab;
@property (strong, nonatomic) IBOutlet UIImageView *twoCodeImg;
@property (strong, nonatomic) IBOutlet UIImageView *sexImg;
@property (strong, nonatomic) IBOutlet UIButton *onlineMessageBtn;
@property (nonatomic, strong) NSString *wteacherId;
@property (nonatomic, strong) HJWeightTeacherModel *weightTeacherModel;
@property (nonatomic, weak) HJCallPhoneView *callPhoneView;

@property (strong, nonatomic) IBOutlet UIButton *detailOnlineMsgBtn;
@property (strong, nonatomic) IBOutlet UIButton *AKeyCallBtn;
@property (nonatomic, strong) NSString *telePhone;
@property (strong, nonatomic) IBOutlet UILabel *tipLabel;

@end

@implementation WeightManagementVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getWeightTeacherData];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"体重管理顾问";
    UIButton *rightBtn = [UIButton lh_buttonWithFrame:CGRectMake(0, 0, 30, 30) target:self action:@selector(callWeightManagement) image:[UIImage imageNamed:@"ic_a17_02"]];
    
    switch (self.consantType) {
        case 0:{
            //增值服务
            self.onlineMessageBtn.hidden = NO;
            self.D28Btn.hidden = YES;
            self.detailOnlineMsgBtn.hidden = YES;
            self.AKeyCallBtn.hidden = YES;
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
        }
            break;
        case 1:{
            //详情
            self.onlineMessageBtn.hidden = YES;
            self.D28Btn.hidden = YES;
            self.detailOnlineMsgBtn.hidden = NO;
            self.AKeyCallBtn.hidden = NO;
        }
            break;
        case 2:{
            //选择计划
            self.onlineMessageBtn.hidden = NO;
            self.D28Btn.hidden = NO;
            self.detailOnlineMsgBtn.hidden = YES;
            self.AKeyCallBtn.hidden = YES;
        }
            break;
        default:
            break;
    }
    
    

}

- (void)callWeightManagement
{
    [self.callPhoneView removeFromSuperview];
    HJCallPhoneView *callPhoneView = [HJCallPhoneView callPhoneView];
    self.callPhoneView = callPhoneView;
    callPhoneView.phoneLabel.text = self.weightTeacherModel.telephone;
    [self.view addSubview:callPhoneView];
    WEAK_SELF();
    callPhoneView.certanBlack = ^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",weakSelf.weightTeacherModel.telephone]]];
    };
}


- (void)getWeightTeacherData {
    
    [[[HJGetWeightTeacherDataAPI getWeightTeacherDataWithPuserId:self.puserId] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
        HJGetWeightTeacherDataAPI *api = responseObject;
        if (api.code == 1) {
            self.weightTeacherModel = api.data;
            self.wteacherId = [NSString stringWithFormat:@"%ld",api.data.Id];
            
            NSString *imgName = [api.data.sex isEqualToString:@"男"]?@"ic_c20_3":@"ic_c20_4";
            [self.photoImg sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(api.data.photo)]placeholderImage:kImageNamed(imgName)];
            self.nameLab.text = api.data.name;
            if (api.data.twoCode.length>0) {
                [self.twoCodeImg sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(api.data.twoCode)]placeholderImage:kImageNamed(@"placeholderImage")];
                self.tipLabel.hidden = NO;
            }else{
                self.twoCodeImg.image = [UIImage imageNamed:@""];
                self.tipLabel.hidden = YES;
            }
            self.telePhone = api.data.telephone;
            NSString *sexImgName = [api.data.sex isEqualToString:@"男"]?@"ic_a17_01":@"ic_c1_02";
            self.sexImg.image = kImageNamed(sexImgName);
            
            if ([api.data.twoCode rangeOfString:@"null"].location != NSNotFound) {
                self.twoCodeImg.hidden = YES;
                self.tipLabel.hidden = YES;
            }
            
            switch (self.consantType) {
                case 0:{
                    //增值服务
                    if (api.data.telephone.length == 0) {
                        self.navigationItem.rightBarButtonItem = nil;
                    }
                    self.onlineMessageBtn.hidden = NO;
                    self.D28Btn.hidden = YES;
                    self.detailOnlineMsgBtn.hidden = YES;
                    self.AKeyCallBtn.hidden = YES;
                }
                    break;
                case 1:{
                    //详情
                    if (api.data.telephone.length == 0) {
                        self.AKeyCallBtn.hidden = YES;
                        //改变在线留言的位置
                        CGFloat x = kScreenWidth/2-CGRectGetWidth(self.AKeyCallBtn.frame);
                        CGFloat y = kScreenHeight - 80;
                        CGFloat wid = CGRectGetWidth(self.AKeyCallBtn.frame);
                        self.detailOnlineMsgBtn.frame = CGRectMake(x, y, wid,30);
                    }else {
                        self.AKeyCallBtn.hidden = NO;
                        //改变在线留言的位置

                    }
                    self.onlineMessageBtn.hidden = YES;
                    self.D28Btn.hidden = YES;
                    self.detailOnlineMsgBtn.hidden = NO;
                }
                    break;
                case 2:{
                    //选择计划
                    self.onlineMessageBtn.hidden = NO;
                    self.D28Btn.hidden = NO;
                    self.detailOnlineMsgBtn.hidden = YES;
                    self.AKeyCallBtn.hidden = YES;
                }
                    break;
                default:
                    break;
            }

        }else {
            self.onlineMessageBtn.hidden = YES;
            self.D28Btn.hidden = YES;
        }
    }];
}

- (IBAction)leaveMessage:(id)sender {
    
    [self leaveMessage];
  
}

- (IBAction)D20BtnAction:(id)sender {
    
    HJUser *user = [HJUser read];
    NSInteger isVip = [user.loginModel.isVip isEqualToString:@"1"]?1:0;
    if (isVip) {
       //调选择计划接口
         [self goBackSlimPlan:@4];
        
       }else {
           
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"您尚未购买D28服务，无法制定“D28燃脂肪减6斤以上”计划，请联系体重管理师" delegate:self  cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
        [alert show];
       }
    
}
//一键呼叫
- (IBAction)aKeyCall:(id)sender {

    [self.view telWithPhoneNumber:self.telePhone];
}
//详情在线留言
- (IBAction)detailOnlineMsgBtn:(id)sender {

    [self leaveMessage];
}
- (void)leaveMessage {
    
    HJH5CommonVC *h5commonVC = [[HJH5CommonVC alloc]init];
    h5commonVC.h5_InterfaceType = HJOnline_MessageType;
    h5commonVC.wteacherId =  self.wteacherId;
    [self.navigationController pushVC:h5commonVC];
    
}
- (void)goBackSlimPlan:(NSNumber *)thinProjectId{
    
    [[[HJConfirmpProjectAPI ConfirmpProjectWithThinProjectId:thinProjectId] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
        HJConfirmpProjectAPI *api = responseObject;
        if (api.code == 1) {
            [SVProgressHUD showSuccessWithStatus:@"定制成功"];
            HJUser *user = [HJUser read];
            user.isLogin = YES;
            [user write];
            
            HJTabBarController *tab = [[HJTabBarController alloc]init];
            [UIApplication sharedApplication].keyWindow.rootViewController = tab;
        }
    }];
}

@end
