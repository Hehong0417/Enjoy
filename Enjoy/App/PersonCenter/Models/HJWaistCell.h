//
//  HJWaistCell.h
//  Enjoy
//
//  Created by IMAC on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJWaistHipListAPI.h"

@interface HJWaistCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *waistLineLab;
@property (strong, nonatomic) IBOutlet UILabel *hipLineLab;
@property (strong, nonatomic) IBOutlet UILabel *createTimeLab;
@property (nonatomic, strong) WaistHipListModel *waistHipModel;
@end
