//
//  HJCallPhoneView.m
//  Enjoy
//
//  Created by 邓朝文 on 16/5/10.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJCallPhoneView.h"

@implementation HJCallPhoneView

+ (instancetype)callPhoneView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"HJCallPhoneView" owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    self.cancelButton.layer.cornerRadius = 3;
    self.certanButton.layer.cornerRadius = 3;
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}

- (IBAction)cancelClick:(id)sender {
    [self removeFromSuperview];
}

- (IBAction)certanClick:(id)sender {
    self.certanBlack();
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}


@end
