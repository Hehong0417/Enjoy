//
//  HJOrderDetailTVC.m
//  Enjoy
//
//  Created by IMAC on 16/2/26.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import "HJOrderDetailTVC.h"
#import "HJMyOrderCell.h"
#import "HJDetailOneCell.h"
#import "HJDetailTwoCell.h"
#import "HJDetailGroupHead.h"
#import "HJH5CommonVC.h"
#import "HJMyOrderDetailAPI.h"

@interface HJOrderDetailTVC ()
@property (nonatomic, strong) HJMyOrderDetailModel *myOrderDetailModel;
@end

@implementation HJOrderDetailTVC

#pragma mark - HJViewControllerProtocol

- (void)doSomeThingInViewDidLoad {
    
    self.title = @"订单详情";
    [self registerCell];
    
    [self getMyOrderList];
    
}

#pragma mark - Actions



#pragma mark - Methods

- (void)registerCell {
    
   [self.tableView registerNib:[UINib nibWithNibName:@"HJMyOrderCell" bundle:nil] forCellReuseIdentifier:@"HJMyOrderCell"];
   [self.tableView registerNib:[UINib nibWithNibName:@"HJDetailOneCell" bundle:nil] forCellReuseIdentifier:@"HJDetailOneCell"];
   [self.tableView registerNib:[UINib nibWithNibName:@"HJDetailTwoCell" bundle:nil] forCellReuseIdentifier:@"HJDetailTwoCell"];
}

- (void)getMyOrderList{

//    [[[HJMyOrderDetailAPI getMyOrderDetailWithOrderId:self.orderId] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
//        HJMyOrderDetailAPI *api = responseObject;
//        self.myOrderDetailModel = api.data;
//        [self.tableView reloadData];
//    }];
}

#pragma mark - HJTableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) {
                
             HJMyOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HJMyOrderCell"];
                cell.detailModel = self.myOrderDetailModel;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
                
            }else {
                
            HJDetailOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HJDetailOneCell"];
                cell.myOrderDetailModel = self.myOrderDetailModel;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
            break;
        case 1:{
            
             HJDetailTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HJDetailTwoCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.onlineMessageBtn lh_setTapActionWithBlock:^{
                HJH5CommonVC *h5commonVC = [[HJH5CommonVC alloc]init];
                h5commonVC.h5_InterfaceType = HJOnline_MessageType;
                [self.navigationController pushVC:h5commonVC];
            }];
            cell.callBlock = ^{
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://10086"]];
            };
             return cell;
        }
            break;
        default:
            break;
    }
    return nil;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:{
            return 2;
        }
            break;
        case 1:{
            return 1;
        }
            break;
        default:
            break;
    }
    return 0;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            if (indexPath.row == 1) {
                return 60;
            }else{
                return 80;
            }
        }
            break;
        case 1:{
            return 80;
        }
            break;
        default:
            break;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
             return 0.1;
            break;
        case 1:
             return 44;
            break;
        default:
            break;
    }
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        UIView *head = [[[NSBundle mainBundle] loadNibNamed:@"HJDetailGroupHead" owner:self options:nil] firstObject];
        return head;
    }
    return nil;
}
#pragma mark - HJDataHandlerProtocol



#pragma mark - Setter&Getter

@end
