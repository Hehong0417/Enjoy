//
//  ManagerNotCell.m
//  Enjoy
//
//  Created by IMAC on 16/3/16.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "ManagerNotCell.h"

@implementation ManagerNotCell

- (void)awakeFromNib {
    // Initialization code
}

+(instancetype)initManagerNotCellXib{
    return [[[NSBundle mainBundle] loadNibNamed:@"ManagerNotCell" owner:nil options:nil] lastObject];
}


@end
