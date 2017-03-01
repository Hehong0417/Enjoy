//
//  HJIncreCustemCell.m
//  Enjoy
//
//  Created by IMAC on 16/5/30.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJIncreCustemCell.h"

@implementation HJIncreCustemCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setInformationModel:(HJInformationModel *)informationModel {
    
    _informationModel = informationModel;
    
    [self.icoImgV sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(_informationModel.ico)] placeholderImage:kImageNamed(@"placeholderImage")];
    self.titleLab.text = _informationModel.title;
    self.contentLab.text = _informationModel.content;
    self.createTimeLab.text = _informationModel.createTime;
    
    [self.goodNumBtn setTitle:[NSString stringWithFormat:@"%ld",informationModel.goodNum] forState:UIControlStateNormal];
    
    [self.commentNumBtn setTitle:[NSString stringWithFormat:@"%ld",informationModel.commentNum] forState:UIControlStateNormal];
    
    if (_informationModel.isNew == 1) {
        self.isNewImgV.hidden = NO;
    }else {
        self.isNewImgV.hidden = YES;
    }
}
@end
