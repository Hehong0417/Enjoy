//
//  HJPersonCenterHeaderView.m
//  Enjoy
//
//  Created by zhipeng-mac on 16/2/25.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import "HJPersonCenterHeaderView.h"
#import "FXBlurView.h"
#import "HJUserInfoSTVC.h"
#import "HJUserDetailAPI.h"
#import "GPUImage.h"
#define kHeaderButtonSize 80

@interface HJPersonCenterHeaderView ()
@property (nonatomic, weak) UIImageView *headImageBgView;
@property (nonatomic, weak) UIImageView *icoImg;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UIImageView *sexImage;
@property (nonatomic, weak) UIView *nameView;
@end

@implementation HJPersonCenterHeaderView

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        HJUserDetailModel *info = [HJUserDetailModel read];
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, WidthScaleSize(165)+100);
        self.backgroundColor = kClearColor;
        UIImageView *headImageBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, WidthScaleSize(165))];
        headImageBgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, WidthScaleSize(165));
        [self addSubview:headImageBgView];
        headImageBgView.backgroundColor = APP_COMMON_COLOR;
        self.headImageBgView = headImageBgView;
        
        
        UIImageView *headBottomView = [UIImageView lh_imageViewWithFrame:CGRectMake(0, WidthScaleSize(165)-50, SCREEN_WIDTH, 50) image: kImageNamed(@"ic_c1_01")];
        [headImageBgView addSubview:headBottomView];
        
        // 添加名字和性别
        UIView *nameView = [[UIView alloc] init];
        CGSize nameSize = [info.name lh_sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(SCREEN_WIDTH, 30)];
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, nameSize.width, nameSize.height)];
        nameLabel.text = info.name;
        nameLabel.font = [UIFont systemFontOfSize:14];
        UIImageView *sexImage = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(nameLabel.frame) + 5, 0, 30, 15)];
        sexImage.contentMode = UIViewContentModeCenter;
        nameView.frame = CGRectMake(0, headImageBgView.lh_height + 15, nameLabel.lh_width + sexImage.lh_width + 5 , 30);
        nameView.lh_centerX = headImageBgView.lh_centerX;
        [nameView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        [nameView addSubview:sexImage];
        self.sexImage = sexImage;
        [self addSubview:nameView];
        self.nameView = nameView;
        
        //头像
        UIImageView *icoImg = [[UIImageView alloc] init];
        icoImg.frame = CGRectMake(0, 0, 80, 80);
        [icoImg lh_setCornerRadius:40 borderWidth:2 borderColor:kWhiteColor];
        icoImg.center = CGPointMake(headBottomView.centerX, headBottomView.centerY-25);
        icoImg.backgroundColor = APP_COMMON_COLOR;
        [headImageBgView addSubview:icoImg];
        self.icoImg = icoImg;
        headBottomView.userInteractionEnabled = YES;
        headImageBgView.userInteractionEnabled = YES;
        icoImg.userInteractionEnabled = YES;
        [icoImg lh_setTapActionWithBlock:^{
            self.headerBlock();
        }];
        NSArray *buttonTitles = @ [@"减肥记录",@"身体数据报告",@"健康报告",@"围度"];
        NSArray *buttonImages = @ [@"ic_c1_03",@"ic_c1_04",@"ic_c1_05",@"ic_c1_06"];

        
        CGFloat buttonMargin = (SCREEN_WIDTH - 4*kHeaderButtonSize)/5;
        
        for (int i=0; i<4; i++) {
            XYQButton *headerButton = [XYQButton ButtonWithFrame:CGRectMake(buttonMargin+(buttonMargin+kHeaderButtonSize)*i, headImageBgView.lh_height+(100-kHeaderButtonSize)/2.0, kHeaderButtonSize, kHeaderButtonSize) imgaeName:[buttonImages objectAtIndex:i] titleName:[buttonTitles objectAtIndex:i] contentType:TopImageBottomTitle buttonFontAttributes:[FontAttributes fontAttributesWithFontColor:kFontBlackColor fontsize:12] tapAction:^(XYQButton *button) {
            }];
            headerButton.tag = 100+i;
            [headerButton addTarget:self action:@selector(buttonEvent:) forControlEvents:(UIControlEventTouchUpInside)];
            DLogRect(headerButton.frame);
            [self addSubview:headerButton];
        }
    }
    return self;
}

- (void)setUserDetailModel:(HJUserDetailModel *)userDetailModel
{
    [self setupDataWithModel:userDetailModel];
    
    [self setupFrameWithModel:userDetailModel];
}

- (void)setupDataWithModel:(HJUserDetailModel *)model
{
    NSString *imgName;
    if (model.sex) {
        //女
      imgName = @"ic_c20_4";
        
    }else{
        
        imgName = @"ic_c20_3";
    }
    
    [self.headImageBgView sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(model.photo)] placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            GPUImageGaussianBlurFilter * blurFilter = [[GPUImageGaussianBlurFilter alloc] init];
            blurFilter.blurRadiusInPixels = 10.0;
            UIImage *blurredImage = [blurFilter imageByFilteringImage:image];
            self.headImageBgView.image = blurredImage;
        }
    }];
    
    [self.icoImg sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(model.photo)] placeholderImage:[UIImage imageNamed:imgName]];
    
    self.nameLabel.text = model.name;
    if (model.sex) {
        self.sexImage.image = kImageNamed(@"ic_c1_02");
    } else {
        self.sexImage.image = kImageNamed(@"ic_a17_01");
    }

}

- (void)setupFrameWithModel:(HJUserDetailModel *)model
{
    CGSize nameSize = [model.name lh_sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(SCREEN_WIDTH, 30)];
    self.nameLabel.frame = CGRectMake(0, 0, nameSize.width, nameSize.height);
    self.sexImage.frame = CGRectMake(CGRectGetMaxX(self.nameLabel.frame) + 5, 0, 12, 17);
    self.nameView.frame = CGRectMake(0, self.headImageBgView.lh_height - 8, self.nameLabel.lh_width + self.sexImage.lh_width + 5 , 30);
    self.nameView.lh_centerX = self.headImageBgView.lh_centerX;
}


-(void)buttonEvent:(id)sender{
    UIButton *btn = sender;
    [self.delegate push:[btn tag]];
}

@end
