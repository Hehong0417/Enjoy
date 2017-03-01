//
//  OneCellSlimin.h
//  Enjoy
//
//  Created by IMAC on 16/3/14.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJThinPlanHomeAPI.h"
#import "UIWaveView.h"
@protocol OneCellSliminDelegate <NSObject>
-(void)push:(NSInteger)stype;
@end

@interface OneCellSlimin : UITableViewCell
{
   UIButton *switcBtn;
}
@property (strong, nonatomic) NSString *menstruationStatus;
@property (weak, nonatomic) IBOutlet UILabel *tip;
@property (weak, nonatomic) IBOutlet UILabel *day;

@property (weak, nonatomic) IBOutlet UIButton *yesterdayBtn;

@property (weak, nonatomic) IBOutlet UIImageView *bottle;
@property (strong, nonatomic) IBOutlet UISwitch *hjSwich;
@property (strong, nonatomic) IBOutlet UILabel *changeTintLab;

@property (strong, nonatomic) IBOutlet UILabel *changeWeightLab;
@property (strong, nonatomic) IBOutlet UILabel *targetLab;

@property (nonatomic, strong) UIWaveView  *waveView;



+ (instancetype)initWithOneCellXib;

@property(nonatomic,weak)id<OneCellSliminDelegate>delegate;
@property (nonatomic, strong) HJThinPlanHomeModel  *thinPlanHomeModel;
@end
