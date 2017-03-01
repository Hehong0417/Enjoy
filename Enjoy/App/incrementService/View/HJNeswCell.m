//
//  HJNeswCell.m
//  Enjoy
//
//  Created by 邓朝文 on 16/5/10.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJNeswCell.h"
#import "HJAddServiceHomeAPI.h"

@interface HJNeswCell()
@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIImageView *newsView;
@end

@implementation HJNeswCell


+ (instancetype)cellWithTableView:(UITableView *)tableView
{

    static NSString *ID = @"neswCell";
    HJNeswCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[HJNeswCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *iconView = [[UIImageView alloc] init];
        iconView.image = [UIImage imageNamed:@"ic_a12_01"];
        [self.contentView addSubview:iconView];
        self.iconView = iconView;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = FONT(14);
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UIImageView *newsView = [[UIImageView alloc] init];
        newsView.image = [UIImage imageNamed:@"ic_b1_1"];
        [self.contentView addSubview:newsView];
        self.newsView = newsView;

    }
    return self;
}

- (void)setInforMationmodel:(HJInformationList *)inforMationmodel
{
    self.iconView.hidden = NO;
    _inforMationmodel = inforMationmodel;
    self.titleLabel.text = inforMationmodel.title;
    
    self.iconView.frame = CGRectMake(10, 17, 10, 10);
    CGSize size = [inforMationmodel.title lh_sizeWithFont:FONT(14) constrainedToSize:CGSizeMake(SCREEN_WIDTH, 44)];
    self.titleLabel.frame = CGRectMake(30, 0, size.width, 44);
    if (inforMationmodel.isNew) {
        self.newsView.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame) + 1, 16, 18, 6);
        self.newsView.hidden = NO;
    } else {
        self.newsView.hidden = YES;
    }
}

- (void)setColumnModel:(HJcolumnList *)columnModel
{
    self.iconView.hidden = YES;
    _columnModel = columnModel;
    self.titleLabel.text = @"更多";
    CGSize size = [self.titleLabel.text lh_sizeWithFont:FONT(14) constrainedToSize:CGSizeMake(SCREEN_WIDTH, 44)];
    self.titleLabel.frame = CGRectMake(0, 0, size.width, 44);
    self.titleLabel.lh_centerX = SCREEN_WIDTH * 0.5;
    if (columnModel.isNew) {
        self.newsView.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame) + 1, 16, 18, 6);
        self.newsView.hidden = NO;
    } else {
        self.newsView.hidden = YES;
    }
}

@end
