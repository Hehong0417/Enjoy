//
//  HJSportIntroduceCell.h
//  Enjoy
//
//  Created by 邓朝文 on 16/5/4.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SportModel;
@interface HJSportIntroduceCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) SportModel *sportMedel;
@end
