//
//  DiaryCell.m
//  Enjoy
//
//  Created by IMAC on 16/3/16.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "DiaryCell.h"

@implementation DiaryCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.ViewBtn.layer.cornerRadius = 6;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [self.ViewBtn addGestureRecognizer:tap];
    
}

-(void)tap{
    NSLog(@"记录减肥日记");
    [self.delegate pushDiaryEditor];
}

+ (instancetype)initWithDiaryCellSliminXib{
    return [[[NSBundle mainBundle] loadNibNamed:@"DiaryCell" owner:nil options:nil] lastObject];
}

@end
