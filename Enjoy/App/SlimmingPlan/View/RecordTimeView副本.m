//
//  RecordTimeView.m
//  Enjoy
//
//  Created by IMAC on 16/3/21.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "RecordTimeView.h"
#import "HJAddSportReportAPI.h"
#import "HJFoodListAPI.h"
#import "HJSportListAPI.h"

@implementation RecordTimeView

- (void)awakeFromNib {
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    self.view.layer.cornerRadius = 5;
    self.cancel.layer.cornerRadius = 5;
    self.determine.layer.cornerRadius = 5;
    
}

- (void)setFoodModel:(HJFoodModel *)foodModel
{
    _foodModel = foodModel;
    self.mainTitle.text = @"记录食物重量";
    self.descTitle.text = @"克";
    self.title.text = foodModel.name;
    self.timeStr.text = [NSString stringWithFormat:@"%d大卡/%d克",foodModel.calory, foodModel.weight];
}

- (void)setSportModel:(HJSportModel *)sportModel
{
    _sportModel = sportModel;
    self.mainTitle.text = @"记录运动时间";
    self.descTitle.text = @"分钟";
    self.title.text = sportModel.name;
    self.timeStr.text = [NSString stringWithFormat:@"%d大卡/%d分钟", sportModel.calory, sportModel.time];
}

- (IBAction)cancelM:(id)sender {
    [self removeFromSuperview];
}

- (IBAction)clickDetermineButton:(id)sender {
    if (self.returnTitleBlock != nil) {
        self.returnTitleBlock(self.timeTextFile.text);
    }
}

- (void)returnText:(ReturnTitleBlock)block
{
    self.returnTitleBlock = block;
}

+ (instancetype)initRecordTimeViewXib{
    return [[[NSBundle mainBundle] loadNibNamed:@"RecordTimeView" owner:nil options:nil] lastObject];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}

@end
