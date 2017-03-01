//
//  ManagerNoteVC.m
//  Enjoy
//
//  Created by IMAC on 16/3/16.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "ManagerNoteVC.h"
#import "ManagerNotCell.h"

@interface ManagerNoteVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *mainTable;
}
@end

@implementation ManagerNoteVC

-(void)doSomeThingInViewDidLoad{
    NSArray *titleArr = @[@"管理师手记",
                         @"瘦身公开课",
                         @"瘦身宝典"];
    self.title = titleArr[self.stye-888];
    self.view.backgroundColor = [UIColor whiteColor];
    
    mainTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kDeviceWidth, KDeviceHeight-64) style:(UITableViewStylePlain)];
    mainTable.dataSource = self;
    mainTable.delegate = self;
    if ([mainTable respondsToSelector:@selector(setSeparatorInset:)]) {
        [mainTable setSeparatorInset:UIEdgeInsetsZero];
    }if ([mainTable respondsToSelector:@selector(setLayoutMargins:)]) {
        [mainTable setLayoutMargins:UIEdgeInsetsZero];
    }
    [self.view addSubview:mainTable];
}

#pragma mark-------UITableViewDelegate--------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ManagerNotCell *cell = [mainTable dequeueReusableCellWithIdentifier:@"ManagerNotCell"];
    if (cell == nil) {
        cell = [ManagerNotCell initManagerNotCellXib];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

@end
