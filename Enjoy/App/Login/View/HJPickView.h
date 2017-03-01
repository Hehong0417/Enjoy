//
//  HJPIckView.h
//  Enjoy
//
//  Created by Pro on 16/4/21.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    
    HJPickViewStyleNone,
    
    HJPickViewStyleDate,
    
    HJPickViewStyleTable,
    
} HJPickViewStyle;
typedef enum {
    
    HJHeightStyle,
    
    HJJobStyle,
    
    HJRegionStyle,
    
    HJSexStyle
    
} HJPersonInfoStyle;

@interface HJPickView : UIView
@property (strong, nonatomic) IBOutlet UIDatePicker *timePick;
@property (strong, nonatomic) IBOutlet UIView *timePickView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIPickerView *pickView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, copy) idBlock dateBlock;
@property (nonatomic, copy) voidBlock sureBlock;
@property (nonatomic ,assign) HJPickViewStyle  pickViewStyle;
@property (nonatomic, assign) HJPersonInfoStyle personInfoStyle;
- (void)pickViewWithStyle:(HJPickViewStyle)pickViewStyle;
- (void)dismiss;
@end
