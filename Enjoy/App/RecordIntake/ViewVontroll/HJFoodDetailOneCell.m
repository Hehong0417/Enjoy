//
//  HJFoodDetailOneCell.m
//  Enjoy
//
//  Created by IMAC on 16/4/26.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJFoodDetailOneCell.h"
#import "HJFoodDetailAPI.h"
#import "HJSportDetailAPI.h"

@interface HJFoodDetailOneCell ()
@property (nonatomic, weak) UILabel *introduceLabel;
@end
@implementation HJFoodDetailOneCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"foodDetailOneCell";
    HJFoodDetailOneCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[HJFoodDetailOneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *introduceLabel = [[UILabel alloc] init];
        introduceLabel.numberOfLines = 0;
        introduceLabel.font = FONT(15);
        [self.contentView addSubview:introduceLabel];
        self.introduceLabel = introduceLabel;
    }
    return self;
}

- (void)setFoodDetailModel:(HJFoodDetailModel *)foodDetailModel
{
    if (foodDetailModel == nil) return;
    _foodDetailModel = foodDetailModel;
    self.introduceLabel.text = foodDetailModel.remark;
    
    CGSize size = [foodDetailModel.remark lh_sizeWithFont:FONT(15) constrainedToSize:CGSizeMake(SCREEN_WIDTH - 40, MAXFLOAT)];
    self.introduceLabel.frame = CGRectMake(20, 10, size.width, size.height + 10);
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.introduceLabel.frame.size.height + 20);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


@end
