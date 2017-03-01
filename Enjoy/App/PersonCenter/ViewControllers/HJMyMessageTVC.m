//
//  HJMyMessageTVC.m
//  Enjoy
//
//  Created by IMAC on 16/2/27.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import "HJMyMessageTVC.h"
#import "HJMessageCell.h"
#import "HJMyMessageAPI.h"
#import "HJMessageDetailVC.h"
#import "MJRefresh.h"

#define KpageSize 10

@interface HJMyMessageTVC ()

@property (nonatomic, strong) HJmessageModel *messageModel;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) NSMutableArray *messageList;
@end

@implementation HJMyMessageTVC

#pragma mark - HJViewControllerProtocol


- (void)doSomeThingInViewDidLoad {
    self.title = @"我的消息";
    _page = 1;
    [self getMyMessayge];
    
}

#pragma mark - Methods

- (void)getMyMessayge {

    [[[HJMyMessageAPI getMyMessageWithPage:@(_page) rows:@100] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
        HJMyMessageAPI *api = responseObject;
        if (api.code == 1) {
        self.messageModel = api.data;
        self.messageList = api.data.messageList.mutableCopy;
        [self.tableView reloadData];
        }
    }];
    
}

- (void)setWarningLabel
{
    UILabel *label = [UILabel lh_labelWithFrame:CGRectMake(0, SCREEN_HEIGHT * 0.5 - 80, SCREEN_WIDTH, 30) text:@"暂无数据" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentCenter backgroundColor:[UIColor clearColor]];;
    if (!self.messageModel.messageList.count) {
        [self.view addSubview:label];
    } else {
        label.hidden = YES;
        [label removeFromSuperview];
    }
}

#pragma mark - HJTableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HJMessageCell *cell = [HJMessageCell cellWithTableView:tableView];
    HJMessageListlModel *model = self.messageList[indexPath.row];
    cell.model = model;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.messageList.count;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HJMessageListlModel *model = self.messageList[indexPath.row];
    HJMessageDetailVC *VC = [[HJMessageDetailVC alloc] init];
    VC.messageId = model.Id;
    [self.navigationController pushVC:VC];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
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
