//
//  recommendedCell.m
//  Enjoy
//
//  Created by IMAC on 16/3/21.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "recommendedCell.h"
#import "RecordTimeView.h"
#import "HJAddSportReportAPI.h"

@implementation recommendedCell

- (id)initWithCoder:(NSCoder*)coder

{
    
    if (self =[super initWithCoder:coder]) {
        
    }
    
    return self;
    
}

- (void)awakeFromNib {
    
    [_hjSlider setThumbImage:[UIImage imageNamed:@"ic_a2_03_pre"] forState:UIControlStateNormal];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.changeBtn.layer.cornerRadius = 12.5;
    self.recordTime.layer.cornerRadius= 6;
    
    self.image.clipsToBounds = YES;
    self.image.layer.cornerRadius = 6;
    
    
    _nowTime = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
    _nowTime.font = [UIFont systemFontOfSize:13];
    _nowTime.textColor = [UIColor blackColor];
    [self.contentView addSubview:_nowTime];
}


- (IBAction)pushSportsLibrary:(id)sender {
    NSLog(@"运动库");
    [self.delegate pushSportsLibrary];
}
- (IBAction)recordTimeM:(id)sender {
    
    self.view = [RecordTimeView initRecordTimeViewXib];
    self.view.frame = CGRectMake(0, 0, kDeviceWidth, KDeviceHeight);
    self.view.title.text = _recommentSportModel.name;
    self.view.timeStr.text = _BeginSportModel.caloryTime;
    [self.window addSubview:self.view];
    
    [self.view.determine lh_setTapActionWithBlock:^{
        [self.view removeFromSuperview];
        self.sportViewBlock(self.view.timeTextFile.text);
    }];
}

+ (instancetype)initWithRecommendedCellXib{
    return [[[NSBundle mainBundle] loadNibNamed:@"recommendedCell" owner:nil options:nil] lastObject];
}

- (void)fillBeginSportModel:(HJBeginSportModel *)BeginSportModel {
    _BeginSportModel = BeginSportModel;
    //view.title运动类型
    self.view.timeStr.text = BeginSportModel.caloryTime;
}

- (void)fillRecommentSportModel:(HJRecommentSportModel *)recommentSportModel {
    
    _recommentSportModel = recommentSportModel;
    
    if ([_recommentSportModel.gottenTime floatValue]/_recommentSportModel.time>1) {
        _hjSlider.value = 1;
    }else{
        _hjSlider.value = [_recommentSportModel.gottenTime floatValue]/_recommentSportModel.time;
    }
    if (_hjSlider.value!=0) {
        [_hjSlider setThumbImage:[UIImage imageNamed:@"ic_a2_03_pre"] forState:UIControlStateNormal];
        _nowTime.text = [NSString stringWithFormat:@"%@分钟",_recommentSportModel.gottenTime];
        _nowTime.center = CGPointMake(_hjSlider.frame.origin.x+WidthScaleSize(_hjSlider.frame.size.width)*_hjSlider.value, _hjSlider.frame.origin.y-10);
    }
    
    [self.image sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(recommentSportModel.ico)] placeholderImage:[UIImage imageNamed:@"placeholderImage.png"]];
    self.remarkLab.text = recommentSportModel.name;
    self.runTime.text = [NSString stringWithFormat:@"运动了%@分钟",recommentSportModel.gottenTime];
    
    _totalTimeLab.text = [NSString stringWithFormat:@"%ld分钟",(long)_recommentSportModel.time];
}

@end
