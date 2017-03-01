//
//  HJIncreCustemCell.h
//  Enjoy
//
//  Created by IMAC on 16/5/30.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJInformationAPI.h"

@interface HJIncreCustemCell : UITableViewCell
@property (nonatomic, strong) HJInformationModel *informationModel;
@property (strong, nonatomic) IBOutlet UIImageView *icoImgV;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UILabel *contentLab;
@property (strong, nonatomic) IBOutlet UILabel *createTimeLab;

@property (strong, nonatomic) IBOutlet UIButton *goodNumBtn;
@property (strong, nonatomic) IBOutlet UIButton *commentNumBtn;
@property (strong, nonatomic) IBOutlet UIImageView *isNewImgV;

@end
