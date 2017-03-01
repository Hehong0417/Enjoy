//
//  OnlineMessageVC.m
//  Enjoy
//
//  Created by IMAC on 16/3/22.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "OnlineMessageVC.h"

@interface OnlineMessageVC ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation OnlineMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"在线留言";
    self.automaticallyAdjustsScrollViewInsets = NO;
}


#pragma mark---------UITableViewDelegate-------------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:str];
    }
    cell.textLabel.text = @"124";
    return cell;
}



@end
