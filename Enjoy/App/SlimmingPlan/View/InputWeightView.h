//
//  InputWeightView.h
//  Enjoy
//
//  Created by IMAC on 16/3/17.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputWeightView : UIView
@property (weak, nonatomic) IBOutlet UIView *fview;
@property (weak, nonatomic) IBOutlet UITextField *text;
@property (weak, nonatomic) IBOutlet UIButton *cancel;
@property (weak, nonatomic) IBOutlet UIButton *determine;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UILabel *KgLab;
@property (nonatomic, copy) idBlock nickBlock;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerY;
@property (nonatomic, assign) NSInteger weightNum;
@property (nonatomic, assign) NSInteger heightNum;

+ (instancetype)initInputWeightViewXib;
@end
