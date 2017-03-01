//
//  HJNeswCell.h
//  Enjoy
//
//  Created by 邓朝文 on 16/5/10.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HJInformationList;
@class HJcolumnList;
@interface HJNeswCell : UITableViewCell
@property (nonatomic, strong) HJInformationList *inforMationmodel;
@property (nonatomic, strong) HJcolumnList *columnModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
