//
//  HJWaistCell.m
//  Enjoy
//
//  Created by IMAC on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJWaistCell.h"

@implementation HJWaistCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setWaistHipModel:(WaistHipListModel *)waistHipModel {
    _waistHipModel = waistHipModel;
    self.waistLineLab.text = [NSString stringWithFormat:@"腰围：%@cm",waistHipModel.waistline];
    self.hipLineLab.text = [NSString stringWithFormat:@"臀围：%@cm",waistHipModel.hipline];
    self.createTimeLab.text = waistHipModel.createTime;
}
@end
