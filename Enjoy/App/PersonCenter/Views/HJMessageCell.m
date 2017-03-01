//
//  HJMessageCell.m
//  Enjoy
//
//  Created by IMAC on 16/2/27.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import "HJMessageCell.h"


@interface HJMessageCell ()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *pushTime;

@end

@implementation HJMessageCell

- (void)awakeFromNib {
    // Initialization code
}

+ (HJMessageCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"messageCell";
    HJMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HJMessageCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)setModel:(HJMessageListlModel *)model
{
    _model = model;
    self.title.text = model.title;
    self.pushTime.text = model.pushTime;
}

@end
