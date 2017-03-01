//
//  recommendedCell.h
//  Enjoy
//
//  Created by IMAC on 16/3/21.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJBeginSportAPI.h"
#import "RecordTimeView.h"

@protocol recommendedCellDelegate <NSObject>
-(void)pushSportsLibrary;
@end


@interface recommendedCell : UITableViewCell
@property (nonatomic, strong) RecordTimeView *view;
@property (nonatomic, weak) id<recommendedCellDelegate>delegate;
@property (strong, nonatomic) IBOutlet UIButton *changeBtn;
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *runTime;
@property (strong, nonatomic) IBOutlet UILabel *remarkLab;
@property (strong, nonatomic) IBOutlet UIButton *recordTime;

@property (strong, nonatomic) IBOutlet UILabel *totalTimeLab;


@property (strong, nonatomic) IBOutlet UISlider *hjSlider;

@property (nonatomic, strong) HJBeginSportModel *BeginSportModel;
@property (nonatomic, strong) HJRecommentSportModel *recommentSportModel;
@property (strong, nonatomic) UILabel *runingTime;


@property (nonatomic, copy) idBlock sportViewBlock;

@property (strong, nonatomic) UILabel *nowTime;

+ (instancetype)initWithRecommendedCellXib;

- (void)fillBeginSportModel:(HJBeginSportModel *)BeginSportModel ;

- (void)fillRecommentSportModel:(HJRecommentSportModel *)recommentSportModel ;

@end
