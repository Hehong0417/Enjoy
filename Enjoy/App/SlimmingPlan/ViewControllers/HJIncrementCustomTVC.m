
//
//  HJIncrementCustomTVC.m
//  Enjoy
//
//  Created by IMAC on 16/5/30.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJIncrementCustomTVC.h"
#import "HJIncreCustemCell.h"
#import "HJInformationAPI.h"
#import "HJH5DetailWebViewVC.h"

#define KpageSize 10

@interface HJIncrementCustomTVC ()
@property (nonatomic, assign) int page;
@property (nonatomic, strong) NSNumber *rows;
@property (nonatomic, assign) BOOL isHeader;
@property (nonatomic, strong) NSMutableArray *informationArr;

@end

@implementation HJIncrementCustomTVC


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.page = 1;
    [self.tableView.mj_header beginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle];
    [self addHeaderRefresh];
    [self.tableView registerNib:[UINib nibWithNibName:@"HJIncreCustemCell" bundle:nil] forCellReuseIdentifier:@"HJIncreCustemCell"];
}

#pragma mark - 设置标题

- (void)setTitle {
    
    self.tableView.rowHeight = 105;
    switch (self.incrementType) {
        case HJManage_Note_Incre:
            self.title = @"管理师手记";
            break;
         case HJPublic_Class_Incre:
            self.title = @"瘦身公开课";
            break;
         case HJThinBible_Incre:
             self.title = @"瘦身宝典";
            break;
        default:
            break;
    }
}
-(int)page{
    if (!_page) {
        _page = 1;
    }
    return _page;
}
- (void)addHeaderRefresh {
    
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerBeginRefresh)];
    header.lastUpdatedTimeKey = NSStringFromClass(self.class).lh_md5_32Bit_String;
    self.tableView.mj_header = header;
    //
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerBeginRefresh)];
    self.tableView.mj_footer = footer;
    self.page = 1;
    self.informationArr = [NSMutableArray array];
}

- (void)headerBeginRefresh {
    
    self.isHeader = YES;
    self.page = 1;
    [self netWorkRequest];
}

- (void)footerBeginRefresh {
    self.isHeader = NO;
    self.page ++;
    [self netWorkRequest];
}
/**
 *  加载数据完成
 */
- (void)loadDataFinish:(NSArray *)arr {

    if (_isHeader) {
        [self.informationArr removeAllObjects];
    }
    
    // 添加数据
    if (self.page > 1) {
        
        [self.informationArr addObjectsFromArray:arr];
    } else {
        
        self.informationArr = arr.mutableCopy;
    }
    
    BOOL noMoreData = (arr.count == 0 || arr.count < KpageSize);
    
    
    [self endRefreshing:noMoreData];
}

/**
 *  结束刷新
 */
- (void)endRefreshing:(BOOL)noMoreData {
    
        // 取消刷新
        if (self.tableView.mj_header.isRefreshing) {
            [self.tableView.mj_header endRefreshing];
        }
        else if (self.tableView.mj_footer.isRefreshing) {
            [self.tableView.mj_footer endRefreshing];
        }
    // 判断还有没有数据
    if (noMoreData) {
        self.tableView.mj_footer.hidden = YES;
        //self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
    }
    else {
        self.tableView.mj_footer.hidden = NO;
    }
    // 数据重载
    [self.tableView reloadData];
}

#pragma mark--------------netWorkingRequest----------------------

- (void)netWorkRequest {
    
    [[[HJInformationAPI getInformationListWithColumnId:self.columnId page:@(_page) rows:@(KpageSize)] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
        
        HJInformationAPI *api = responseObject;
        [self loadDataFinish:api.data.informationList];
        [self.tableView reloadData];
    }];
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.informationArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HJIncreCustemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HJIncreCustemCell" forIndexPath:indexPath];
    HJInformationModel *informationModel = self.informationArr[indexPath.row];
    cell.informationModel = informationModel;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HJInformationModel *informationModel = self.informationArr[indexPath.row];
    HJH5DetailWebViewVC *h5WebDetailVC = [HJH5DetailWebViewVC new];
    h5WebDetailVC.informationId = [NSString stringWithFormat:@"%ld",informationModel.informationId];
    [self.navigationController pushVC:h5WebDetailVC];
}

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
