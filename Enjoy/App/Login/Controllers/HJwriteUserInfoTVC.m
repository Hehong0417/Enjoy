//
//  HJwriteUserInfoTVC.m
//  Enjoy
//
//  Created by IMAC on 16/2/25.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import "HJwriteUserInfoTVC.h"
#import "InputWeightView.h"
#import "HJPickView.h"
#import "TSLocation.h"
#import "HJManInfoModel.h"
#import "HJcompleteUserInfoAPI.h"
#import "HJConnectFatScaleVC.h"
#import "BluetoothManager.h"
#import "HJUser.h"
#import "HJLoginAPI.h"
#import "HJUserDetailAPI.h"

@interface HJwriteUserInfoTVC ()
@property (nonatomic, strong) HJPickView * pickView;
@property (nonatomic, strong) HJManInfoModel *infoModel;
@end

@implementation HJwriteUserInfoTVC

#pragma mark - HJViewControllerProtocol

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)doSomeThingInViewDidLoad
{
    self.title = @"填写个人资料";
    self.infoModel = [[HJManInfoModel alloc]init];
    self.allCellIndicator = YES;
    [self setFootView];
    
}

#pragma mark - Actions

- (void)finished
{
    NSString *birthday = self.infoModel.birthDay;
    NSString *province = self.infoModel.province;
    NSString *city = self.infoModel.city;
    NSString *height = self.infoModel.height;
    NSString *job = self.infoModel.job;
    NSString *name = self.infoModel.name;
    NSString *sex = self.infoModel.sex;
// //
    
    NSString *isValid = [self validAll];
    if (isValid) {
        [SVProgressHUD showInfoWithStatus:isValid];
    }else {
        
        //返回String到viewcontroller
        MasterSHAinfo *model = [MasterSHAinfo read];
        NSString *userSex = self.infoModel.sex;
        
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
        
        NSString *userHeight = self.infoModel.height;
        model.userSex = userSex;
        model.userAge = userAge;
        model.userHeight = userHeight;
        [model write];
            if ( [self.dataDelegate respondsToSelector:@selector(responeData:)]) {
                [self.dataDelegate responeData:model];
            }

        [[[HJcompleteUserInfoAPI completeUserInfoWithBirthday:birthday province:province city:city height:height job:job name:name sex:sex token:self.token userId:self.userId] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
            HJcompleteUserInfoAPI *api = responseObject;
            if (api.code == 1) {
                
                //连接体脂秤
                //[[BluetoothManager shareManager] bleDoScan];
                //
                HJConnectFatScaleVC *fatScalVC = (HJConnectFatScaleVC *)[UIViewController lh_createFromStoryboardName:SB_LOGIN  WithIdentifier:@"HJConnectFatScaleVC"];
                fatScalVC.puserId = self.userId;
                fatScalVC.userType = 1;
                fatScalVC.fatScaleType = 1;
                [self.navigationController pushVC:fatScalVC];
            }
        }];

    }
}

- (void)setFootView
{
    UIView *footView = [UIView lh_viewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200) backColor:kVCBackGroundColor];
    UIButton *finishBtn = [UIButton lh_buttonWithFrame:CGRectMake(30, 40, SCREEN_WIDTH-60, 40) target:self action:@selector(finished) title:@"完成" titleColor:kWhiteColor font:FONT(14) backgroundColor:APP_COMMON_COLOR ];
    [finishBtn lh_setCornerRadius:3 borderWidth:0 borderColor:nil];
    [footView addSubview:finishBtn];
    self.tableView.tableFooterView = footView;
}
//是否都选择了
- (NSString *)validAll {
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
#pragma mark - Methods
- (NSArray *)groupTitles
{
    return @[@[@"姓名",@"性别",@"出生年月",@"身高",@"职业",@"地区"]];
}
#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
            //姓名
            InputWeightView *view = [InputWeightView initInputWeightViewXib];
            view.frame = CGRectMake(0, 0, kDeviceWidth, KDeviceHeight);
            view.titleLab.text = @"修改姓名";
            view.nickBlock= ^(NSString *nick){
                HJSettingItem *setItem0 = [self settingItemInIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
                setItem0.detailTitle = nick;
                self.infoModel.name = nick;
                [self.tableView reloadData];
            };
            view.KgLab.hidden = YES;
            [[UIApplication sharedApplication].keyWindow addSubview:view];
        }
            break;
        case 1:{
            //性别
            self.pickView = [[[NSBundle mainBundle]loadNibNamed:@"HJPickView" owner:nil options:nil]lastObject];
            self.pickView.personInfoStyle = HJSexStyle;
            self.pickView.titleLabel.text = @"选择性别";
            [self.pickView pickViewWithStyle:HJPickViewStyleNone];
            WEAK_SELF();
            self.pickView.dateBlock = ^(NSString *dateStr){
                HJSettingItem *setItem1 = [weakSelf settingItemInIndexPath:[NSIndexPath indexPathForRow:1
                                                                                              inSection:0]];
                setItem1.detailTitle = dateStr;
                weakSelf.infoModel.sex = dateStr;
                [weakSelf.tableView reloadData];
            };
            [[UIApplication sharedApplication].keyWindow addSubview:self.pickView];
            //*********//
            
        }
            break;
        case 2:{
            //出生年月
            self.pickView = [[[NSBundle mainBundle]loadNibNamed:@"HJPickView" owner:nil options:nil]lastObject];
            [self.pickView pickViewWithStyle:HJPickViewStyleDate];
            WEAK_SELF();
            self.pickView.dateBlock = ^(NSString *dateStr){
                HJSettingItem *setItem1 = [weakSelf settingItemInIndexPath:[NSIndexPath indexPathForRow:2
                                                                                              inSection:0]];
                setItem1.detailTitle = dateStr;
                weakSelf.infoModel.birthDay = dateStr;
                [weakSelf.tableView reloadData];
            };
            [[UIApplication sharedApplication].keyWindow addSubview:self.pickView];
            
            //*************//
       
        }
            break;
        case 3:{
            //身高
            InputWeightView *view = [InputWeightView initInputWeightViewXib];
            view.frame = CGRectMake(0, 0, kDeviceWidth, KDeviceHeight);
            view.titleLab.text = @"填写身高";
            view.heightNum = 111;
            view.nickBlock= ^(NSString *nick){
                HJSettingItem *setItem2 = [self settingItemInIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
                setItem2.detailTitle = nick;
                self.infoModel.height = nick;
                [self.tableView reloadData];
            };
            view.KgLab.hidden = NO;
            view.KgLab.text = @"cm";
            [[UIApplication sharedApplication].keyWindow addSubview:view];
            //*******//
        }
            break;
        case 4:{
            //职业
            InputWeightView *view = [InputWeightView initInputWeightViewXib];
            view.frame = CGRectMake(0, 0, kDeviceWidth, KDeviceHeight);
            view.titleLab.text = @"填写职业";
            view.nickBlock= ^(NSString *nick){
                HJSettingItem *setItem1 = [self settingItemInIndexPath:[NSIndexPath indexPathForRow:4
                                                                                          inSection:0]];
                setItem1.detailTitle = nick;
                self.infoModel.job = nick;
                [self.tableView reloadData];
            };
            view.KgLab.hidden = YES;
            [[UIApplication sharedApplication].keyWindow addSubview:view];
            //******//
            
        }
            break;
        default:{
            self.pickView = [[[NSBundle mainBundle]loadNibNamed:@"HJPickView" owner:nil options:nil]lastObject];
            self.pickView.personInfoStyle = HJRegionStyle;
            [self.pickView pickViewWithStyle:HJPickViewStyleNone];
            WEAK_SELF();
            self.pickView.dateBlock = ^(TSLocation *location){
                HJSettingItem *setItem1 = [weakSelf settingItemInIndexPath:[NSIndexPath indexPathForRow:5
                                                                                              inSection:0]];
                setItem1.detailTitle = [NSString stringWithFormat:@"%@%@",location.state,location.city];
                weakSelf.infoModel.province = location.state;
                weakSelf.infoModel.city = location.city;
                [weakSelf.tableView reloadData];
            };
            [[UIApplication sharedApplication].keyWindow addSubview:self.pickView];
        }
            break;
    }
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
