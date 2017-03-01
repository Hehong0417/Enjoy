//
//  HJFoodDetailTwoCell.m
//  Enjoy
//
//  Created by IMAC on 16/4/26.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJFoodDetailTwoCell.h"

@interface HJFoodDetailTwoCell ()
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIImageView *arrowView;
@property (nonatomic, weak) UIView *baseView;
@end

@implementation HJFoodDetailTwoCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"foodDetailTwoCell";
    HJFoodDetailTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[HJFoodDetailTwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *baseView = [[UIView alloc] init];
        [self.contentView addSubview:baseView];
        self.baseView = baseView;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        [baseView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UIImageView *arrowView = [[UIImageView alloc] init];
        [baseView addSubview:arrowView];
        self.arrowView = arrowView;
        
    }
    return self;
}

- (void)setSection:(NSInteger)section
{
    if (section == 1) {
        self.titleLabel.text = @"展开";
        CGSize size = [self.titleLabel.text lh_sizeWithFont:FONT(15) constrainedToSize:CGSizeMake(SCREEN_WIDTH, 44)];
        self.titleLabel.frame = CGRectMake(0, 0, size.width, size.height);
        self.baseView.frame = CGRectMake(0, 0, size.width, 44);
    } else {
        self.titleLabel.text = @"查看更多营养信息";
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
