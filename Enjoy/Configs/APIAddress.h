//
//  APIAddress.h
//  ganguo
//
//  Created by ganguo on 13-7-8.
//  Copyright (c) 2013年 ganguo. All rights reserved.
//

/**
 *   一、接口基础模块
 */
////// 本地
//#define API_HOST @"http://192.168.0.222:8090"
////// 本地图片
//#define API_IMAGE_HOST @"http://192.168.0.10:7080/"
//阿里云
#define API_HOST @"http://42.159.229.56:80"

//阿里云图片
#define API_IMAGE_HOST @"http://42.159.229.56:7080/"


// 请求头
#define API_APP_BASE_URL @"enjoythin-mb"
//#define API_APP_BASE_URL @""

#define API_BASE_URL [NSString stringWithFormat:@"%@/%@", API_HOST, API_APP_BASE_URL]

//不要请求头
//#define API_BASE_URL [NSString stringWithFormat:@"%@", API_HOST]

#define API_QR_BASE_URL [NSString stringWithFormat:@"%@/image", API_BASE_URL]
// 接口
#define API_SUB_URL(_url) [NSString stringWithFormat:@"%@/%@", API_BASE_URL, _url]


// 图片
#define kAPIImageFromUrl(url) ([url rangeOfString:@"http"].location != NSNotFound) ? [(url) stringByReplacingOccurrencesOfString:@"\\" withString:@"/"] : [[NSString stringWithFormat:@"%@%@", API_IMAGE_HOST, url]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]

/**
 *  StoryboardName
 */
#define SB_Login @"Login"

//-------项目接口模块--------//

/**
 *  登录注册
 */
//1.1手机（账号）唯一性验证
#define API_CHECK_PHONE API_SUB_URL(@"user/checkPhone.json")//*
//1.2获取短信验证码
#define API_GET_SHORT_MSG_CODE API_SUB_URL(@"user/getShortMsgCode.json")//*
//1.3注册
#define API_REGIST API_SUB_URL(@"user/regist.json")//*
//1.4登陆
#define API_LOGIN API_SUB_URL(@"user/login.json")//*
//1.5找回密码
#define API_FING_PASSWORD API_SUB_URL(@"user/findPassword.json") //*
//1.6身高列表
#define API_HEIGHT_LIST API_SUB_URL(@"user/heightList.json")//*
//1.7职业列表
#define API_JOB_LIST API_SUB_URL(@"user/jobList.json")//*
//1.8录入个人资料
#define API_COMPLETE_USERINFO API_SUB_URL(@"user/completeUserInfo.json") //*
//1.9健康问卷列表
#define API_HEALTH_LIST API_SUB_URL(@"user/healthList.json")
//1.10问题列表
#define API_QUESTION_LIST API_SUB_URL(@"user/questionList.json")
//1.11问卷结束
#define API_QUESTION_OVER API_SUB_URL(@"user/healthOver.json")

//1.12瘦身方案选择页面
#define API_CHOOSE_THIN_PROJECT API_SUB_URL(@"user/chooseThinProject.json")//*

//1.14录入身体数据报告(体重秤)
#define API_ADD_BODY_REPORT API_SUB_URL(@"ucenter/addBodyReport.json")

//1.16校验短信验证码
#define API_CHECK_SHORT_CODE API_SUB_URL(@"user/checkShortMsgCode.json")

//1.17 绑定第三方账号
#define API_BIND_THIRD_ACCOUNT API_SUB_URL(@"/user/bindThirdAccount.json")



//-------瘦身计划模块--------//
//2.1瘦身计划首页
#define API_THINPLAN_HOME API_SUB_URL(@"thinplan/home.json") //*
//2.2录入当日体重
#define API_THINPLAN_ADD_WEIGHT API_SUB_URL(@"thinplan/addWeight.json")//*

//2.3 录入减肥日记
#define API_ADD_NOTE_URL API_SUB_URL(@"ucenter/addNote.json")//*
//2.3套餐食物列表
#define API_SUIT_FOODLIST API_SUB_URL(@"thinplan/suitFoodList.json")//*
//2.3录入套餐食物消耗记录
#define API_ADD_SUIT_RECORD API_SUB_URL(@"thinplan/addSuitRecord.json")//*
//2.4录入食物消耗记录
#define API_ADD_FOOD_RECORD API_SUB_URL(@"thinplan/addFoodRecord.json") //*
//2.5删除食物消耗记录(批量)
#define API_DELETE_FOOD_RECORD API_SUB_URL(@"thinplan/deleteFoodRecord.json") //*
//2.6食物种类列表
#define API_FOOD_CATEGORY_LIST API_SUB_URL(@"thinplan/foodCategoryList.json")//*
//2.7食物列表
#define API_FOOD_LIST API_SUB_URL(@"thinplan/foodList.json")//*
//2.8食物详情
#define API_FOOD_DETAIL API_SUB_URL(@"thinplan/foodDetail.json")
//2.9开始运动
#define API_BEGIN_SPORT API_SUB_URL(@"thinplan/beginSport.json")//*
//2.10运动种类列表(需要吗)
#define API_SPORT_CATEGORY_LIST API_SUB_URL(@"thinplan/sportCategoryList.json")//*
//2.11运动列表(需要吗)
#define API_FOOD_DETAIL API_SUB_URL(@"thinplan/foodDetail.json")//*
//2.12开始运动
#define API_BEGIN_SPORT API_SUB_URL(@"thinplan/beginSport.json")//*
//2.13运动种类列表(需要吗)
#define API_SPORT_LIST API_SUB_URL(@"thinplan/sportList.json")//*
//2.14录入运动记录
#define API_ADD_SPORT_RECORD API_SUB_URL(@"thinplan/addSportRecord.json") //*
//2.15删除运动记录(批量)
#define API_DELETE_RECORD API_SUB_URL(@"thinplan/deleteSportRecord.json")


//-------增值服务模块--------//

//3.1增值服务首页
#define API_ADDSERVICE_HOME API_SUB_URL(@"addservice/home.json") //*
//3.2体重管理师列表
#define API_WEIGHT_TEACHER_OFUSER API_SUB_URL(@"addservice/weightTeacherOfUser.json")
//3.3资讯列表
#define API_INFORMATION_LIST API_SUB_URL(@"addservice/informationList.json")


//2.3选择瘦身方案system/systemRecommend.json
#define API_CONFIRM_PROJECT API_SUB_URL(@"user/confirmpProject.json")

// 2.4获取新的资讯数
#define API_GET_INFOMATION_NEW_COUNT API_SUB_URL(@"addservice/getInfomationNewCount.json") //*


//2.4选择瘦身方案内容
#define API_SYSTEMRECOMMEND API_SUB_URL(@"system/systemRecommend.json")



/**
 *  个人中心
 */
// 新的系统消息数量
#define API_GET_MESSAGE_NEW_COUNT API_SUB_URL(@"link/getMessageNewCount.json") //*
// 个人信息
#define API_USER_DETAIL API_SUB_URL(@"ucenter/userDetail.json") //*
// 我的消息
#define API_SYS_MESSAGE_LIST API_SUB_URL(@"link/sysMessageList.json") //*
// 我的消息详情
#define API_SYS_MESSAGE_DETAIL API_SUB_URL(@"link/sysMessageDetail.json") //*
// 身体数据报告列表
#define API_BODY_REPORT_LIST API_SUB_URL(@"ucenter/bodyReportList.json") //*
// 身体数据报告详情//*
#define API_BODY_REPORT_DETAIL API_SUB_URL(@"ucenter/bodyReportDetail.json") //*
//减肥记录列表
#define API_SLIM_RECORD_LIST API_SUB_URL(@"ucenter/slimRecordList.json")//*
// 录入家庭用户
#define API_ADD_FAMILY_USER API_SUB_URL(@"ucenter/insertOrUpdateFamilyUserInfo.json") //*
// 删除家庭用户(批量)
#define API_DELETE_FAMILY_USER API_SUB_URL(@"ucenter/deleteFamilyUser.json") //*
// 家庭用户列表
#define API_FAMILY_USER_LIST API_SUB_URL(@"ucenter/familyUserList.json") //*
// 家庭用户详情
#define API_FAMILY_USER_DETAIL API_SUB_URL(@"ucenter/familyUserDetail.json") //*
// 我的订单列表
#define API_ORDER_LIST API_SUB_URL(@"ucenter/orderList.json") //*
// 订单详情
#define API_ORDER_DETAIL API_SUB_URL(@"ucenter/orderDetail.json") //*
//减肥记录列表
#define API_SLIM_RECORD_LIST API_SUB_URL(@"ucenter/slimRecordList.json")//*
//
#define API_SLIM_RECORD_BYDATE API_SUB_URL(@"thinplan/slimRecoreByDate.json")//*
//5.5健康报告列表
#define API_HEALTH_REPORT_LIST API_SUB_URL(@"ucenter/healthReportList.json")//*
// 意见反馈
#define API_ADD_Feed_Back API_SUB_URL(@"ucenter/addFeedBack.json") //*
// 关于我们
#define API_SYSTEM_ATTRIBUT API_SUB_URL(@"system/systemAttribute.json") //*

//4.互动
//4.2录入评论
#define API_ADD_COMMENT API_SUB_URL(@"link/addComment.json") //*
//4.3录入分享记录
#define API_ADD_SHARE API_SUB_URL(@"link/addShare.json") //*

//5.4录入围度（新加）
#define API_ADD_WAISTHIP API_SUB_URL(@"ucenter/addWaistHip.json") //*
//5.4.1围度列表（新加）
#define API_WAIST_HIP_LIST API_SUB_URL(@"ucenter/waistHipList.json")
//5.4.2删除围度(批量)(新加)
#define API_DELETE_WAIST_HIP API_SUB_URL(@"ucenter/deleteWaistHip.json")
