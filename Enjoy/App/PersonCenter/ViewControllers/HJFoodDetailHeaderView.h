//
//  HJFoodDetailHeaderView.h
//  Enjoy
//
//  Created by 邓朝文 on 16/5/4.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HJFoodDetailModel;
@class SportModel;
@interface HJFoodDetailHeaderView : UIView
+ (HJFoodDetailHeaderView *)foodDetailHeaderView;
@property (nonatomic, strong) HJFoodDetailModel *foodmodel;
@property (nonatomic, strong) SportModel *sportModel;
@end
