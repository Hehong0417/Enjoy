//
//  HJDetailTwoCell.m
//  Enjoy
//
//  Created by IMAC on 16/2/26.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import "HJDetailTwoCell.h"

@implementation HJDetailTwoCell

- (void)awakeFromNib {
    // Initialization code
}


- (IBAction)clickCallButton:(id)sender {
    if (self.callBlock != nil) {
        self.callBlock();
    }
}

@end
