//
//  HJVisitorSTVC.m
//  Enjoy
//
//  Created by IMAC on 16/2/26.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import "HJVisitorSTVC.h"
#import "HJVisitorAPI.h"
#import "HJPickView.h"
#import "InputWeightView.h"
#import "HJManInfoModel.h"
#import "TSLocation.h"
#import "HJConnectFatScaleVC.h"
#import "HJcompleteUserInfoAPI.h"
#import "BluetoothManager.h"
#import "HJVisterModel.h"

@interface HJVisitorSTVC ()
@property (nonatomic, strong) HJPickView * pickView;
@property (nonatomic, strong) HJManInfoModel *infoModel;
@property (nonatomic, strong) HJVisterModel *visterModel;
@end

@implementation HJVisitorSTVC


#pragma mark - HJViewControllerProtocol

- (void)doSomeThingInViewDidLoad {
    self.title = @"我是游客";
    [self setFootView];
}

#pragma mark - 取出数据
- (NSArray *)groupDetials {
    
//    self.infoModel = [HJManInfoModel read];
//    if (self.infoModel) {
//        NSArray *detailTiltles = @[@[self.infoModel.name?:@"",self.infoModel.sex?:@"",self.infoModel.birthDay?:@"",[NSString stringWithFormat:@"%@",self.infoModel.height?:@""],self.infoModel.job?:@"",self.infoModel.city?:@""]];
//        return detailTiltles;
//    }

    return @[@[@"",@"",@"",@"",@"",@""]];
}
#pragma mark - Actions

- (void)finished:(UIButton *)button {
    
    switch (button.tag) {
        case 0:
        {
            //取消
            [self.navigationController popVC];
        }
            break;
        case 1:
        {
            //确定--》体脂秤
           NSString *isValid = [self isValidAll];
            if (isValid) {
                [SVProgressHUD showInfoWithStatus:isValid];
            }else {
                [self saveInfoModel];

            }
        }
            break;
        default:
            break;
    }
    
}
#pragma mark - 判断是否选择了

- (NSString *)isValidAll {
    
    NSString *name = self.infoModel.name;
    NSString *birthday = self.infoModel.birthDay;
    NSString *province = self.infoModel.province;
    NSString *city = self.infoModel.city;
    NSString *height = self.infoModel.height;
    NSString *job = self.infoModel.job;
    NSString *sex = self.infoModel.sex;
    
    if (name.length == 0) {
        return @"请填写姓名";
    }else if(sex.length == 0){
        return @"请选择性别";
    }else if(birthday.length == 0) {
        return @"请选择出生年月";
    }else if(height.length == 0) {
        return @"请选择身高";
    }else if(job.length == 0) {
        return @"请选择职业";
    }else if(province.length == 0&&city.length == 0) {
        return @"请选择地区";
    }else{
        return nil;
    }

}
#pragma mark - 保存游客信息
- (void)saveInfoModel {
    
    [self.infoModel write];
    [self toFatScale];
}
- (void)toFatScale {
    
    NSString *birthday = self.infoModel.birthDay;
    NSString *height = self.infoModel.height;
    NSString *sex = self.infoModel.sex;
    
    MasterSHAinfo *MasModel = [MasterSHAinfo read];
    NSString *userSex = [sex isEqualToString:@"女"]?@"女":@"男";
    
    //******计算年龄*****
    NSString *birth = birthday;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //生日
    NSDate *birthDay = [dateFormatter dateFromString:birth];
    //当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    NSDate *currentDate = [dateFormatter dateFromString:currentDateStr];
    NSLog(@"currentDate %@ birthDay %@",currentDateStr,birth);
    NSTimeInterval time=[currentDate timeIntervalSinceDate:birthDay];
    int Age = ((int)time)/(3600*24*365);
    NSLog(@"year %d",Age);
    //----end---

    NSString *userAge = [NSString stringWithFormat:@"%d",Age];
    NSString *userHeight = height;
    
    MasModel.userSex = userSex;
    MasModel.userAge = userAge;
    MasModel.userHeight = userHeight;
    [MasModel write];
    if ( [self.dataDelegate respondsToSelector:@selector(responeData:)]) {
        [self.dataDelegate responeData:MasModel];
    }
    
    HJConnectFatScaleVC *fatScalVC = (HJConnectFatScaleVC *)[UIViewController lh_createFromStoryboardName:SB_LOGIN  WithIdentifier:@"HJConnectFatScaleVC"];
            //fatScalVC.puserId = ;
            //fatScalVC.userType = 3;
            fatScalVC.fatScaleType = 3;
          fatScalVC.visitorType = 1000;
            [self.navigationController pushVC:fatScalVC];

}
#pragma mark - Methods

- (NSArray *)groupTitles {
    
    return @[@[@"姓名",@"性别",@"出生年月",@"身高",@"职业",@"地区"]];
}

- (void)setFootView
{
    UIView *footView = [UIView lh_viewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200) backColor:kVCBackGroundColor];
    
    for (NSInteger i =0; i<2; i++) {
        CGFloat margin = 10;
        CGFloat BtnW = (SCREEN_WIDTH-80-margin)/2;
        UIColor *cancelColor = RGB(204, 230, 187);
        UIButton *finishBtn = [UIButton lh_buttonWithFrame:CGRectMake(40+(i*(BtnW+margin)), 40,BtnW, 40) target:self action:@selector(finished:) title:i?@"确定":@"取消" titleColor:i?kWhiteColor:APP_COMMON_COLOR font:FONT(14) backgroundColor:i?APP_COMMON_COLOR:cancelColor];
        finishBtn.tag = i;
        [finishBtn lh_setCornerRadius:3 borderWidth:0 borderColor:nil];
        [footView addSubview:finishBtn];
 
    }
        self.tableView.tableFooterView = footView;
}



#pragma mark - HJDataHandlerProtocol
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:{
            InputWeightView *view = [InputWeightView initInputWeightViewXib];
            view.frame = CGRectMake(0, 0, kDeviceWidth, KDeviceHeight);
            view.titleLab.text = @"修改姓名";
            view.text.placeholder = @"输入姓名";
            WEAK_SELF();
            view.nickBlock= ^(NSString *nick){
                HJSettingItem *setItem0 = [self settingItemInIndexPath:indexPath];
                setItem0.detailTitle = nick;
                weakSelf.infoModel.name = nick;
                [weakSelf.tableView reloadData];
            };
            view.KgLab.hidden = YES;
            [[UIApplication sharedApplication].keyWindow addSubview:view];
        }
            break;
        case 1:{
            self.pickView = [[[NSBundle mainBundle]loadNibNamed:@"HJPickView" owner:nil options:nil]lastObject];
            self.pickView.titleLabel.text = [NSString stringWithFormat:@"选择性别"];
            self.pickView.personInfoStyle = HJSexStyle;
            [self.pickView pickViewWithStyle:HJPickViewStyleNone];
            WEAK_SELF();
            self.pickView.dateBlock = ^(NSString *dateStr){
                HJSettingItem *setItem1 = [weakSelf settingItemInIndexPath:indexPath];
                setItem1.detailTitle = dateStr;
                weakSelf.infoModel.sex = dateStr;
                [weakSelf.tableView reloadData];
            };
            [[UIApplication sharedApplication].keyWindow addSubview:self.pickView];
            
        }
            break;
        case 2:{
            self.pickView = [[[NSBundle mainBundle]loadNibNamed:@"HJPickView" owner:nil options:nil]lastObject];
            self.pickView.titleLabel.text = [NSString stringWithFormat:@"选择生日年月"];
            self.pickView.personInfoStyle = HJHeightStyle;
            [self.pickView pickViewWithStyle:HJPickViewStyleDate];
            WEAK_SELF();
            self.pickView.dateBlock = ^(NSString *dateStr){
                HJSettingItem *setItem1 = [weakSelf settingItemInIndexPath:indexPath];
                setItem1.detailTitle = dateStr;
                weakSelf.infoModel.birthDay = dateStr;
                [weakSelf.tableView reloadData];
            };
            [[UIApplication sharedApplication].keyWindow addSubview:self.pickView];
        }
            break;
        case 3:{
            InputWeightView *view = [InputWeightView initInputWeightViewXib];
            view.frame = CGRectMake(0, 0, kDeviceWidth, KDeviceHeight);
            view.titleLab.text = @"修改身高";
            view.text.placeholder = @"输入身高";
            view.heightNum = 111;
            WEAK_SELF();
            view.nickBlock= ^(NSString *nick){
                HJSettingItem *setItem0 = [self settingItemInIndexPath:indexPath];
                setItem0.detailTitle = [NSString stringWithFormat:@"%@cm", nick];
                weakSelf.infoModel.height = nick;
                [weakSelf.tableView reloadData];
            };
            view.KgLab.hidden = YES;
            [[UIApplication sharedApplication].keyWindow addSubview:view];
        }
            break;
        case 4:{
            InputWeightView *view = [InputWeightView initInputWeightViewXib];
            view.frame = CGRectMake(0, 0, kDeviceWidth, KDeviceHeight);
            view.titleLab.text = @"修改职业";
            view.text.placeholder = @"输入职业";
            WEAK_SELF();
            view.nickBlock= ^(NSString *nick){
                HJSettingItem *setItem0 = [self settingItemInIndexPath:indexPath];
                setItem0.detailTitle = nick;
                weakSelf.infoModel.job = nick;
                [weakSelf.tableView reloadData];
            };
            view.KgLab.hidden = YES;
            [[UIApplication sharedApplication].keyWindow addSubview:view];
        }
            break;
        default:{
            self.pickView = [[[NSBundle mainBundle]loadNibNamed:@"HJPickView" owner:nil options:nil]lastObject];
            self.pickView.titleLabel.text = [NSString stringWithFormat:@"选择地区"];
            self.pickView.personInfoStyle = HJRegionStyle;
            [self.pickView pickViewWithStyle:HJPickViewStyleNone];
            WEAK_SELF();
            self.pickView.dateBlock = ^(TSLocation *location){
                HJSettingItem *setItem1 = [weakSelf settingItemInIndexPath:indexPath];
                setItem1.detailTitle = location.city;
                weakSelf.infoModel.province = location.state;
                weakSelf.infoModel.city = location.city;
                [weakSelf.tableView reloadData];
            };
            [[UIApplication sharedApplication].keyWindow addSubview:self.pickView];
            
        }
            break;
    }
}

#pragma mark - Setter&Getter

- (HJManInfoModel *)infoModel{
    
    if (!_infoModel) {
        _infoModel = [[HJManInfoModel alloc]init];
    }
    return _infoModel;
}

@end
