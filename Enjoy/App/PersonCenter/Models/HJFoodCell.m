//
//  HJFoodCell.m
//  Enjoy
//
//  Created by 邓朝文 on 16/4/27.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJFoodCell.h"
#import "HJFoodListAPI.h"
#import "HJSportListAPI.h"

@interface HJFoodCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
- (IBAction)clickRecordBtn:(id)sender;
@end

@implementation HJFoodCell
+ (HJFoodCell *)CellWithTableView:(UITableView *)tableView
{
    static NSString *str = @"foodCell";
    HJFoodCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HJFoodCell" owner:nil options:nil] lastObject];
    }
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        self = [[HJFoodCell alloc] init];
    }
    return self;
}


- (void)setFoodModel:(HJFoodModel *)foodModel
{
    _foodModel = foodModel;
    self.titleLabel.text = foodModel.name;
    double i = foodModel.calory/(double)foodModel.weight;
    NSInteger newCalory = i * 100;
    self.descLabel.text = [NSString stringWithFormat:@"%ld大卡/100克", (long)newCalory];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(foodModel.ico)]placeholderImage:kImageNamed(@"placeholderImage")];
}

- (void)setSportModel:(HJSportModel *)sportModel
{
    _sportModel = sportModel;
    self.titleLabel.text = sportModel.name;
    self.descLabel.text = [NSString stringWithFormat:@"%ld大卡/%ld小时", (long)sportModel.calory, (long)sportModel.time];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(sportModel.ico)]placeholderImage:kImageNamed(@"placeholderImage")];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.imageView setFrame:CGRectMake(15, 10, 70, 70)];
}

- (IBAction)clickRecordBtn:(id)sender
{
    if (self.foodModel) {
        if ([self.delegate respondsToSelector:@selector(foodCellClickRecordButton:)]) {
            [self.delegate foodCellClickRecordButton:self];
        }
    } else if (self.sportModel){
        if ([self.delegate respondsToSelector:@selector(sportCellClickRecordButton:)]) {
            [self.delegate sportCellClickRecordButton:self];
        }
    }
}
@end
