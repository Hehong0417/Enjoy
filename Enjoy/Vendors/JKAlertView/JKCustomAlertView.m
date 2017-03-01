//
//  CustomAlertView.m
//  PlusStar_1.0
//
//  Created by 劉 on 15-4-1.
//  Copyright (c) 2015年 HuangZhenXiang. All rights reserved.
//

#import "JKCustomAlertView.h"

/*Default Colors*/
#define RJTitleLabelBackgroundColor [UIColor colorWithRed:0.20392156862745098 green:0.596078431372549 blue:0.8588235294117647 alpha:1.0]
#define RJComfirmButtonColor [UIColor colorWithRed:0.20392156862745098 green:0.596078431372549 blue:0.8588235294117647 alpha:1.0]

#define screenBounds [[UIScreen mainScreen] bounds]
#define IS_IOS7_Or_Later [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0

@interface JKCustomAlertView ()

@property(strong,nonatomic)UIImageView*backgroundView;
@property(unsafe_unretained,nonatomic)NSInteger selectedButtonIndex;
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UIView *alertPopupView;
@property (nonatomic,strong) UIView *view;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *sureButton;

@end

@implementation JKCustomAlertView

-(instancetype)initWithJKAlertType:(JKAlertType)alertType contentView:(UIView *)contentView {
    
    self=[super init];

    if (self) {
        
        self.opaque = NO;
        self.backgroundColor =  RGBA(20, 32, 40, 0.3);
        self.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _contentView=contentView;
        _alertType=alertType;

        self.backgroundView.userInteractionEnabled=YES;
        self.backgroundView.alpha = 0.0;
        
        WEAK_SELF();
        [self setTapActionWithBlock:^{
            
            [weakSelf endEditing:YES];
        }];
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 280, 140)];
        view.opaque = NO;
        view.backgroundColor = kBlackColor;
        view.alpha = 1;
        view.layer.cornerRadius = 5.0;
        [self addSubview:view];
        self.view.alpha = 0.7;
        self.view = view;
        //
        UILabel *titileLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(33, 20, (self.view.lh_width-2*33), 40)];
        titileLabel1.textAlignment = NSTextAlignmentCenter;
        titileLabel1.textColor = kWhiteColor;
        
        //
        UILabel *titileLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(33, 20, (self.view.lh_width-2*33), 60)];
        titileLabel2.textColor = kWhiteColor;
        titileLabel2.textAlignment = NSTextAlignmentCenter;
        
        //
        if (alertType == JKAlertTypeOneTextField) {
            //
            self.textField1 = [[UITextField alloc]initWithFrame:CGRectMake(40, 25,self.view.lh_width-2*40, 40)];
            [self.view addSubview:self.textField1];
            
            //添加分割线
            UIView *lineView = [UIView lh_viewWithFrame:CGRectMake(0, self.textField1.lh_height-1, self.textField1.lh_width, 1) backColor:LineLightColor];
            [self.textField1 addSubview:lineView];
            
        }else if(alertType == JKAlertTypeOneTitleLabel) {
            
            titileLabel1.text = self.title1;
            self.titleLabel1 = titileLabel1;
            [self.view addSubview:self.titleLabel1];
            
        }else if(alertType ==JKAlertTypeTwoTitleLabel)
        {
            
            titileLabel1.text = self.title1;
            self.titleLabel1 = titileLabel1;
            [self.view addSubview:self.titleLabel1];
        
            titileLabel2.text = self.title2;
            self.titleLabel2 = titileLabel2;
            [self.view addSubview:self.titleLabel2];
        }
        
        titileLabel1.numberOfLines = 2;
        titileLabel1.font = FontSmallSize;
        titileLabel2.numberOfLines = 0;
        titileLabel2.font = FontSmallSize;
        
        CGFloat button_width = 140;
        CGFloat button_height = 40;
       // CGFloat button_margin = (self.view.lh_width - 2*100)/3.0;
        
        UIButton *cancelButton = [self actionButtonWithFrame:CGRectMake((self.view.lh_width-button_width)/2, titileLabel2.lh_bottom+10, button_width, button_height) title:@"好了，我知道了" titleColor:APP_COMMON_COLOR backgroundColor:kWhiteColor  font:FontNormalSize];
        [cancelButton lh_setCornerRadius:kSmallCornerRadius borderWidth:1 borderColor:kBlackColor];
        cancelButton.tag = 0;
        [self.view addSubview:cancelButton];
        self.cancelButton = cancelButton;
        
//        UIButton *sureButton = [self actionButtonWithFrame:CGRectMake(button_margin*2+button_width, titileLabel.lh_bottom+30, button_width, cancelButton.lh_height) title:@"确定" titleColor:kWhiteColor backgroundColor:APP_COMMON_COLOR font:FontNormalSize];
//        sureButton.tag = 1;
//        [self.view addSubview:sureButton];
//        self.sureButton = sureButton;

    }
    return self;
}

- (void)setTitle1:(NSString *)title1 {
    
    _title1 = title1;
    
    self.titleLabel1 = [UILabel lh_labelAdaptionWithFrame:CGRectMake(self.cancelButton.lh_left, 15,self.view.lh_width-2*self.cancelButton.lh_left, 35)text:title1 textColor:kWhiteColor font:FONT(13) textAlignment:NSTextAlignmentCenter];
    [self.view addSubview:self.titleLabel1];
}
- (void)setTitle2:(NSString *)title2 {
    _title2 = title2;
    
    self.titleLabel2 = [UILabel lh_labelAdaptionWithFrame:CGRectMake(33, 45, (self.view.lh_width-2*33),60)text:title2 textColor:kWhiteColor font:FONT(13) textAlignment:NSTextAlignmentCenter];
    [self.view addSubview:self.titleLabel2];
    
}
- (void)setPlaceHolder1:(NSString *)placeHolder1 {
    
    _placeHolder1 = placeHolder1;
    
    self.textField1.placeholder = placeHolder1;
}

- (UIButton *)actionButtonWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)backgroundColor font:(UIFont *)font {
    
    UIButton *actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [actionButton setFrame:frame];
    [actionButton setTitle:title forState:UIControlStateNormal];
    [actionButton setTitleColor:titleColor forState:UIControlStateNormal];
    [actionButton setBackgroundColor:backgroundColor];
    [actionButton.layer setCornerRadius:3.0];
    [actionButton.titleLabel setFont:font];
    [actionButton addTarget:self action:@selector(tapButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return actionButton;
}

- (void)tapButtonAction:(UIButton *)button{
    
    [self dismiss];
    
    if ([self.delegate respondsToSelector:@selector(customAlertView:clickButton:)]) {
        
        [self.delegate customAlertView:self clickButton:button.tag];
    }
    
    if (self.tapAlertViewButtonAction) {
        
        self.tapAlertViewButtonAction(self,button.tag);
    }
}

-(void)show{
    
    [self triggerBounceAnimations];
    
    //添加到window上面
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
}
#pragma mark - Animations
- (void) triggerBounceAnimations
{
    
    self.view.alpha = 0;
    self.view.center = CGPointMake(CGRectGetWidth(screenBounds)/2, (CGRectGetHeight(screenBounds)/2));
    
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.3f;
    //animation.delegate = self;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.view.layer addAnimation:animation forKey:nil];
    
    [UIView animateWithDuration:0.1f
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [self.backgroundView setAlpha:0.6];
                         [self.view setAlpha:0.6];
                     }
                     completion:^(BOOL finished){
                     }];
}

- (void)dismiss
{
    
    [UIView animateWithDuration:0.4
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.alpha = 0;
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                     }];
}

@end
