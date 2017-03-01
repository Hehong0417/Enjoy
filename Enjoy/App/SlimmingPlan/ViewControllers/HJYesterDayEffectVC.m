//
//  HJYesterDayEffectVC.m
//  Enjoy
//
//  Created by IMAC on 16/4/26.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJYesterDayEffectVC.h"
#import "HJSlimRecordListAPI.h"
#import "HJUser.h"
#import "UMSocialSnsService.h"
#import "UMSocial.h"

static int ScreenshotIndex=0;

@interface HJYesterDayEffectVC () <UMSocialUIDelegate>
@property (strong, nonatomic) IBOutlet UILabel *weightChangeLab;
@property (strong, nonatomic) IBOutlet UILabel *outCaloryLab;
@property (strong, nonatomic) IBOutlet UILabel *inCaloryLab;

@property (strong, nonatomic) IBOutlet UILabel *createTimeLab;
- (IBAction)shareResultClick:(id)sender;
@property (nonatomic, strong) HJSlimRecordListModel *SlimRecordListModel;

@property (strong, nonatomic) IBOutlet UIView *adViceBgView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *shareLayout;
@property (strong, nonatomic) IBOutlet UILabel *adciceLab;

@end

@implementation HJYesterDayEffectVC

-(void)doSomeThingInViewDidLoad{
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.title = @"昨天减肥成果";
    self.navigationController.navigationBar.barTintColor = IWColor(150, 215, 117);
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self getSlimRecord];
    
    //判断是否隐藏体重师建议
    [self setAdViceBgView];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBar.barTintColor = IWColor(119, 206, 73);
}
#pragma mark-判断是否隐藏体重师建议

- (void)setAdViceBgView {
    
    HJUser *user = [HJUser read];
    
  NSInteger isVip = [user.loginModel.isVip isEqualToString:@"1"]?1:0;
    if (isVip) {
        self.adViceBgView.hidden = NO;
        self.shareLayout.constant = 22;
    }else {
        self.adViceBgView.hidden = YES;
        self.shareLayout.constant = -100;
    }
}
- (void)getSlimRecord {

    NSDate *yesterday = [NSDate dateWithTimeIntervalSinceNow:-(24*60*60)];
      NSString  * yesterdayStr = [yesterday lh_string_yyyyMMdd];
        NSLog(@"yesterday is %@",yesterdayStr);//打印昨天的时间
    [[[HJSlimRecordListAPI getSlimRecordListWithdate:yesterdayStr] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
        
        HJSlimRecordListAPI *api = responseObject;
        if (api.code == 1) {
            if ([api.data isKindOfClass:[HJSlimRecordListModel class]]) {
                NSString *weightChange = api.data.weightChanges;
                NSString *inCalory = api.data.inCalory;
                
                NSString *outCalory = api.data.outCalory;
                NSString *createTime = api.data.createTime;
                NSString *comment = api.data.comment;
                
                self.weightChangeLab.text = [NSString stringWithFormat:@"%@Kg",weightChange];
                self.inCaloryLab.text = [NSString stringWithFormat:@"%@Kcal",inCalory];
                self.outCaloryLab.text = [NSString stringWithFormat:@"%@Kcal",outCalory];
                self.createTimeLab.text = createTime;
                
                self.adciceLab.text = comment;
                
            }else {
                
//                [SVProgressHUD showInfoWithStatus:@"暂无数据!"];
            }

        }
       //
    }];
}

- (IBAction)shareResultClick:(id)sender {
    
//    [self screenView:self.view];//截图
    
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"5734593e67e58e9f27003459" shareText:@"好享瘦分享~" shareImage:[self screenView:self.view] shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession, UMShareToWechatTimeline, UMShareToQQ, UMShareToQzone, nil] delegate:self];
    
    [UMSocialData defaultData].extConfig.wechatSessionData.url = @"http://hxsapp.lvshou.me/";
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = @"http://hxsapp.lvshou.me/";
    [UMSocialData defaultData].extConfig.qqData.url = @"http://hxsapp.lvshou.me/";
    [UMSocialData defaultData].extConfig.qzoneData.url = @"http://hxsapp.lvshou.me/";
}

//-(void)ScreenShot{
//         //这里因为我需要全屏接图所以直接改了，宏定义iPadWithd为1024，iPadHeight为768，
//     //    UIGraphicsBeginImageContextWithOptions(CGSizeMake(640, 960), YES, 0);     //设置截屏大小
//         UIGraphicsBeginImageContextWithOptions(CGSizeMake(LH_ScreenWidth, LH_ScreenHeight), YES, 0);     //设置截屏大小
//         [[self.view layer] renderInContext:UIGraphicsGetCurrentContext()];
//         UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
//         UIGraphicsEndImageContext();
//         CGImageRef imageRef = viewImage.CGImage;
//     //    CGRect rect = CGRectMake(166, 211, 426, 320);//这里可以设置想要截图的区域
//         CGRect rect = CGRectMake(0, 0, LH_ScreenWidth, LH_ScreenHeight);//这里可以设置想要截图的区域
//         CGImageRef imageRefRect =CGImageCreateWithImageInRect(imageRef, rect);
//         UIImage *sendImage = [[UIImage alloc] initWithCGImage:imageRefRect];
//         UIImageWriteToSavedPhotosAlbum(sendImage, nil, nil, nil);//保存图片到照片库
//         NSData *imageViewData = UIImagePNGRepresentation(sendImage);
//    
//         NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//         NSString *documentsDirectory = [paths objectAtIndex:0];
//         NSString *pictureName= [NSString stringWithFormat:@"screenShow_%d.png",ScreenshotIndex];
//         NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:pictureName];
//         NSLog(@"截屏路径打印: %@", savedImagePath);
//         //这里我将路径设置为一个全局String，这里做的不好，我自己是为了用而已，希望大家别这么写
//         [self SetPickPath:savedImagePath];
//    
//         [imageViewData writeToFile:savedImagePath atomically:YES];//保存照片到沙盒目录
//         CGImageRelease(imageRefRect);
//         ScreenshotIndex++;
//     }
// //设置路径
// - (void)SetPickPath:(NSString *)PickImage {
//     
//     }


- (UIImage*)screenView:(UIView *)view{
    CGRect rect = view.frame;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.navigationController.view.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
//    CGImageRef imageRef = img.CGImage;
    //    CGRect rect = CGRectMake(166, 211, 426, 320);//这里可以设置想要截图的区域
//    CGImageRef imageRefRect =CGImageCreateWithImageInRect(imageRef, rect);
//    UIImage *sendImage = [[UIImage alloc] initWithCGImage:imageRefRect];
//    UIImageWriteToSavedPhotosAlbum(sendImage, nil, nil, nil);//保存图片到照片库
//    NSData *imageViewData = UIImagePNGRepresentation(sendImage);
//    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *pictureName= [NSString stringWithFormat:@"screenShow_%d.png",ScreenshotIndex];
//    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:pictureName];
//    NSLog(@"截屏路径打印: %@", savedImagePath);
    return img;
}

@end
