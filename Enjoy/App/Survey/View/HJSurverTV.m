//
//  HJSurverTV.m
//  Enjoy
//
//  Created by IMAC on 16/4/30.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJSurverTV.h"


@interface HJSurverTV ()<UITableViewDataSource,UITableViewDelegate>
{
    UILabel *title;
}
@property (nonatomic, strong) HJSurverListModel *ListModel;
@end

@implementation HJSurverTV

- (void)viewDidLoad {
    [super viewDidLoad];
    
    title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 44)];
    title.backgroundColor = [UIColor whiteColor];
    title.font = [UIFont systemFontOfSize:15];
    _mainTable.tableHeaderView = title;
}

-(void)viewWillAppear:(BOOL)animated{
    
    title.text = [NSString stringWithFormat:@"  %@、%@",_infoModel.Id,_infoModel.name];
    [self getSurverList];
}

#pragma mark--------------netWorkingRequest----------------------
//获取问卷调查各类型列表
- (void)getSurverList {
    [[[HJSurverListAPI getList:_infoModel.Id AndPage:@1 rows:@100] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
        HJSurverListAPI *api = responseObject;
        _ListModel = api.data;
        [self.mainTable reloadData];
    }];
}


#pragma mark--------------UITableViewDelegate----------------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _ListModel.questionList.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    HJquestionListModel *questionListModel = _ListModel.questionList[section];
    return questionListModel.answerList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    HJquestionListModel *model = _ListModel.questionList[section];
    return [NSString stringWithFormat:@"%ld)%@",section,model.content];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = [NSString stringWithFormat:@"%ld%ldcell",indexPath.section,indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:str];
    }
    HJquestionListModel *questionListModel = _ListModel.questionList[indexPath.section];
    HJanswerListModel *answerListModel = questionListModel.answerList[indexPath.row];
    cell.textLabel.text = answerListModel.content;
    return cell;
    
}

@end
