//
//  HJfamilyUserTVC.m
//  Enjoy
//
//  Created by IMAC on 16/2/26.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import "HJfamilyUserTVC.h"
#import "HJfamilyUserCell.h"
#import "HJAddFamilySTVC.h"
#import "HJFamilyUserListAPI.h"
#import "HJDeleteFamilyUserAPI.h"
#import "HJFamilyUserDetailVC.h"

@interface HJfamilyUserTVC ()
@property (nonatomic, strong) HJFamilyUserListModel *familyUserListModel;
@property (nonatomic, weak) UILabel *warnLabel;
@end

@implementation HJfamilyUserTVC

#pragma mark - HJViewControllerProtocol

- (NSMutableArray *)familyUserIdArray
{
    if (_familyUserIdArray == nil) {
        _familyUserIdArray = [NSMutableArray array];
    }
    return _familyUserIdArray;
}

- (void)doSomeThingInViewDidLoad {
 
    self.title = @"家庭用户";
    
    [self addRightBtn];
    [self finished];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getFamilyUserList];
}

#pragma mark - Actions

- (void)addRightBtn {
    
    UIButton *rightBtn = [UIButton lh_buttonWithFrame:CGRectMake(0, 0, 30, 30) target:self action:@selector(addFamilyUser) image:[UIImage imageNamed:@"ic_c19_01"]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
}

- (void)addFamilyUser
{
    [self.navigationController pushVC:[[HJAddFamilySTVC alloc]init]];
}

- (void)finished
{
    
}

- (void)getFamilyUserList
{
    [[[HJFamilyUserListAPI getFamilyUserListWithPage:@1 rows:@100] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
        HJFamilyUserListAPI *api = responseObject;
        if (api.code == 1) {
            self.familyUserListModel = api.data;
            [self setWarningLabel];
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - Methods
- (void)deleteFmailyUserDataWithModel:(HJFamilyUserModel *)model
{
    [self.familyUserIdArray addObject:[NSString stringWithFormat:@"%ld", model.Id]];
    [[[HJDeleteFamilyUserAPI deleteFamilyUserWithFamilyUserIdArray:self.familyUserIdArray] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
        HJDeleteFamilyUserAPI *api = responseObject;
        if (api.code == 1) {
        [self.familyUserIdArray removeAllObjects];
        }
    }];
}

- (void)setWarningLabel
{
    if (!self.familyUserListModel.familyUserList.count) {
        UILabel *label = [UILabel lh_labelWithFrame:CGRectMake(0, SCREEN_HEIGHT * 0.5 - 80, SCREEN_WIDTH, 30) text:@"还未添加家庭用户" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentCenter backgroundColor:[UIColor clearColor]];;
        self.warnLabel = label;
        [self.view addSubview:label];
    } else {
        [self.warnLabel removeFromSuperview];
    }
}

#pragma mark - HJTableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HJfamilyUserCell *cell = [HJfamilyUserCell cellWithTableView:tableView];    
    cell.model = self.familyUserListModel.familyUserList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.familyUserListModel.familyUserList == 0) return;
    HJFamilyUserModel *model = self.familyUserListModel.familyUserList[indexPath.row];
    [self.familyUserListModel.familyUserList removeObjectAtIndex:indexPath.row];
    [tableView reloadData];
    [self deleteFmailyUserDataWithModel:model];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.familyUserListModel.familyUserList.count ? self.familyUserListModel.familyUserList.count : 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HJFamilyUserDetailVC *VC = [[HJFamilyUserDetailVC alloc] init];
    HJFamilyUserModel *familyUserModel = self.familyUserListModel.familyUserList[indexPath.row];
    VC.familyUserId = familyUserModel.Id;
    [self.navigationController pushVC:VC];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 84;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
}

#pragma mark - HJDataHandlerProtocol



#pragma mark - Setter&Getter
@end
