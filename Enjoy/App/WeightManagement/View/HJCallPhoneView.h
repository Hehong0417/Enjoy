//
//  HJCallPhoneView.h
//  Enjoy
//
//  Created by 邓朝文 on 16/5/10.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJCallPhoneView : UIView
- (IBAction)cancelClick:(id)sender;
- (IBAction)certanClick:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *certanButton;

+ (instancetype)callPhoneView;
@property (nonatomic, strong) voidBlock certanBlack;
@end
