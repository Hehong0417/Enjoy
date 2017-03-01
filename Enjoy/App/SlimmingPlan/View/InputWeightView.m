//
//  InputWeightView.m
//  Enjoy
//
//  Created by IMAC on 16/3/17.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "InputWeightView.h"

@interface InputWeightView() <UITextFieldDelegate>

@end

@implementation InputWeightView

- (void)awakeFromNib {
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    self.fview.layer.cornerRadius = 6;
    
    self.cancel.layer.borderWidth = 1;
    self.cancel.layer.borderColor = IWColor(118, 118, 118).CGColor;
    self.cancel.layer.cornerRadius = 3;
    
    self.determine.layer.cornerRadius = 3;
    
    [self.cancel addTarget:self action:@selector(cancelView) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.determine addTarget:self action:@selector(determineRecord) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.text.delegate = self;
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}

-(void)cancelView{
    [self removeFromSuperview];
}
- (NSString *)validWeight{
    
    if (self.text.text.floatValue<0) {
        
        return @"体重不能小于0";
    }else if(self.text.text.floatValue>220){
    
        return @"体重不能大于220";
    }
    return nil;
}
- (NSString *)validHeight {
    
    if (self.text.text.floatValue<0) {
        
        return @"身高不能小于0";
    }else if(self.text.text.floatValue>270){
        
        return @"身高不能大于270";
    }
    return nil;
    
}
-(void)determineRecord{
    
    NSLog(@"确定");

    if (self.text.text.length>0) {
        
        if (self.weightNum == 111) {
            NSString   *validWeight = [self validWeight];
            if (validWeight) {
                [SVProgressHUD showInfoWithStatus:validWeight];
            }else {
                
                self.nickBlock(self.text.text);
                [self removeFromSuperview];
            }
            
        }else if(self.heightNum == 111){
            
            NSString   *validHeight = [self validHeight];
            if (validHeight) {
                [SVProgressHUD showInfoWithStatus:validHeight];
            }else {
                self.nickBlock(self.text.text);
                [self removeFromSuperview];
            }

        }else {
            
            self.nickBlock(self.text.text);

            [self removeFromSuperview];

        }
        
    }else{
        
        [SVProgressHUD showInfoWithStatus:@"请输入"];
    }
    
}

+ (instancetype)initInputWeightViewXib{
    return [[[NSBundle mainBundle] loadNibNamed:@"InputWeightView" owner:nil options:nil] lastObject];
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.5 animations:^{
        self.fview.lh_centerY -= 80;
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.5 animations:^{
        self.fview.lh_centerY += 80;
    }];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.text) {
        if (string.length == 0) return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 6) {
            return NO;
        }
    }
    return YES;
}
@end
