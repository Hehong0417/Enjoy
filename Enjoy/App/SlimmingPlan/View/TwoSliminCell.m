//
//  TwoSliminCell.m
//  Enjoy
//
//  Created by IMAC on 16/3/14.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "TwoSliminCell.h"
#import "InputWeightView.h"
#import "HJAddWeightAPI.h"

@implementation TwoSliminCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.recordWeight addTarget:self action:@selector(record) forControlEvents:(UIControlEventTouchUpInside)];
    [self.fatSaid addTarget:self action:@selector(fat) forControlEvents:(UIControlEventTouchUpInside)];
}

-(void)record{
    NSLog(@"记录");
    
    InputWeightView *view = [InputWeightView initInputWeightViewXib];
    view.frame = CGRectMake(0, 0, kDeviceWidth, KDeviceHeight);
    //WEAK_SELF();
    view.nickBlock = ^(NSString *weight){
       //录入当日体重
        [[[HJAddWeightAPI addWeightWithWeight:weight] netWorkClient] postRequestInView:self successBlock:^(id responseObject) {
            HJAddWeightAPI *api = responseObject;
            if (api.code == 1) {
                [self.delegate addWeightSuccess];
            }
        }];
    };
    [self.window addSubview:view];
}

-(void)fat{
    NSLog(@"链接脂称");
    self.fatBlock();
}

+ (instancetype)initWithTwoSliminCellXib{
    return [[[NSBundle mainBundle] loadNibNamed:@"TwoSliminCell" owner:nil options:nil] lastObject];
}
- (void)setThinPlanHomeModel:(HJThinPlanHomeModel *)thinPlanHomeModel {
    _thinPlanHomeModel = thinPlanHomeModel;
    self.weightLab.text = [NSString stringWithFormat:@"%@KG",thinPlanHomeModel.weight];
}
@end
