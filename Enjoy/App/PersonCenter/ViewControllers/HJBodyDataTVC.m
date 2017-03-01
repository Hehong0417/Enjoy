//
//  HJBodyDataTVC.m
//  Enjoy
//
//  Created by IMAC on 16/2/27.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import "HJBodyDataTVC.h"
#import "HJBodyReportListAPI.h"
#import "HJUser.h"
#import "HJH5CommonVC.h"
#import "HJhealthReportListAPI.h"
#import "HJSurver.h"

#define KpageSize 100

@interface HJBodyDataTVC ()

{
  NSNumber *userId;
}
@property (nonatomic, strong) NSArray *bodyDataList;
@property (nonatomic, strong) HJBodyReportModel *bodyReportModel;
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, assign) BOOL isHeader;
@property (nonatomic, assign) int page;
@property (nonatomic, strong) NSNumber *rows;
@end

@implementation HJBodyDataTVC


#pragma mark - HJViewControllerProtocol


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
}

- (void)doSomeThingInViewDidLoad {
    if (self.reportListType == HJbodyReportType) {
        self.title = @"身体数据报告";
        
    }else{
        self.title = @"健康数据报告";
        [self healthQuestionnaireBtn];
    }
   // [ self addHeaderRefresh];
    [self getBodyDtaList];
}

- (void)healthQuestionnaireBtn {
    UIButton *rightBtn = [UIButton lh_buttonWithFrame:CGRectMake(0, 0, 30, 30) target:self action:@selector(questionnaire) image:[UIImage imageNamed:@"ic_c11_nav_01-1"]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
}

//跳转调查问卷页面
-(void)questionnaire{
    HJSurver *vc = [HJSurver new];
    [self.navigationController pushVC:vc];
    
}

- (void)getBodyDtaList
{
    if (self.reportListType == HJbodyReportType) {
        
        HJUser *user = [HJUser read];
        NSLog(@"%@", user.loginModel.userId);
        
        if ([self.userType isEqualToNumber:@1]) {
           userId =[NSNumber numberWithString:user.loginModel.userId];
        }else {
           userId = self.puserId;
        }
        
        [[[HJBodyReportListAPI getBodyReportListWithPage:@(1) rows:@(KpageSize) userType:self.userType puserId:userId] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
            NSLog(@"%@", responseObject);
            HJBodyReportListAPI *api = responseObject;
            if (api.code == 1) {
                self.bodyReportModel = api.data;
                self.datas = api.data.bodyReportList.mutableCopy;
                [self setWarningLabel];
                [self.tableView reloadData];
            }
        }];
        
    }else {
        [[[HJhealthReportListAPI getHealthReportListWithPage:@(_page) rows:@(KpageSize)] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
            HJhealthReportListAPI *api = responseObject;
            if (api.code == 1) {
                self.datas = api.data.healthReportList.mutableCopy;
                [self setWarningLabel];
                [self.tableView reloadData];
            }
        }];
    }
}

#pragma mark - Methods
- (void)setWarningLabel
{
    UILabel *label = [UILabel lh_labelWithFrame:CGRectMake(0, SCREEN_HEIGHT * 0.5 - 80, SCREEN_WIDTH, 30) text:@"暂无数据" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentCenter backgroundColor:[UIColor clearColor]];;
    if (!self.datas.count) {
        [self.view addSubview:label];
    } else {
        label.hidden = YES;
        [label removeFromSuperview];
    }
}
//
//-(int)page{
//    if (!_page) {
//        _page = 1;
//    }
//    return _page;
//}
//- (void)addHeaderRefresh {
//    
//    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerBeginRefresh)];
//    header.lastUpdatedTimeKey = NSStringFromClass(self.class).lh_md5_32Bit_String;
//    self.tableView.mj_header = header;
//    //
//    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerBeginRefresh)];
//    self.tableView.mj_footer = footer;
//    self.page = 1;
//    self.datas = [NSMutableArray array];
//}

//- (void)headerBeginRefresh {
//    
//    self.isHeader = YES;
//    self.page = 1;
//    [self getBodyDtaList];
//}

//- (void)footerBeginRefresh {
//    self.isHeader = NO;
//    self.page ++;
//    [self getBodyDtaList];
//}
///**
// *  加载数据完成
// */
//- (void)loadDataFinish:(NSArray *)arr {
//    
//    if (_isHeader) {
//        [self.datas removeAllObjects];
//    }
//    
//    // 添加数据
//    if (self.page > 1) {
//        
//        [self.datas addObjectsFromArray:arr];
//    } else {
//        
//        self.datas = arr.mutableCopy;
//    }
//    
//    BOOL noMoreData = (arr.count == 0 || arr.count < KpageSize);
//    [self endRefreshing:noMoreData];
//}
//
///**
// *  结束刷新
// */
//- (void)endRefreshing:(BOOL)noMoreData {
//    
//    // 取消刷新
//    if (self.tableView.mj_header.isRefreshing) {
//        [self.tableView.mj_header endRefreshing];
//    }
//    else if (self.tableView.mj_footer.isRefreshing) {
//        [self.tableView.mj_footer endRefreshing];
//    }
//    // 判断还有没有数据
//    if (noMoreData) {
//        self.tableView.mj_footer.hidden = YES;
//        //self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
//    }
//    else {
//        self.tableView.mj_footer.hidden = NO;
//    }
//    // 数据重载
//    [self.tableView reloadData];
//}
//




#pragma mark - HJTableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (self.reportListType == HJbodyReportType) {
        HJBodyReportListModel *model = self.datas[indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@  %@", model.createTime, @"身体数据报告"];
        
    }else {
        healthArrModel *healthModel = self.datas[indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@  %@",healthModel.createTime, @"健康报告"];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.datas.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HJH5CommonVC *h5commonVC = [[HJH5CommonVC alloc]init];
    if (self.reportListType == HJbodyReportType) {
        h5commonVC.h5_InterfaceType = HJReport_detailsType;
        HJBodyReportListModel *model = self.datas[indexPath.row];
        h5commonVC.userId = [NSString stringWithFormat:@"%@",userId];
        h5commonVC.bodyReportId = model.Id;
        h5commonVC.bodyUserType = [NSString stringWithFormat:@"%@",self.userType];
    }else {
        h5commonVC.h5_InterfaceType = HJHealthReportDetailsType;
        healthArrModel *model = self.datas[indexPath.row];
        h5commonVC.healthReportId = [NSString stringWithFormat:@"%ld",model.Id];
    }
    [self.navigationController pushVC:h5commonVC];

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

#pragma mark - HJDataHandlerProtocol



#pragma mark - Setter&Getter
- (NSMutableArray *)datas {
    
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    
    return _datas;
}


@end
