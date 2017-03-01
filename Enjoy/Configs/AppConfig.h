
//导航栏标题字体大小
#define AppNavigationFont [UIFont systemFontOfSize:17]
#define FontBigSize [UIFont systemFontOfSize:16]
#define FontNormalSize [UIFont systemFontOfSize:14]
#define FontSmallSize [UIFont systemFontOfSize:12]

//公用颜色
#define APP_COMMON_COLOR RGB(124, 208, 80)
#define kVCBackGroundColor RGB(240, 240, 240)
#define kLineLightColor RGB(229, 229, 229)
#define kLineDeepColor RGB(204, 204, 204)
#define kFontLightGrayColor RGB(153, 153, 153)
#define kFontGrayColor RGB(102, 102, 102)
#define kFontBlackColor RGB(51, 51, 51)
#define KbtnBackColor RGB(217, 217, 217)

//圆角大小
#define kSmallCornerRadius 3.0f
//用户信息
#define USER_ID_KEY @"userId"
#define USER_TOKEN_KEY @"token"
#define USER_ID     ([uDefault objectForKey:@"userId"]?[uDefault objectForKey:@"userId"]:@"")
#define USER_TOKEN  ([uDefault objectForKey:@"token"]?[uDefault objectForKey:@"token"]:@"")
#define USER_CURRENT_ADDRESS @"user_current_address"
#define uDefault_CURRENT_ADDRESS [uDefault objectForKey:USER_CURRENT_ADDRESS]

//storyboard
#define SB_HOME_PAGE @"HomePage"
#define SB_SERVICE @"IncrementService"
#define SB_PERSON_CENTER @"PersonCenter"
#define SB_LOGIN @"Login"

//H5 url
//资讯列表
#define Manager_Note_url @"http://42.159.229.56:80/haoxiangshou/manage_note.html"
//资讯详情
#define Manager_Note_detail_url @"http://42.159.229.56:80/haoxiangshou/manage_note_details.html"
//减肥记录
#define Index_url @"http://42.159.229.56:80/haoxiangshou/index.html"
//身体数据报告
#define Report_url @"http://42.159.229.56:80/haoxiangshou/report.html"
//身体数据报告详情(需要改动)
#define Report_Details_url @"http://42.159.229.56:80/haoxiangshou/report_details.html"
//#define Report_Details_url @"http://192.168.0.199:8020/haoxiangshou/report_details.html"
//围度
#define Area_Tiled_url @"http://42.159.229.56:80/haoxiangshou/area-tiled.html"
//健康报告
#define HealthReport_url @"http://42.159.229.56:80/haoxiangshou/healthReport.html"
//健康报告详情
#define HealthReportDetails_url @"http://42.159.229.56:80/haoxiangshou/healthReportDetails.html"
//减肥日记
#define Diet_Diary_url @"http://42.159.229.56:80/haoxiangshou/diet_diary.html"
//订单详情
#define Order_Detaisl_url @"http://42.159.229.56:80/haoxiangshou/order_detaisl.html"
//在线留言
#define Online_Message_url @"http://42.159.229.56:80/haoxiangshou/online_message.html"
//调查问卷
#define HealthQTest_url @"http://42.159.229.56:80/enjoythin-mb/healthQTest.html"



//H5枚举
typedef NS_ENUM(NSUInteger, HJH5_InterfaceType) {
    HJManager_NoteType,//资讯列表
    HJManage_Note_DetailsType,//资讯列表详情
    HJDiet_IndexType,//减肥记录
    HJReportType,//身体数据报告
    HJReport_detailsType,//身体数据报告详情
    HJArea_TiledType,//围度
    HJHealthReportType,//健康报告
    HJHealthReportDetailsType,//健康报告详情
    HJDiet_DiaryType,//减肥日记
    HJOnline_MessageType,//在线留言
    HJHealthQTestType//调查问卷
};
//食物库&运动库枚举
typedef enum : NSUInteger {
    HJFoodType,
    HJSportType,
} HJClassType;


//注册&忘记密码枚举
typedef NS_ENUM(NSUInteger,HJReg_ForgetPwd_Type) {
    HJRegisterType,
    HJForgetType,
};

//第三方注册&普通账号注册
typedef NS_ENUM(NSUInteger,HJRegular_OtherLogin_Type) {
    HJRegular_Login_Type,
    HJQQ_login_Type,
    HJWX_login_Type
};


//增值服务类型
typedef NS_ENUM(NSUInteger,HJIncrementType) {
    HJManage_Note_Incre,
    HJPublic_Class_Incre,
    HJThinBible_Incre,
};

//键盘高度
#define kKeyBoardNormalHeight 216.0f

//输入文字限制
static const NSUInteger kReasonNoteMaxLength = 300;

//边框间距
static const CGFloat kGroupTablePadding = 15;
static const CGFloat kNormalButtonMargin = 30;
#define kNormalButtonWidth (SCREEN_WIDTH-kNormalButtonMargin*2)
#define kNormalButtonHeight 35

//NOTIFICATION
//登录失效通知
#define kNotifation_TokenInvalidate @"kNotifation_TokenInvalidate"

//测量完成通知
#define kNotifation_DidConnect @"kNotifation_DidConnect"





// 定位本地保存文件
#define kAmapLocationFile  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"kAmapLocationFile"]

//公用Block

typedef void(^voidBlock)();
typedef void(^idBlock)(id obj);
typedef void(^stringBlock)(NSString *result);
typedef void(^stringBlock2)(NSString *result,NSString *description);
typedef void(^boolBlock)(BOOL boolen);
typedef void(^errorBlock)(NSError *error);
typedef void(^numberBlock)(NSNumber *result);
typedef void(^arrayWithErrorBlock)(NSArray *results,NSError *error);
typedef void(^arrayAndDescription)(NSArray *results,NSString *description);
typedef void(^arrayBlock)(NSArray *results);
typedef void(^successBlock)(id resultObj);

#ifdef DEBUG

#pragma mark - HJViewControllerProtocol



#pragma mark - Action



#pragma mark - HJDataHandlerProtocol



#pragma mark - Setter&Getter



#endif

