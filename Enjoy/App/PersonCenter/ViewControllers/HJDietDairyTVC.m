//
//  HJDietDairyTVC.m
//  Enjoy
//
//  Created by IMAC on 16/2/26.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import "HJDietDairyTVC.h"
#import "HJDairyCell.h"

@interface HJDietDairyTVC ()

@end

@implementation HJDietDairyTVC

#pragma mark - HJViewControllerProtocol
- (void)doSomeThingInViewDidLoad {
    
   self.title = @"减肥日记";
   self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone
    ;
}

#pragma mark - Actions



#pragma mark - Methods


#pragma mark - HJTableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"HJDairyCell";
    HJDairyCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HJDairyCell" owner:self options:nil] firstObject];
    }
    
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return WidthScaleSize(180);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.1;
}
#pragma mark - HJDataHandlerProtocol



#pragma mark - Setter&Getter



@end
