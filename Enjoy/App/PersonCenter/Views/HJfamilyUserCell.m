//
//  HJfamilyUserCell.m
//  Enjoy
//
//  Created by IMAC on 16/2/26.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import "HJfamilyUserCell.h"
#import "HJFamilyUserListAPI.h"

@interface HJfamilyUserCell()
@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIButton *sexButton;

@end
@implementation HJfamilyUserCell

- (void)awakeFromNib {
    // Initialization code
    [self.photo lh_setCornerRadius:29 borderWidth:2 borderColor:kWhiteColor];
    self.photo.backgroundColor = APP_COMMON_COLOR;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"familyUserCell";
    HJfamilyUserCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HJfamilyUserCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)setModel:(HJFamilyUserModel *)model
{
    _model = model;
    NSString *imgName;
    if (model.sex) {
        //女
        imgName = @"ic_c20_4";
        
    }else{
        imgName = @"ic_c20_3";
    }

    [self.photo sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(model.photo)] placeholderImage:kImageNamed(imgName)];
    self.name.text = model.name;
    // 设置性别图片
    if (model.sex) { // 女
        [self.sexButton setImage:[UIImage imageNamed:@"ic_c1_02"] forState:UIControlStateNormal];
    } else { // 男
        [self.sexButton setImage:[UIImage imageNamed:@"ic_a17_01"] forState:UIControlStateNormal];
    }
}

@end
