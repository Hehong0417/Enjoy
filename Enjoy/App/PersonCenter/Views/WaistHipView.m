//
//  WaistHipView.m
//  Enjoy
//
//  Created by IMAC on 16/5/7.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "WaistHipView.h"

@interface WaistHipView ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIView *fWaistView;
@property (weak, nonatomic) IBOutlet UITextField *waistlineTF;
@property (weak, nonatomic) IBOutlet UITextField *hiplineTF;
@property (weak, nonatomic) IBOutlet UIButton *cancel;
@property (weak, nonatomic) IBOutlet UIButton *determine;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;

@end

@implementation WaistHipView

- (void)awakeFromNib {
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    self.fWaistView.layer.cornerRadius = 6;

    self.cancel.layer.borderWidth = 1;
    self.cancel.layer.borderColor = IWColor(118, 118, 118).CGColor;
    self.cancel.layer.cornerRadius = 3;
    
    self.determine.layer.cornerRadius = 3;
    
    [self.cancel addTarget:self action:@selector(cancelView) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.determine addTarget:self action:@selector(determineRecord) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.waistlineTF.delegate = self;
    self.hiplineTF.delegate = self;
    
    //设置waistlineTF
    self.waistlineTF.leftView = [UILabel lh_labelWithFrame:CGRectMake(0, 0, 40, 28) text:@"腰围" textColor:kFontGrayColor font:FONT(14) textAlignment:NSTextAlignmentLeft backgroundColor:kClearColor];
    self.waistlineTF.leftViewMode = UITextFieldViewModeAlways;
    
    self.waistlineTF.rightView = [UILabel lh_labelWithFrame:CGRectMake(0, 0, 40, 28) text:@"cm" textColor:kFontGrayColor font:FONT(14) textAlignment:NSTextAlignmentRight backgroundColor:kClearColor];
    self.waistlineTF.rightViewMode = UITextFieldViewModeAlways;
    
    
    //设置hiplineTF
    self.hiplineTF.leftView = [UILabel lh_labelWithFrame:CGRectMake(0, 0, 40, 28) text:@"臀围" textColor:kFontGrayColor font:FONT(14) textAlignment:NSTextAlignmentLeft backgroundColor:kClearColor];
    self.hiplineTF.leftViewMode = UITextFieldViewModeAlways;

    self.hiplineTF.rightView = [UILabel lh_labelWithFrame:CGRectMake(0, 0, 40, 28) text:@"cm" textColor:kFontGrayColor font:FONT(14) textAlignment:NSTextAlignmentRight backgroundColor:kClearColor];
    self.hiplineTF.rightViewMode = UITextFieldViewModeAlways;
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}

-(void)cancelView{
    [self removeFromSuperview];
}
-(void)determineRecord{
    NSLog(@"确定");
    if (self.waistlineTF.text.length == 0) {
        
        [SVProgressHUD showInfoWithStatus:@"请填写腰围"];
        
    }else if (self.hiplineTF.text.length == 0){
        
        [SVProgressHUD showInfoWithStatus:@"请填写臀围"];
    }else {
        self.waistBlock2(self.waistlineTF.text,self.hiplineTF.text);
        [self removeFromSuperview];
    }
}

+ (instancetype)initWaistHipViewXib{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"WaistHipView" owner:nil options:nil] lastObject];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.5 animations:^{
        self.fWaistView.lh_centerY -= 80;
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.5 animations:^{
        self.fWaistView.lh_centerY += 80;
    }];
}
@end
