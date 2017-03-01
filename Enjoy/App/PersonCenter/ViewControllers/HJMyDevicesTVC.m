//
//  HJMyDevicesTVC.m
//  Enjoy
//
//  Created by IMAC on 16/2/26.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import "HJMyDevicesTVC.h"
#import "HJConnectFatScaleVC.h"
#import "HJBleDeviceModel.h"

@interface HJMyDevicesTVC ()
@property (nonatomic, strong) NSMutableArray *bleArr;
@property (nonatomic, weak) UILabel *warnLabel;
@end

@implementation HJMyDevicesTVC


#pragma mark - HJViewControllerProtocol

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)doSomeThingInViewDidLoad {
    
    self.title = @"我的设备";
    [self addRightBtn];
    
    HJBleDeviceModel *bleModel = [HJBleDeviceModel read];
    self.bleArr = bleModel.bleArr.mutableCopy;
    if (self.bleArr.count == 0) {
//        [SVProgressHUD showInfoWithStatus:@"暂无数据！"];
        
    }
    [self setWarningLabel];

}

#pragma mark - Actions

- (void)addRightBtn {
    
    UIButton *rightBtn = [UIButton lh_buttonWithFrame:CGRectMake(0, 0, 30, 30) target:self action:@selector(add) image:[UIImage imageNamed:@"ic_c19_01"]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
}

- (void)add {
    HJConnectFatScaleVC *fatScalVC = (HJConnectFatScaleVC *)[UIViewController lh_createFromStoryboardName:SB_LOGIN  WithIdentifier:@"HJConnectFatScaleVC"];
    fatScalVC.userType = 1;
    fatScalVC.fatScaleType = 2;
    [self.navigationController pushVC:fatScalVC];
}


#pragma mark - Methods
- (void)setWarningLabel
{
    if (!self.self.bleArr.count) {
        UILabel *label = [UILabel lh_labelWithFrame:CGRectMake(0, SCREEN_HEIGHT * 0.5 - 80, SCREEN_WIDTH, 30) text:@"还未添加设备" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentCenter backgroundColor:[UIColor clearColor]];;
        self.warnLabel = label;
        [self.view addSubview:label];
    } else {
        [self.warnLabel removeFromSuperview];
    }
}


#pragma mark - HJTableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"status";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.bleArr[indexPath.row];
    
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.bleArr.count;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self add];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.bleArr removeObjectAtIndex:indexPath.row];
        HJBleDeviceModel *bleModel = [HJBleDeviceModel read];
        bleModel.bleArr = self.bleArr.mutableCopy;
        [bleModel write];
        [self.tableView reloadData];
    }

}
#pragma mark - HJDataHandlerProtocol



#pragma mark - Setter&Getter

@end
