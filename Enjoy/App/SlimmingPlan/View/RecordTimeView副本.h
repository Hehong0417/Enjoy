//
//  RecordTimeView.h
//  Enjoy
//
//  Created by IMAC on 16/3/21.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HJFoodModel;
@class HJSportModel;
typedef void (^ReturnTitleBlock) (NSString *titleText);

@interface RecordTimeView : UIView

@property (strong, nonatomic) IBOutlet UIView *view;

@property (strong, nonatomic) IBOutlet UILabel *title;

@property (strong, nonatomic) IBOutlet UILabel *timeStr;
/**
 *  主标题
 */
@property (weak, nonatomic) IBOutlet UILabel *mainTitle;
/**
 *  单位
 */
@property (weak, nonatomic) IBOutlet UILabel *descTitle;

@property (strong, nonatomic) IBOutlet UITextField *timeTextFile;

@property (strong, nonatomic) IBOutlet UIButton *cancel;

@property (strong, nonatomic) IBOutlet UIButton *determine;

@property (nonatomic, strong) NSNumber *Id;

@property (nonatomic, copy) ReturnTitleBlock returnTitleBlock;

@property (nonatomic, strong) HJFoodModel *foodModel;
@property (nonatomic, strong) HJSportModel *sportModel;

- (IBAction)clickDetermineButton:(id)sender;

- (void)returnText:(ReturnTitleBlock)block;

+ (instancetype)initRecordTimeViewXib;
@end
