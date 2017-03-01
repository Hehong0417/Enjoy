//
//  HJMessageDetailVC.m
//  Enjoy
//
//  Created by 邓朝文 on 16/5/3.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJMessageDetailVC.h"
#import "HJMyMessageDetailAPI.h"

@interface HJMessageDetailVC ()
@property (nonatomic, strong) HJMyMessageDetailModel *messageDetailModel;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, weak) UILabel *contentLabel;
@end

@implementation HJMessageDetailVC

- (void)doSomeThingInViewDidLoad {
    
    self.title = @"消息详情";
    self.view.backgroundColor = kWhiteColor;
    [self getMyMessageDetail];
    [self setupView];
}

#pragma mark - Actions
#pragma mark - Methods
- (void)getMyMessageDetail
{
    [[[HJMyMessageDetailAPI getMyMessageDetailWithMessageId:[NSNumber numberWithInteger:self.messageId]] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
        HJMyMessageDetailAPI *api = responseObject;
        if (api.code == 1) {
            self.messageDetailModel = api.data;
            [self setData];
        }
    }];
}

- (void)setupView
{
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(20, CGRectGetMaxY(self.navigationController.navigationBar.frame)+ 5, SCREEN_WIDTH - 40, 40);
    self.titleLabel = titleLabel;
    [self.view addSubview:titleLabel];
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, CGRectGetMaxY(self.titleLabel.frame), SCREEN_WIDTH - 40, 15);
    timeLabel.font = FONT(12);
    timeLabel.textColor = RGB(139, 139, 139);
    self.timeLabel = timeLabel;
    [self.view addSubview:timeLabel];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.frame = CGRectMake(5, CGRectGetMaxY(timeLabel.frame) + 10, SCREEN_WIDTH - 10, 0.5);
    lineView.backgroundColor = RGB(193, 193, 193);
    [self.view addSubview:lineView];
    
    CGSize contentSize = [self.messageDetailModel.content lh_sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(SCREEN_WIDTH - 40, MAXFLOAT)];
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.frame = CGRectMake(timeLabel.frame.origin.x, CGRectGetMaxY(timeLabel.frame) + 20, SCREEN_WIDTH - 40, contentSize.height);
    self.contentLabel = contentLabel;
    [self.view addSubview:contentLabel];
}

- (void)setData
{
    self.titleLabel.text = self.messageDetailModel.title;
    self.timeLabel.text = self.messageDetailModel.pushTime;
    CGSize contentSize = [self.messageDetailModel.content lh_sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(SCREEN_WIDTH - 40, MAXFLOAT)];
    self.contentLabel.frame = CGRectMake(self.timeLabel.frame.origin.x, CGRectGetMaxY(self.timeLabel.frame) + 20, SCREEN_WIDTH - 40, contentSize.height);
    self.contentLabel.text = self.messageDetailModel.content;
}


@end
