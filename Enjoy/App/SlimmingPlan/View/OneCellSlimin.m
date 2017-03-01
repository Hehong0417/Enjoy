//
//  OneCellSlimin.m
//  Enjoy
//
//  Created by IMAC on 16/3/14.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import "OneCellSlimin.h"

#import "ZJSwitch.h"
#import "HJUser.h"
#import "HJUserDetailAPI.h"
#import "HJcompleteUserInfoAPI.h"
@implementation OneCellSlimin

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.yesterdayBtn addTarget:self action:@selector(pushNavi) forControlEvents:(UIControlEventTouchUpInside)];
    
    _waveView = [[UIWaveView alloc] initWithFrame:CGRectMake(kDeviceWidth/2-(self.bottle.frame.size.width-5)/2, self.bottle.frame.origin.y+4,self.bottle.frame.size.width-5 , self.bottle.frame.size.height-5)];
    _waveView.clipsToBounds = YES;
    _waveView.layer.cornerRadius = 130/2;
    _waveView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_waveView];
    
    
    self.bottle.hidden = YES;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(_waveView.frame.origin.x, _waveView.frame.origin.y, _waveView.frame.size.width, _waveView.frame.size.height)];
    label.layer.borderColor = IWColor(148, 222, 110).CGColor;
    label.clipsToBounds = NO;
    label.layer.cornerRadius = 65;
    label.layer.borderWidth = 5;
    [self addSubview:label];
    
    
    [self.contentView addSubview:self.tip];
    [self.contentView addSubview:self.day];
    
    self.hjSwich.hidden = YES;
    
    switcBtn = [[UIButton alloc]init];
    switcBtn.frame = CGRectMake(LH_ScreenWidth-90, self.hjSwich.frame.origin.y+5, 80, 30);
    switcBtn.hidden = YES;
    [switcBtn setBackgroundImage:[UIImage imageNamed:@"ic_a33_02_pre"] forState:(UIControlStateSelected)];
    [switcBtn setBackgroundImage:[UIImage imageNamed:@"ic_a33_02"] forState:(UIControlStateNormal)];

    switcBtn.tag  = 100;
    [switcBtn addTarget:self action:@selector(stateSwitch:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:switcBtn];
    
}

-(void)stateSwitch:(id)sender{
    UIButton *btn = sender;
    btn.selected = !btn.selected;
   NSString *IsMenstruation = btn.selected?@"1":@"0";
    [self writeYiMaState:IsMenstruation];
}
- (void)writeYiMaState:(NSString *)IsMenstruation {
    
    [[[HJcompleteUserInfoAPI completeUserInfoWithIsMenstruation:IsMenstruation] netWorkClient] postRequestInView:self successBlock:^(id responseObject) {
        
    }];
    
}
- (void)handleSwitchEvent:(id)sender
{
    NSLog(@"%s", __FUNCTION__);
}


-(void)pushNavi{
    [self.delegate push:1];
}

- (IBAction)changeTarget:(id)sender {
    [self.delegate push:2];
}

+ (instancetype)initWithOneCellXib{
    return [[[NSBundle mainBundle] loadNibNamed:@"OneCellSlimin" owner:nil options:nil] lastObject];
}
-(void)setThinPlanHomeModel:(HJThinPlanHomeModel *)thinPlanHomeModel {
    _thinPlanHomeModel = thinPlanHomeModel;
    
    _waveView.startY = 130-_thinPlanHomeModel.continueDays*13/3;
    self.day.text = [NSString stringWithFormat:@"%ld天",(long)thinPlanHomeModel.continueDays];
    NSString *changeWeight = [NSString stringWithFormat:@"%ld",(long)thinPlanHomeModel.changeWeight];
    self.changeWeightLab.text =[NSString stringWithFormat:@"%0.1f斤",[changeWeight floatValue]];
    self.targetLab.text = thinPlanHomeModel.target;
    if ([thinPlanHomeModel.isMenstruation isEqualToString:@"-1"]) {
        
        switcBtn.hidden = YES;
       
    }else {
        
        switcBtn.hidden = NO;
        
        if ([thinPlanHomeModel.isMenstruation isEqualToString:@"0"]) {
            
            switcBtn.selected = NO;
            
        }else {
            switcBtn.selected = YES;
        }
    }
}
@end
