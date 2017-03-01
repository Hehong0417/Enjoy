//
//  HJFeedbackVC.m
//  Enjoy
//
//  Created by IMAC on 16/2/27.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import "HJFeedbackVC.h"
#import "HJAddFeedBackAPI.h"

#define KSuggestLabText @"在这里写下您的建议吧"

@interface HJFeedbackVC ()<UITextViewDelegate, UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextView *textView;

@property (nonatomic, strong) UILabel *suggestLabel;
@property (weak, nonatomic) IBOutlet UITextField *phoneView;
@property (weak, nonatomic) IBOutlet UIButton *commitButton;
- (IBAction)clickCommit:(id)sender;


@end

@implementation HJFeedbackVC

#pragma mark - HJViewControllerProtocol

- (void)doSomeThingInViewDidLoad {
    
    self.title = @"意见反馈";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.textView.delegate = self;
    self.phoneView.delegate = self;
    [self.textView addSubview:self.suggestLabel];
    
    UILabel *leftView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 7, self.phoneView.lh_height)];
    self.phoneView.leftViewMode = UITextFieldViewModeAlways;
    self.phoneView.leftView = leftView;
}

#pragma mark - Actions
- (IBAction)clickCommit:(id)sender {
    if (!self.textView.text.length) {
        [SVProgressHUD showInfoWithStatus:@"请填写您的建议"];
        return;
        
    } else if (!self.phoneView.text.length) {
        [SVProgressHUD showInfoWithStatus:@"请填写您的手机号码"];
        return;
    }
    else {
        [[[HJAddFeedBackAPI addFeedBackWithContent:self.textView.text phone:self.phoneView.text] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
            [SVProgressHUD showSuccessWithStatus:@"发送成功，感谢您的反馈"];
            self.textView.text = nil;
            self.phoneView.text = nil;
        }];
    }
}
#pragma mark - Methods


#pragma mark - TextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self.suggestLabel setHidden:YES];
}

- (void)textViewDidChange:(UITextView *)textView
{
    if ([textView.text length] == 0) {
        [self.suggestLabel setHidden:NO];
    }else{
        [self.suggestLabel setHidden:YES];
    }
}

- (UILabel *)suggestLabel {
    if (!_suggestLabel) {
        _suggestLabel = [UILabel lh_labelWithFrame:CGRectMake(10, 5, SCREEN_WIDTH-10, 20) text:KSuggestLabText textColor:kFontGrayColor font:FontNormalSize textAlignment:NSTextAlignmentLeft backgroundColor:[UIColor clearColor]];
        self.suggestLabel.enabled=NO;
    }
    return _suggestLabel;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.phoneView) {
        if (string.length == 0) return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 11) {
            return NO;
        }
    }
    return YES;
}


@end
