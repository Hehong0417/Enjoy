//
//  HJFamilyUserDetailVC.m
//  Enjoy
//
//  Created by 邓朝文 on 16/5/3.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJFamilyUserDetailVC.h"
#import "FXBlurView.h"
#import "HJH5CommonVC.h"
#import "HJUserInfoSTVC.h"
#import "HJFamilyUserListAPI.h"
#import "HJConnectFatScaleVC.h"
#import "BluetoothManager.h"
#import "HJBodyDataTVC.h"
#import "HJFamilyUserDetailAPI.h"
#import "GPUImage.h"
#import "MasterSHAinfo.h"

#define kHeaderButtonSize 80
@interface HJFamilyUserDetailVC ()
@property (nonatomic, weak) UIImageView *headImageBgView;
@property (nonatomic, weak) UIView *nameView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UIImageView *sexImage;
@property (nonatomic, weak) UIImageView *icoImg;
@end

@implementation HJFamilyUserDetailVC

- (void)viewDidLoad
{
    [self setupHeadView];
    WEAK_SELF();
    self.headerBlock = ^{
        HJUserInfoSTVC *TVC = [[HJUserInfoSTVC alloc] init];
        TVC.familyUserId = weakSelf.familyUserId;
        [weakSelf.navigationController pushVC:TVC];
    };
        [self getFamilyUserDetail];
    self.view.backgroundColor = RGB(240, 240, 240);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    HJFamilyUserDetailModel *model = [HJFamilyUserDetailModel read];
    [self setFamilyUserDetailModel:model];
}
//- (void)doSomeThingInViewWillAppear
//{
//    [self getFamilyUserDetail];
//}

- (void)setupHeadView
{
    UIView *headView = [[UIView alloc] init];
    headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, WidthScaleSize(175)+140);
    [self.view addSubview:headView];
    UIImageView *headImageBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, WidthScaleSize(165))];
    headImageBgView.backgroundColor = APP_COMMON_COLOR;
    [headView addSubview:headImageBgView];
    self.headImageBgView = headImageBgView;
    
//    [UIView fuzzyVIew:self.headImageBgView];
    
    UIImageView *headBottomView = [UIImageView lh_imageViewWithFrame:CGRectMake(0, WidthScaleSize(165)-50, SCREEN_WIDTH, 50) image: kImageNamed(@"ic_c1_01")];
    [headImageBgView addSubview:headBottomView];
    
    //头像
    UIImageView *icoImg = [UIImageView lh_imageViewWithFrame:CGRectMake(0, 0, 80, 80) image:kImageNamed(@"")];
    [icoImg lh_setCornerRadius:40 borderWidth:2 borderColor:kWhiteColor];
    icoImg.center = CGPointMake(headBottomView.centerX, headBottomView.centerY-25);
    icoImg.backgroundColor = APP_COMMON_COLOR;
    [headImageBgView addSubview:icoImg];
    self.icoImg = icoImg;
    headBottomView.userInteractionEnabled = YES;
    headImageBgView.userInteractionEnabled = YES;
    icoImg.userInteractionEnabled = YES;
    WEAK_SELF()
    [icoImg lh_setTapActionWithBlock:^{
        weakSelf.headerBlock();
    }];
    
    // 名字和性别图标
    UIView *nameView = [[UIView alloc] init];
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = [UIFont systemFontOfSize:14];
    UIImageView *sexImage = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(nameLabel.frame) + 5, 0, 12, 17)];
    nameView.frame = CGRectMake(0, headImageBgView.lh_height + 15, nameLabel.lh_width + sexImage.lh_width + 5 , 30);
    nameView.lh_centerX = headImageBgView.lh_centerX;
    [nameView addSubview:nameLabel];
    [nameView addSubview:sexImage];
    [headView addSubview:nameView];
    self.nameView = nameView;
    self.nameLabel = nameLabel;
    self.sexImage = sexImage;
    
    // 线条
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(headImageBgView.frame) + 30, SCREEN_WIDTH - 40, 0.5)];
    lineView.backgroundColor = RGBA(162, 157, 149, 0.3);
    [headView addSubview:lineView];
    
    NSArray *buttonTitles = @ [@"身体数据报告", @"围度"];
    NSArray *buttonImages = @ [@"ic_c1_04", @"ic_c1_06"];
    
    CGFloat buttonMargin = (SCREEN_WIDTH - 2*kHeaderButtonSize)/4;
    
    for (int i=0; i<2; i++) {
        
        XYQButton *headerButton = [XYQButton ButtonWithFrame:CGRectMake(buttonMargin * (i + 1)+(buttonMargin+kHeaderButtonSize)*i, CGRectGetMaxY(lineView.frame) + 20, kHeaderButtonSize, kHeaderButtonSize) imgaeName:[buttonImages objectAtIndex:i] titleName:[buttonTitles objectAtIndex:i] contentType:TopImageBottomTitle buttonFontAttributes:[FontAttributes fontAttributesWithFontColor:kFontBlackColor fontsize:12] tapAction:^(XYQButton *button) {
            
        }];
        headerButton.tag = 100+i;
        [headerButton addTarget:self action:@selector(buttonEvent:) forControlEvents:(UIControlEventTouchUpInside)];
        DLogRect(headerButton.frame);
        [headView addSubview:headerButton];
    }
    
    // 线条
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.5, CGRectGetMaxY(lineView.frame) + 25, 0.5, kHeaderButtonSize)];
    lineView2.backgroundColor = RGBA(162, 157, 149, 0.3);
    [headView addSubview:lineView2];
    
    // 连接体脂称按钮
    UIButton *connectBtn = [UIButton lh_buttonWithFrame:CGRectMake(30, CGRectGetMaxY(headView.frame) + 40, SCREEN_WIDTH-60, 40) target:self action:@selector(connect) title:@"连接体脂称" titleColor:kWhiteColor font:FONT(14) backgroundColor:APP_COMMON_COLOR ];
    [connectBtn lh_setCornerRadius:3 borderWidth:0 borderColor:nil];
    [self.view addSubview:connectBtn];
    
    // 返回上个控制器按钮
    UIButton *leftBtn = [UIButton lh_buttonWithFrame:CGRectMake(10, 30, 50, 50) target:self action:@selector(backAct) image:kImageNamed(@"ic_b12_fanhui")];
    [self.view addSubview:leftBtn];
}

- (void)getFamilyUserDetail
{
    [[[HJFamilyUserDetailAPI getFamilyUserDetailWithFamilyUserId:[NSNumber numberWithInteger:self.familyUserId]] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
        HJFamilyUserDetailAPI *api = responseObject;
        if (api.code == 1) {
            HJFamilyUserDetailModel *model = api.data;
            [model write];
           //
            MasterSHAinfo *MasModel = [MasterSHAinfo read];
            NSString *userSex = model.sex?@"女":@"男";
            
            //******计算年龄*****
            NSString *birth = model.birthday;
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            //生日
            NSDate *birthDay = [dateFormatter dateFromString:birth];
            //当前时间
            NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
            NSDate *currentDate = [dateFormatter dateFromString:currentDateStr];
            NSLog(@"currentDate %@ birthDay %@",currentDateStr,birth);
            NSTimeInterval time=[currentDate timeIntervalSinceDate:birthDay];
            int Age = ((int)time)/(3600*24*365);
            NSLog(@"year %d",Age);
 //----end---
            NSString *userAge = [NSString stringWithFormat:@"%d",Age];
            
            NSString *userHeight = model.height;
            MasModel.userSex = userSex;
            MasModel.userAge = userAge;
            MasModel.userHeight = userHeight;
            [MasModel write];
            if ( [self.dataDelegate respondsToSelector:@selector(responeData:)]) {
                [self.dataDelegate responeData:MasModel];
            }
            [self setFamilyUserDetailModel:model];
        }
    }];
}


- (void)setFamilyUserDetailModel:(HJFamilyUserDetailModel *)model
{
    [self setupDataWithModel:model];
    
    [self setupFrameWithModel:model];
}

- (void)setupDataWithModel:(HJFamilyUserDetailModel *)model
{
    
    [self.headImageBgView sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(model.photo)] placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            GPUImageGaussianBlurFilter * blurFilter = [[GPUImageGaussianBlurFilter alloc] init];
            blurFilter.blurRadiusInPixels = 3.0;
            UIImage *blurredImage = [blurFilter imageByFilteringImage:image];
            self.headImageBgView.image = blurredImage;
        }
    }];
    NSString *imgName;
    if (model.sex) {
        //女
        imgName = @"ic_c20_4";
        
    }else{
        imgName = @"ic_c20_3";
    }
    [self.icoImg sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(model.photo)] placeholderImage:[UIImage imageNamed:imgName]];
    self.nameLabel.text = model.name;
    if (model.sex) {
        self.sexImage.image = kImageNamed(@"ic_c1_02");
    } else {
        self.sexImage.image = kImageNamed(@"ic_a17_01");
    }
    
    
}

- (void)setupFrameWithModel:(HJFamilyUserDetailModel *)model
{
    CGSize nameSize = [model.name lh_sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(SCREEN_WIDTH, 30)];
    self.nameLabel.frame = CGRectMake(0, 0, nameSize.width, nameSize.height);
    self.sexImage.frame = CGRectMake(CGRectGetMaxX(self.nameLabel.frame) + 5, 0, 12, 17);
    self.nameView.frame = CGRectMake(0, self.headImageBgView.lh_height - 8, self.nameLabel.lh_width + self.sexImage.lh_width + 5 , 30);
    self.nameView.lh_centerX = self.headImageBgView.lh_centerX;
}

- (void)connect
{
    //连接体脂秤
    [[BluetoothManager shareManager] bleDoScan];
    //
    HJConnectFatScaleVC *fatScalVC = (HJConnectFatScaleVC *)[UIViewController lh_createFromStoryboardName:SB_LOGIN  WithIdentifier:@"HJConnectFatScaleVC"];
    fatScalVC.puserId = [NSString stringWithFormat:@"%ld",self.familyUserId];
    fatScalVC.userType = 2;
    fatScalVC.fatScaleType = 3;
    [self.navigationController pushVC:fatScalVC];
}

- (void)backAct
{
    [self.navigationController popVC];
}
    
- (void)buttonEvent:(UIButton *)button
{
    switch (button.tag) {
        case 100: {
            HJBodyDataTVC *bodyDataVC = [HJBodyDataTVC new];
            bodyDataVC.reportListType = HJbodyReportType;
            bodyDataVC.puserId = [NSNumber numberWithInteger:self.familyUserId];
            bodyDataVC.userType = @2;
            [self.navigationController pushVC:bodyDataVC];
        }
            break;
        case 101: {
            HJH5CommonVC *VC = [[HJH5CommonVC alloc] init];
            VC.h5_InterfaceType = HJArea_TiledType;
            VC.purseId = [NSNumber numberWithInteger:self.familyUserId];
            VC.userType = @2;
            [self.navigationController pushVC:VC];
        }
        default:
            break;
    }
}

@end
