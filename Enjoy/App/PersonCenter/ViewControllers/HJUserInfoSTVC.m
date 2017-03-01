//
//  HJUserInfoSTVC.m
//  Enjoy
//
//  Created by IMAC on 16/2/27.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import "HJUserInfoSTVC.h"
#import "HJUserDetailAPI.h"
#import "HJPickView.h"
#import "InputWeightView.h"
#import "HJManInfoModel.h"
#import "TSLocation.h"
#import "HJcompleteUserInfoAPI.h"
#import "HJFamilyUserDetailAPI.h"
#import "HJDeleteFamilyUserAPI.h"
#import "HJfamilyUserTVC.h"
#import "MasterSHAinfo.h"
#import "HJAddFamilyUserAPI.h"

@interface HJUserInfoSTVC ()
{
    __weak UIImageView *weakImageView;
}
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) HJUserDetailModel *userDetailModel;
@property (nonatomic, strong) HJFamilyUserDetailModel *familyUserDetailModel;
@property (nonatomic, strong) HJPickView * pickView;
@property (nonatomic, strong) NSData *photoData;
@property (nonatomic, weak) InputWeightView *inputWeightView;
@end

@implementation HJUserInfoSTVC

#pragma mark - HJViewControllerProtocol

- (HJUserDetailModel *)userDetailModel
{
    if (!_userDetailModel) {
        _userDetailModel = [HJUserDetailModel read];
    }
    return _userDetailModel;
}

- (HJFamilyUserDetailModel *)familyUserDetailModel
{
    if (!_familyUserDetailModel) {
        _familyUserDetailModel = [HJFamilyUserDetailModel read];
    }
    return _familyUserDetailModel;
}

- (void)doSomeThingInViewDidLoad {
    self.title = @"个人信息";
    [self setFootView];
    [self getUserDetail];
    if (self.familyUserId) {
        UIButton *rightBtn = [UIButton lh_buttonWithFrame:CGRectMake(0, 0, 30, 30) target:self action:@selector(finishFamilyEdit) title:@"完成" titleColor:kWhiteColor font:FONT(15) backgroundColor:kClearColor];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    }
}

- (NSArray *)groupTitles {
    
    return @[ @[@"姓名",@"性别",@"出生年月"],@[@"职业",@"身高",@"体重",@"腰围",@"臀围", @"地区"]];
}

- (NSArray *)groupDetials
{
    if (self.familyUserId) {
        HJFamilyUserDetailModel *info = [HJFamilyUserDetailModel read];
        if (!info) {
            return @[@[@"",@"",@""], @[@"",@"",@"",@"",@"",@""]];
        } else {
            NSString *sexStr = info.sex ? @"女" : @"男";
            return @[ @[info.name?:@"",
                        sexStr?:@"",
                        info.birthday?:@""],
                      @[info.job?:@"",
                        info.height.length ? [NSString stringWithFormat:@"%@cm",info.height] : @"",
                        info.weight.length ? [NSString stringWithFormat:@"%@kg",info.weight] : @"",
                        info.waistline.length ? [NSString stringWithFormat:@"%@cm", info.waistline]:@"",
                        info.hipline.length ? [NSString stringWithFormat:@"%@cm", info.hipline]:@"",
                        info.city ? [NSString stringWithFormat:@"%@%@", info.province, info.city]:@""]];
        }
    } else {
        HJUserDetailModel *info = [HJUserDetailModel read];
        self.userDetailModel = info;
        if (!info) {
            return @[@[@"",@"",@""], @[@"",@"",@"",@"",@"",@""]];
        }else{
            NSString *sexStr = info.sex ? @"女" : @"男";
            return @[ @[info.name?:@"",
                        sexStr?:@"",
                        info.birthday?:@""],
                      @[info.job?:@"",
                        info.height ? [NSString stringWithFormat:@"%@cm", info.height]:@"",
                        info.weight.length ? [NSString stringWithFormat:@"%@kg", info.weight] : @"",
                        info.waistline.length ? [NSString stringWithFormat:@"%@cm", info.waistline]:@"",
                        info.hipline.length ? [NSString stringWithFormat:@"%@cm", info.hipline]:@"",
                        info.city ? [NSString stringWithFormat:@"%@%@", info.province, info.city]:@""]];
        }
    }
}


- (NSString *)validAll {
    NSString *name = [NSString string];
    NSInteger sex;
    NSString *birthday = [NSString string];
    NSString *province = [NSString string];
    NSString *city = [NSString string];
    NSString *height = [NSString string];
    NSString *job = [NSString string];
    NSString *waistline = [NSString string];
    NSString *hipline = [NSString string];
    NSString *weight = [NSString string];
    if (self.familyUserId) {
        HJFamilyUserDetailModel *infoModel = [HJFamilyUserDetailModel read];
        name = infoModel.name;
        sex = infoModel.sex;
        birthday = infoModel.birthday;
        province = infoModel.province;
        city = infoModel.city;
        height = infoModel.height;
        job = infoModel.job;
        waistline = infoModel.waistline;
        hipline = infoModel.hipline;
        weight = infoModel.weight;
    } else {
        HJUserDetailModel *infoModel = [HJUserDetailModel read];
        name = infoModel.name;
        sex = infoModel.sex;
        birthday = infoModel.birthday;
        province = infoModel.province;
        city = infoModel.city;
        height = infoModel.height;
        job = infoModel.job;
        waistline = infoModel.waistline;
        hipline = infoModel.hipline;
        weight = infoModel.weight;
    }
//    else if(waistline.length == 0) {
//        return @"请填写腰围";
//    }else if(hipline.length == 0) {
//        return @"请填写臀围";
//    }
    if (name.length == 0) {
        return @"请填写姓名";
    }else if(!(sex==0 || sex==1)) {
        return @"请选择性别";
    }else if(birthday.length == 0) {
        return @"请选择出生年月";
    }else if(job.length == 0) {
        return @"请填写职业";
    }else if(height.length == 0 || ([height doubleValue] <= 0)) {
        return @"请填写身高";
    } else if(weight.length == 0 || ([weight doubleValue] <= 0)) {
        return @"请填写体重";
    } else if (province.length == 0&&city.length == 0) {
        return @"请选择地区";
    }else {
        return nil;
    }
}

#pragma mark - Methods
- (void)getUserDetail
{
    // 家庭成员信息
    if (self.familyUserId) {
        [[[HJFamilyUserDetailAPI getFamilyUserDetailWithFamilyUserId:[NSNumber numberWithInteger:self.familyUserId]] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
            HJFamilyUserDetailAPI *api = responseObject;
            if (api.code == 1) {
                HJFamilyUserDetailModel *model = api.data;
                [model write];
                [self setGroups];
                [self.tableView reloadData];
            }
        }];
        
        // 用户信息
    } else {
        [[[HJUserDetailAPI getUserDetail] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
            HJUserDetailAPI *api = responseObject;
            if (api.code == 1) {
                HJUserDetailModel *model = api.data;
                if (![model  isEqual: @""]) {
                    [model write];
                    
                MasterSHAinfo *MasModel = [MasterSHAinfo read];
                    NSString *userSex = model.sex?@"女":@"男";
                    
                    //******计算年龄*****
                    NSString *birth = model.birthday;
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
                    NSString *userHeight = model.height;
                    MasModel.userSex = userSex;
                    MasModel.userAge = userAge;
                    MasModel.userHeight = userHeight;
                    [MasModel write];
                    if ( [self.dataDelegate respondsToSelector:@selector(responeData:)]) {
                        [self.dataDelegate responeData:MasModel];
                    }
                }
                [self setGroups];
                [self.tableView reloadData];
            }
        }];
    }
}

- (void)finished
{
    if (self.familyUserId) {
        [[[HJDeleteFamilyUserAPI deleteFamilyUserWithFamilyUserIdArray:@[[NSNumber numberWithInteger:self.familyUserId]]] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
            [self.navigationController popVC];
        }];
    } else {
        
        HJUserDetailModel *model = self.userDetailModel;
        [model write];
        
        MasterSHAinfo *masModel = [MasterSHAinfo read];
        NSString *userSex = model.sex?@"女":@"男";

        
        //******计算年龄*****
        NSString *birth = model.birthday;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        //生日
        NSDate *birthDay = [dateFormatter dateFromString:birth];
        //当前时间
        NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
        NSDate *currentDate = [dateFormatter dateFromString:currentDateStr];
        NSLog(@"currentDate %@ birthDay %@",currentDateStr,birth);
        NSTimeInterval time=[currentDate timeIntervalSinceDate:birthDay];
        int userAge = ((int)time)/(3600*24*365);
        NSLog(@"year %d",userAge);
        
      //-----end----//
        NSString *Age = [NSString stringWithFormat:@"%d",userAge];
        
        NSString *userHeight = model.height;
        
        masModel.userSex = userSex;
        masModel.userAge = Age;
        masModel.userHeight = userHeight;
        [masModel write];
        
        if ( [self.dataDelegate respondsToSelector:@selector(responeData:)]) {
            [self.dataDelegate responeData:masModel];
        }
        
        NSString *isValid = [self validAll];
        if (isValid) {
            [SVProgressHUD showInfoWithStatus:isValid];
        } else {
            [[[HJcompleteUserInfoAPI completeUserInfoWithName:model.name  sex:model.sex birthday:model.birthday job:model.job height:model.height weight:model.weight waistline:model.waistline hipline:model.hipline province:model.province city:model.city photoFile:self.photoData] netWorkClient] uploadFileInView:self.view successBlock:^(id responseObject) {
                [[[HJUserDetailAPI getUserDetail] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
                    HJUserDetailAPI *api = responseObject;
                    if (api.code == 1) {
                        HJUserDetailModel *model = api.data;
                        if (![model  isEqual:@""]) {
                            [model write];
                            [self.navigationController popVC];
                        }
                    }
                }];
            }];
        }
    }
}

- (void)finishFamilyEdit
{
    HJFamilyUserDetailModel *model = self.familyUserDetailModel;
    [model write];
    
    //-------start-------
    MasterSHAinfo *masModel = [MasterSHAinfo read];
    NSString *userSex = model.sex?@"女":@"男";

    //******计算年龄*****
    NSString *birth = model.birthday;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //生日
    NSDate *birthDay = [dateFormatter dateFromString:birth];
    //当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    NSDate *currentDate = [dateFormatter dateFromString:currentDateStr];
    NSLog(@"currentDate %@ birthDay %@",currentDateStr,birth);
    NSTimeInterval time=[currentDate timeIntervalSinceDate:birthDay];
    int userAge = ((int)time)/(3600*24*365);
    NSLog(@"year %d",userAge);
    
    //-----end----//
    NSString *Age = [NSString stringWithFormat:@"%d",userAge];
    
    NSString *userHeight = model.height;
    
    masModel.userSex = userSex;
    masModel.userAge = Age;
    masModel.userHeight = userHeight;
    [masModel write];
    
    if ( [self.dataDelegate respondsToSelector:@selector(responeData:)]) {
        [self.dataDelegate responeData:masModel];
    }
    
    //--------end-----
    NSString *isValid = [self validAll];
    if (isValid) {
        [SVProgressHUD showInfoWithStatus:isValid];
    } else {
        [[[HJAddFamilyUserAPI completeUserInfoWithID:[NSNumber numberWithInteger:self.familyUserId] name:model.name sex:model.sex birthday: model.birthday job:model.job height:model.height weight:model.weight waistline:model.waistline hipline:model.hipline province:model.province city:model.city photoFile:self.photoData] netWorkClient] uploadFileInView:self.view successBlock:^(id responseObject) {
            [[[HJFamilyUserDetailAPI getFamilyUserDetailWithFamilyUserId:[NSNumber numberWithInteger:self.familyUserId]] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
                HJFamilyUserDetailAPI *api = responseObject;
                if (api.code == 1) {
                    HJFamilyUserDetailModel *model = api.data;
                    [model write];
                    [self.navigationController popVC];
                }
            }];
        }];
    }
}
/**
 *  设置头像 
 */
- (void)updateIco:(UIImage *)image {
    
    weakImageView.image = image;
    self.photoData = UIImageJPEGRepresentation(image, 0.1);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0: {
            switch (indexPath.row) {
                case 0: {
                    InputWeightView *view = [InputWeightView initInputWeightViewXib];
                    self.inputWeightView = view;
                    view.frame = CGRectMake(0, 0, kDeviceWidth, KDeviceHeight);
                    view.titleLab.text = @"修改姓名";
                    view.text.placeholder = @"输入姓名";
                    WEAK_SELF();
                    view.nickBlock= ^(NSString *nick){
                        HJSettingItem *setItem0 = [self settingItemInIndexPath:indexPath];
                        setItem0.detailTitle = nick;
                        if (weakSelf.familyUserId) {
                            weakSelf.familyUserDetailModel.name = nick;
                        } else {
                            weakSelf.userDetailModel.name = nick;
                        }
                        [weakSelf.tableView reloadData];
                    };
                    view.KgLab.hidden = YES;
                    [[UIApplication sharedApplication].keyWindow addSubview:view];
                }
                    break;
                case 1: {
                    self.pickView = [[[NSBundle mainBundle]loadNibNamed:@"HJPickView" owner:nil options:nil]lastObject];
                    self.pickView.titleLabel.text = [NSString stringWithFormat:@"选择性别"];
                    self.pickView.personInfoStyle = HJSexStyle;
                    [self.pickView pickViewWithStyle:HJPickViewStyleNone];
                    WEAK_SELF();
                    self.pickView.dateBlock = ^(NSString *dateStr){
                        HJSettingItem *setItem1 = [weakSelf settingItemInIndexPath:indexPath];
                        setItem1.detailTitle = dateStr;
                        
                        if (weakSelf.familyUserId) {
                            weakSelf.familyUserDetailModel.sex = [dateStr isEqualToString:@"男"] ? 0 : 1;
                        } else {
                            weakSelf.userDetailModel.sex = [dateStr isEqualToString:@"男"] ? 0 : 1;
                        }
                        [weakSelf.tableView reloadData];
                    };
                    [[UIApplication sharedApplication].keyWindow addSubview:self.pickView];
                }
                    break;
                case 2: {
                    self.pickView = [[[NSBundle mainBundle]loadNibNamed:@"HJPickView" owner:nil options:nil]lastObject];
                    self.pickView.titleLabel.text = [NSString stringWithFormat:@"选择生日年月"];
                    self.pickView.personInfoStyle = HJHeightStyle;
                    [self.pickView pickViewWithStyle:HJPickViewStyleDate];
                    WEAK_SELF();
                    self.pickView.dateBlock = ^(NSString *dateStr){
                        HJSettingItem *setItem1 = [weakSelf settingItemInIndexPath:indexPath];
                        setItem1.detailTitle = dateStr;
                        if (weakSelf.familyUserId) {
                            weakSelf.familyUserDetailModel.birthday = dateStr;
                        } else {
                            weakSelf.userDetailModel.birthday = dateStr;
                        }
                        [weakSelf.tableView reloadData];
                    };
                    [[UIApplication sharedApplication].keyWindow addSubview:self.pickView];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 1: {
            switch (indexPath.row) {
                case 0: {
                    InputWeightView *view = [InputWeightView initInputWeightViewXib];
                    view.frame = CGRectMake(0, 0, kDeviceWidth, KDeviceHeight);
                    view.titleLab.text = @"修改职业";
                    view.text.placeholder = @"输入职业";
                    WEAK_SELF();
                    view.nickBlock= ^(NSString *nick){
                        HJSettingItem *setItem0 = [self settingItemInIndexPath:indexPath];
                        setItem0.detailTitle = nick;
                        if (weakSelf.familyUserId) {
                            weakSelf.familyUserDetailModel.job = nick;
                        } else {
                            weakSelf.userDetailModel.job = nick;
                        }
                        [weakSelf.tableView reloadData];
                    };
                    view.KgLab.hidden = YES;
                    [[UIApplication sharedApplication].keyWindow addSubview:view];
                }
                    break;
                case 1: {
                    InputWeightView *view = [InputWeightView initInputWeightViewXib];
                    view.frame = CGRectMake(0, 0, kDeviceWidth, KDeviceHeight);
                    view.titleLab.text = @"修改身高";
                    view.text.placeholder = @"输入身高";
                    view.heightNum = 111;
                    WEAK_SELF();
                    view.nickBlock= ^(NSString *nick){
                        HJSettingItem *setItem0 = [self settingItemInIndexPath:indexPath];
                        if ([nick doubleValue] <= 0) {
                            setItem0.detailTitle = @"";
                        } else {
                            setItem0.detailTitle = [NSString stringWithFormat:@"%@cm", nick];
                        }
                        
                        if (weakSelf.familyUserId) {
                            weakSelf.familyUserDetailModel.height = nick;
                        } else {
                            weakSelf.userDetailModel.height = nick;
                        }
                        [weakSelf.tableView reloadData];
                    };
                    view.KgLab.hidden = YES;
                    [[UIApplication sharedApplication].keyWindow addSubview:view];
                }
                    break;
                case 2: {
                    InputWeightView *view = [InputWeightView initInputWeightViewXib];
                    view.frame = CGRectMake(0, 0, kDeviceWidth, KDeviceHeight);
                    view.titleLab.text = @"修改体重";
                    view.text.placeholder = @"输入体重";
                    view.weightNum = 111;
                    view.KgLab.text = @"kg";
                    WEAK_SELF();
                    view.nickBlock= ^(NSString *nick){
                        HJSettingItem *setItem0 = [self settingItemInIndexPath:indexPath];
                        if ([nick doubleValue] <= 0) {
                            setItem0.detailTitle = @"";
                        } else {
                            setItem0.detailTitle = [NSString stringWithFormat:@"%@kg", nick];
                        }
                        if (weakSelf.familyUserId) {
                            weakSelf.familyUserDetailModel.weight = nick;
                        } else {
                            weakSelf.userDetailModel.weight = nick;
                        }
                        [weakSelf.tableView reloadData];
                    };
                    view.KgLab.hidden = YES;
                    [[UIApplication sharedApplication].keyWindow addSubview:view];
                }
                    break;
                case 3: {
                    InputWeightView *view = [InputWeightView initInputWeightViewXib];
                    view.frame = CGRectMake(0, 0, kDeviceWidth, KDeviceHeight);
                    view.titleLab.text = @"修改腰围";
                    view.text.placeholder = @"输入腰围";
                    WEAK_SELF();
                    view.nickBlock= ^(NSString *nick){
                        HJSettingItem *setItem0 = [self settingItemInIndexPath:indexPath];
                        setItem0.detailTitle = [NSString stringWithFormat:@"%@cm", nick];;
                        if (weakSelf.familyUserId) {
                            weakSelf.familyUserDetailModel.waistline = nick;
                        } else {
                            weakSelf.userDetailModel.waistline = nick;
                        }
                        [weakSelf.tableView reloadData];
                    };
                    view.KgLab.hidden = YES;
                    [[UIApplication sharedApplication].keyWindow addSubview:view];
                }
                    break;
                case 4: {
                    InputWeightView *view = [InputWeightView initInputWeightViewXib];
                    view.frame = CGRectMake(0, 0, kDeviceWidth, KDeviceHeight);
                    view.titleLab.text = @"修改臀围";
                    view.text.placeholder = @"输入臀围";
                    WEAK_SELF();
                    view.nickBlock= ^(NSString *nick){
                        HJSettingItem *setItem0 = [self settingItemInIndexPath:indexPath];
                        setItem0.detailTitle = [NSString stringWithFormat:@"%@cm", nick];;
                        if (weakSelf.familyUserId) {
                            weakSelf.familyUserDetailModel.hipline = nick;
                        } else {
                            weakSelf.userDetailModel.hipline = nick;
                        }
                        [weakSelf.tableView reloadData];
                    };
                    view.KgLab.hidden = YES;
                    [[UIApplication sharedApplication].keyWindow addSubview:view];
                }
                    break;
                case 5: {
                    self.pickView = [[[NSBundle mainBundle]loadNibNamed:@"HJPickView" owner:nil options:nil]lastObject];
                    self.pickView.titleLabel.text = [NSString stringWithFormat:@"选择地区"];
                    self.pickView.personInfoStyle = HJRegionStyle;
                    [self.pickView pickViewWithStyle:HJPickViewStyleNone];
                    WEAK_SELF();
                    self.pickView.dateBlock = ^(TSLocation *location){
                        HJSettingItem *setItem1 = [weakSelf settingItemInIndexPath:indexPath];
                        setItem1.detailTitle = [NSString stringWithFormat:@"%@%@",location.state,location.city];
                        if (weakSelf.familyUserId) {
                            weakSelf.familyUserDetailModel.province = location.state;
                            weakSelf.familyUserDetailModel.city = location.city;
                        } else {
                            weakSelf.userDetailModel.province = location.state;
                            weakSelf.userDetailModel.city = location.city;
                        }
                        
                        [weakSelf.tableView reloadData];
                    };
                    [[UIApplication sharedApplication].keyWindow addSubview:self.pickView];
                }
                    break;
                default:
                    break;
            }
        }
        default:
            break;
    }
}

#pragma mark - Setter&Getter
- (UIView *)headView {
    
    if (!_headView) {
        CGFloat imageViewSize = 80;
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
        UIImageView *headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-imageViewSize-30, (88-imageViewSize)/2.0, imageViewSize, imageViewSize)];
        headImageView.backgroundColor = APP_COMMON_COLOR;
        headImageView.center = CGPointMake(_headView.size.width/2,_headView.size.height/2 );
        UIButton *camera = [UIButton buttonWithType:UIButtonTypeCustom];
        camera.frame = CGRectMake(CGRectGetMaxX(headImageView.frame)-30, CGRectGetMaxY(headImageView.frame)-25, 30, 30);
        [camera setImage:[UIImage imageNamed:@"ic_c2_01"] forState:UIControlStateNormal];
        [headImageView setRoundImageViewWithBorderWidth:2];
        if (self.familyUserId) {
            NSString *imgName;
            if (self.familyUserDetailModel.sex) {
                //女
                imgName = @"ic_c20_4";
                
            }else{
                imgName = @"ic_c20_3";
            }
            [headImageView sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(self.familyUserDetailModel.photo)] placeholderImage:[UIImage imageNamed:imgName]];
        } else {
            NSString *imgName;
            if (self.userDetailModel.sex) {
                //女
                imgName = @"ic_c20_4";
                
            }else{
                imgName = @"ic_c20_3";
            }
            [headImageView sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(self.userDetailModel.photo)] placeholderImage:[UIImage imageNamed:imgName]];
        }
        headImageView.userInteractionEnabled = YES;
        weakImageView = headImageView;
        [headImageView lh_setTapActionWithBlock:^{
            [self cameraClick];
        }];
        [_headView addSubview:headImageView];
        [_headView addSubview:camera];
        _headView.backgroundColor = kVCBackGroundColor;
    }
    
    return _headView;
}

- (void)setFootView
{
    UIView *footView = [UIView lh_viewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200) backColor:kVCBackGroundColor];
    UIButton *finishBtn = [UIButton lh_buttonWithFrame:CGRectMake(30, 30, SCREEN_WIDTH-60, 40) target:self action:@selector(finished) title:@"完成" titleColor:kWhiteColor font:FONT(14) backgroundColor:APP_COMMON_COLOR ];
    [finishBtn lh_setCornerRadius:3 borderWidth:0 borderColor:nil];
    [footView addSubview:finishBtn];
    self.tableView.tableFooterView = footView;
    
    if (self.familyUserId) {
        [finishBtn setTitle:@"删除用户数据" forState:UIControlStateNormal];
        [finishBtn setBackgroundColor:kWhiteColor];
        [finishBtn setTitleColor:kGreenColor forState:UIControlStateNormal];
    }
}

- (UIView *)tableHeaderView {
    
    return self.headView;
}
@end
