//
//  ThreeCellSlimin.h
//  Enjoy
//
//  Created by IMAC on 16/3/15.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ThreeCellSliminDelegate <NSObject>
-(void)recordMovementPush;
@end

@interface ThreeCellSlimin : UITableViewCell

@property(nonatomic,weak)id<ThreeCellSliminDelegate>delegate;

@property (strong, nonatomic) IBOutlet UIButton *recordBtn;

@property (strong, nonatomic) IBOutlet UILabel *tipLabel;

@property (strong, nonatomic) IBOutlet UISlider *slider;
@property (strong, nonatomic) IBOutlet UILabel *minLabel;
@property (strong, nonatomic) IBOutlet UILabel *maxLabel;

@property (strong, nonatomic) UILabel *nowLabel;

+ (instancetype)initWithThreeCellSliminXib;

-(void)fillRuningTime:(NSString *)nowDesignCalory AndDesignCalory:(NSString *)designCalory AndDesignSportCalory:(NSString *)designSportCalory;

@end
