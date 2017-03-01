//
//  HJSportIntroduceCell.m
//  Enjoy
//
//  Created by 邓朝文 on 16/5/4.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJSportIntroduceCell.h"
#import "HJSportDetailAPI.h"

@interface HJSportIntroduceCell ()
@property (nonatomic, weak) UILabel *introduceLabel;
@end
@implementation HJSportIntroduceCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"sportIntroduceCell";
    HJSportIntroduceCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[HJSportIntroduceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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

- (void)setSportMedel:(SportModel *)sportMedel
{
    if (sportMedel == nil) return;
    _sportMedel = sportMedel;
    self.introduceLabel.text = sportMedel.remark;
    
    CGSize size = [sportMedel.remark lh_sizeWithFont:FONT(15) constrainedToSize:CGSizeMake(SCREEN_WIDTH - 40, MAXFLOAT)];
    self.introduceLabel.frame = CGRectMake(20, 0, size.width, size.height + 10);
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.introduceLabel.frame.size.height + 10);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
