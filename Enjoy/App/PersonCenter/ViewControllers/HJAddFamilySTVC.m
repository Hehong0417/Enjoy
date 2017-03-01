//
//  HJAddFamilySTVC.m
//  Enjoy
//
//  Created by IMAC on 16/2/26.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import "HJAddFamilySTVC.h"
#import "HJAddFamilyUserAPI.h"
#import "HJPickView.h"
#import "InputWeightView.h"
#import "HJManInfoModel.h"
#import "TSLocation.h"

@interface HJAddFamilySTVC ()
@property (nonatomic, strong) HJPickView * pickView;
@property (nonatomic, strong) HJManInfoModel *infoModel;
@property (nonatomic, strong) NSData *imageData;
@end

@implementation HJAddFamilySTVC


#pragma mark - HJViewControllerProtocol

- (HJManInfoModel *)infoModel
{
    if (!_infoModel) {
        _infoModel = [[HJManInfoModel alloc] init];
    }
    return _infoModel;
}

- (void)doSomeThingInViewDidLoad {
    
    self.title = @"添加家庭用户";
    
    [self setFootView];
    
}

#pragma mark - Actions

- (void)finished {
    [self addFamilyUser];
}


#pragma mark - Methods
- (void)addFamilyUser
{
    NSString *name = self.infoModel.name;
    NSString *sex = self.infoModel.sex;
    NSString *birthday = self.infoModel.birthDay;
//    NSString *province = self.infoModel.province;
//    NSString *city = self.infoModel.city;
    NSString *height = self.infoModel.height;
    NSString *job = self.infoModel.job;
    NSString *isValid = [self validAll];
    if (isValid) {
        [SVProgressHUD showInfoWithStatus:isValid];
    } else {
        [[[HJAddFamilyUserAPI addFamilyUserWithName:name sex:([sex isEqualToString:@"男"] ? @0 : @1) birthday:birthday job:job height:height photoFile:self.imageData] netWorkClient] uploadFileInView:self.view successBlock:^(id responseObject) {
            HJAddFamilyUserAPI *api = responseObject;
            if (api.code == 1) {
                [self.navigationController popVC];
            }
        }];
    }
}

- (NSString *)validAll {
    NSString *name = self.infoModel.name;
    NSString *sex = self.infoModel.sex;
    NSString *birthday = self.infoModel.birthDay;
    NSString *province = self.infoModel.province;
    NSString *city = self.infoModel.city;
    NSString *height = self.infoModel.height;
    NSString *job = self.infoModel.job;
    if (name.length == 0) {
        return @"请填写姓名";
    }else if(sex.length == 0) {
        return @"请选择性别";
    }else if(birthday.length == 0) {
        return @"请选择出生年月";
    }else if(job.length == 0) {
        return @"请选择职业";
    }else if(height.length == 0) {
        return @"请选择身高";
    }else if(province.length == 0&&city.length == 0) {
        return @"请选择地区";
    }else {
        return nil;
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

- (NSArray *)groupTitles
{
    return @[@[@"头像",@"姓名",@"性别",@"出生年月",@"职业",@"身高",@"地区"]];
}

#pragma mark - HJDataHandlerProtocol


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSLog(@"%ld", (long)indexPath.row);
    switch (indexPath.row) {
        case 0: {
            [self cameraClick];
        }
            break;
        case 1: {
            InputWeightView *view = [InputWeightView initInputWeightViewXib];
            view.frame = CGRectMake(0, 0, kDeviceWidth, KDeviceHeight);
            view.titleLab.text = @"修改姓名";
            view.text.placeholder = @"输入姓名";
            WEAK_SELF()
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
        case 2:{
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
        case 3:{
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
        case 4:{
            InputWeightView *view = [InputWeightView initInputWeightViewXib];
            view.frame = CGRectMake(0, 0, kDeviceWidth, KDeviceHeight);
            view.titleLab.text = @"修改职业";
            view.text.placeholder = @"输入职业";
            WEAK_SELF()
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
        case 5:{
            InputWeightView *view = [InputWeightView initInputWeightViewXib];
            view.frame = CGRectMake(0, 0, kDeviceWidth, KDeviceHeight);
            view.titleLab.text = @"修改身高";
            view.text.placeholder = @"输入身高";
            view.heightNum = 111;
            WEAK_SELF()
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
        case 6:{
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
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.cellHeadImageView.image = [UIImage imageWithData:self.imageData];
    return indexPath.row == 0 ? 60 : 44;
}

- (void)updateIco:(UIImage *)image {
    self.cellHeadImageView.image = image;
    // 图片压缩
    self.imageData = UIImageJPEGRepresentation(image, 0.3);
}

- (NSIndexPath *)headImageCellIndexPath
{
    return [NSIndexPath indexPathForRow:0 inSection:0];
}

@end
