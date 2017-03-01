//
//  HJSurver.m
//  Enjoy
//
//  Created by IMAC on 16/4/28.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJSurver.h"
#import "HJSurverAPI.h"
#import "HJSurverTableV.h"
#import "HJRecordAPI.h"
#import "HJH5CommonVC.h"
#import "HJExitLoginView.h"

@interface HJSurver ()<UIAlertViewDelegate>
{
    NSInteger surverPage;//当前填写问卷页面数
    NSMutableArray *submitAnswerArr;//提交答案数组集合
}
@property (nonatomic, strong) HJSurverModel *ListModel;
@property (nonatomic, strong) HJSurverInfoModel *infoModel;
@end

@implementation HJSurver

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"健康问卷";
    [self getSurverTypeList];
    self.automaticallyAdjustsScrollViewInsets = NO;
    submitAnswerArr = [NSMutableArray array];
    
    UIButton *leftButton = (UIButton *)self.navigationItem.leftBarButtonItem.customView;
    [leftButton bk_removeEventHandlersForControlEvents:UIControlEventTouchUpInside];
    [leftButton addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
}

-(void)pop{
    HJExitLoginView *view =  [HJExitLoginView exitLoginViewWithWarnTitle:@"您正在进行健康问卷调查，退出该健康问卷将无效，确定退出吗？"];
    [self.view addSubview:view];
    WEAK_SELF()
    view.certanBlock = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
}

-(void)creatTopViewUI{
        
    _tableScroView.contentSize = CGSizeMake(self.ListModel.healthList.count*kDeviceWidth,_tableScroView.frame.size.height);
    _tableScroView.pagingEnabled = YES;
    _tableScroView.scrollEnabled =NO;
    _tableScroView.bounces = NO;
    
    surverPage = 1;
    _scroView.contentSize = CGSizeMake(self.ListModel.healthList.count*100,60);
    for (int i=0; i<self.ListModel.healthList.count; i++) {
        _infoModel = self.ListModel.healthList[i];
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(i*100, 10, 100, 20)];
        btn.tag = i+1+1000;
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
        [btn setTitle:_infoModel.name forState:(UIControlStateNormal)];
        [btn addTarget:self action:@selector(closeQuestionType:) forControlEvents:(UIControlEventTouchUpInside)];
        [_scroView addSubview:btn];
        
        UILabel *round = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
        round.backgroundColor = [UIColor lightGrayColor];
        round.clipsToBounds = YES;
        round.layer.cornerRadius = 5;
        round.tag = 111+i;
        round.center = CGPointMake(btn.center.x, btn.frame.origin.y+btn.frame.size.height+10);
        [_scroView addSubview:round];
        
        
        if (i!=self.ListModel.healthList.count-1) {
            UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(round.center.x+5, round.center.y, 90, 1)];
            line.backgroundColor = [UIColor lightGrayColor];
            line.tag = 666+i;
            [_scroView addSubview:line];
        }
        
        if (i==0) {
            [btn setTitleColor:APP_COMMON_COLOR forState:(UIControlStateNormal)];
            round.backgroundColor = APP_COMMON_COLOR;
        }
        
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(i*kDeviceWidth, 0, kDeviceWidth, 50)];
        title.font = [UIFont systemFontOfSize:15];
        title.textColor = [UIColor blackColor];
        title.text = [NSString stringWithFormat:@"  %d、)%@",i+1,_infoModel.name];
        [_tableScroView addSubview:title];
        
        HJSurverTableV *mainTV = [HJSurverTableV new];
        mainTV.view.frame = CGRectMake(i*kDeviceWidth, 50, kDeviceWidth, _tableScroView.frame.size.height-50);
        mainTV.infoModel = _infoModel;
        mainTV.surverTag = 7000+i;
        mainTV.view.backgroundColor = [UIColor whiteColor];
        [_tableScroView addSubview:mainTV.view];
        [self addChildViewController:mainTV];
        [mainTV HJSurverTableVNowIndex:^(NSInteger nowIndex) {
            
            [self addSurverSubs:mainTV];
            
            NSInteger num = 0;
            for (int j=0; j<surverPage; j++) {
                HJSurverTableV *V = (HJSurverTableV *)[self.childViewControllers objectAtIndex:j];
                num = num + V.surveyController.surveyItems.count;
            }
            if (submitAnswerArr.count >= num) {
                
                [_tableScroView scrollRectToVisible:CGRectMake((i+1)*kDeviceWidth, 0, kDeviceWidth , _tableScroView.frame.size.height) animated:YES];
                if (surverPage<self.ListModel.healthList.count) {
                    surverPage++;
                }
                
                
                for (int i=0; i<surverPage; i++) {
                    UILabel *round = (UILabel *)[_scroView viewWithTag:111+i];
                    round.backgroundColor = APP_COMMON_COLOR;
                    UILabel *line = (UILabel *)[_scroView viewWithTag:666+i-1];
                    line.backgroundColor = APP_COMMON_COLOR;
                }
                
                UIButton *button = (UIButton *)[_scroView viewWithTag:surverPage+1000];
                [button setTitleColor:APP_COMMON_COLOR forState:(UIControlStateNormal)];
            }
        }];
        
        if (i == self.ListModel.healthList.count-1) {
            mainTV.view.frame = CGRectMake(i*kDeviceWidth, 50, kDeviceWidth, _tableScroView.frame.size.height-100);
            
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(i*kDeviceWidth+20,  _tableScroView.frame.size.height-50, kDeviceWidth-40, 44)];
            [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
            [btn setTitle:@"提交" forState:(UIControlStateNormal)];
            btn.backgroundColor = APP_COMMON_COLOR;
            btn.layer.cornerRadius = 6;
            [btn addTarget:self action:@selector(submitM:) forControlEvents:(UIControlEventTouchUpInside)];
            btn.tag = i+1+10000;
            [_tableScroView addSubview:btn];
        }
    }
}

-(void)closeQuestionType:(id)sender{
    
    UIButton *btn = sender;
    
    if ((btn.tag-1000-1)-1 != 7000  &&  (btn.tag-1000>surverPage)) {
        
        HJSurverTableV *V = (HJSurverTableV *)[self.childViewControllers objectAtIndex:(btn.tag-1000-1)-1];
        if(![V.surveyController isCompleted])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请填写完当前问卷问题" message:nil delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
            [alert show];
            return;
        }
        
//        //添加选中答案进提交数组
//        HJSurverTableV *V1 = (HJSurverTableV *)[self.childViewControllers objectAtIndex:surverPage-1];
//        [self addSurverSubs:V1];
        
    }
    
    surverPage = btn.tag-1000;
    
    [_tableScroView scrollRectToVisible:CGRectMake((btn.tag-1000 -1)*kDeviceWidth, 0, kDeviceWidth , _tableScroView.frame.size.height) animated:YES];
}

//选中答案添加进提交数组
-(void)addSurverSubs:(HJSurverTableV *)V1{
    // 输出答案
    for(int k = 0;k<V1.surveyController.surveyItems.count;k++)
    {
        GWQuestionnaireItem *item = V1.surveyController.surveyItems[k];
        HJquestionListModel *model = V1.ListModel.questionList[k];
        NSMutableDictionary *zdDic = [NSMutableDictionary dictionary];
        [zdDic setValue:model.Id forKey:@"questionId"];
        
        for(int p = 0;p<item.answers.count;p++)
        {
            NSDictionary *dict = item.answers[p];
            [zdDic setValue:[dict objectForKey:@"marked"] forKey:@"marked"];
            [zdDic setValue:[dict objectForKey:@"text"] forKey:@"text"];
            HJanswerListModel *model1 = model.answerList[p];
            [zdDic setValue:model1.Id forKey:@"answerId"];
            
            //获取选中参数
            if ([[zdDic objectForKey:@"marked"] integerValue]==1) {
                for (int i = 0; i<V1.ListModel.questionList.count; i++) {
                    HJquestionListModel *model = V1.ListModel.questionList[i];
                    
                    for (int j=0; j<model.answerList.count; j++) {
                        HJanswerListModel *model1 = model.answerList[j];
                        if ([model1.Id isEqualToString:[zdDic objectForKey:@"answerId"]]) {
                            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                            [dic setValue:model1.questionId forKey:@"questionId"];
                            [dic setValue:model1.Id forKey:@"answerId"];
                            
                            
                            //遍历提交数组 移除重复参数
                            for (int k=0; k<submitAnswerArr.count; k++) {
                                if ([submitAnswerArr[k] objectForKey:@"questionId"]==[dic objectForKey:@"questionId"]) {
                                    [submitAnswerArr removeObjectAtIndex:k];
                                }
                            }
                            [submitAnswerArr addObject:dic];
                        }
                    }
                    
                }
            }
            
            
            
            
        }
    }
}


#pragma mark--------------netWorkingRequest----------------------
//获取问卷调查问题类型
- (void)getSurverTypeList {
    [[[HJSurverAPI getSurverListpage:@1 rows:@100] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
        HJSurverAPI *api = responseObject;
        self.ListModel = api.data;
        [self creatTopViewUI];
    }];
}


#pragma mark------------提交问卷-----------------
-(void)submitM:(id)sender{
    UIButton *button = sender;
    HJSurverTableV *V = (HJSurverTableV *)[self.childViewControllers objectAtIndex:(button.tag-10000-1)];
    if (![V.surveyController isCompleted]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请填写完当前问卷问题" message:nil delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    [self addSurverSubs:V];
    
    [[[HJRecordAPI postQuestionListRecordAndquestionId:submitAnswerArr] netWorkClient]postRequestInView:_tableScroView successBlock:^(id responseObject) {
        
        HJRecordAPI *api = responseObject;
        if (api.code == 1) {
            //健康报告详情
            HJH5CommonVC *h5commonVC = [[HJH5CommonVC alloc]init];
            h5commonVC.h5_InterfaceType = HJHealthReportDetailsType;
            h5commonVC.BtnIsShow = YES;
            h5commonVC.healthReportId = api.data.healthReportId;
            [self.navigationController pushVC:h5commonVC];
        }
        
    }];
}

 


@end
