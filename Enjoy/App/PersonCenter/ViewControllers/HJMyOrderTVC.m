//
//  HJMyOrderTVC.m
//  Enjoy
//
//  Created by IMAC on 16/2/26.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import "HJMyOrderTVC.h"
#import "HJMyOrderCell.h"
#import "HJOrderDetailTVC.h"
#import "HJMyOrderListAPI.h"
#import "HJThinPlanHomeAPI.h"
#import "HJOrderDetailWebViewVCViewController.h"

#define KOrder_Url @"http://58.248.16.52:37771/WebService/GetOrderByPhone.ashx"

@interface HJMyOrderTVC ()
@property (nonatomic, strong) NSMutableArray *myOrderArr;
@end

@implementation HJMyOrderTVC

#pragma mark - HJViewControllerProtocol

- (void)doSomeThingInViewDidLoad {
    
    self.title = @"我的订单";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.myOrderArr = [NSMutableArray array];
    [self getMyOrder];
}

#pragma mark - Actions


#pragma mark - Methods
- (void)getMyOrder
{
    //HJThinPlanHomeModel *thinModel = [HJThinPlanHomeModel read];
    //********//
    //thinModel.phone
    //13800138000
    //15860355241
    [self requestWithPhone:@"13800138000" pageNo:@1 pageSize:@30];

    //*******//
}
- (void)requestWithPhone:(NSString *)phone pageNo:(NSNumber *)pageNo pageSize:(NSNumber *)pageSize{
    NSString *str=[NSString stringWithFormat:@"%@?phone=%@&pageNo=%@&pageSize=%@",KOrder_Url,phone,pageNo,pageSize];
    
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *html = operation.responseString;
        
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        
        id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
         UILabel *label = [UILabel lh_labelWithFrame:CGRectMake(0, SCREEN_HEIGHT * 0.5 - 80, SCREEN_WIDTH, 30) text:@"暂无订单" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentCenter backgroundColor:[UIColor clearColor]];
        
        if ([dict[@"data"] isKindOfClass:[NSArray class]]) {
            NSArray *dataArr = [NSArray arrayWithArray:dict[@"data"]];
            if (dataArr.count == 0) {
                
                [self.view addSubview:label];
                
            }else {
                
            [self.myOrderArr addObjectsFromArray: dict[@"data"]];
             [label removeFromSuperview];

            }
        }
        //
        [self setWarningLabel:dict];
        
        [self.tableView reloadData];
        
        NSLog(@"获取到的数据为：%@",dict);
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"发生错误！%@",error);
        
    }];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [queue addOperation:operation];
}
- (void)setWarningLabel:(NSDictionary *)dict
{
    UILabel *label = [UILabel lh_labelWithFrame:CGRectMake(0, SCREEN_HEIGHT * 0.5 - 80, SCREEN_WIDTH, 30) text:@"暂无订单" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentCenter backgroundColor:[UIColor clearColor]];
    
    
    if (![dict[@"data"] isKindOfClass:[NSArray class]]) {
        
        [self.view addSubview:label];
    } else {
        [label removeFromSuperview];
    }
}


#pragma mark - HJTableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HJMyOrderCell *cell = [HJMyOrderCell myOrderCellWithTableView:tableView];
    
    NSDictionary *model = self.myOrderArr[indexPath.row];
    cell.data = model;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.myOrderArr.count;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HJOrderDetailWebViewVCViewController *vc = [[HJOrderDetailWebViewVCViewController alloc] init];
    NSDictionary *model = self.myOrderArr[indexPath.row];
    vc.orderNo = model[@"orderNo"];
    [self.navigationController pushVC:vc];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
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
