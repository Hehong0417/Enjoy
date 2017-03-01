//
//  HJSurverTableV.m
//  Enjoy
//
//  Created by IMAC on 16/4/30.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJSurverTableV.h"


@interface HJSurverTableV ()
{
    
}

@end

@implementation HJSurverTableV

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self getSurverList];
}

-(void)setInfoModel:(HJSurverInfoModel *)infoModel{
    _infoModel = infoModel;
    [self viewWillAppear:YES];
}

#pragma mark--------------netWorkingRequest----------------------
//获取问卷调查各类型列表
- (void)getSurverList {
    [[[HJSurverListAPI getList:_infoModel.Id AndPage:@1 rows:@20] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
        HJSurverListAPI *api = responseObject;
        _ListModel = api.data;
        [self addSurvey];
    }];
}

-(void)addSurvey
{
    NSMutableArray *questions = [NSMutableArray array];
    NSMutableArray *daAnArr;
    for (int i = 0; i<_ListModel.questionList.count; i++) {
        
        HJquestionListModel *questionListModel = _ListModel.questionList[i];
        daAnArr = [NSMutableArray array];
        for (int j=0; j<questionListModel.answerList.count; j++) {
            HJanswerListModel *model = questionListModel.answerList[j];
            NSDictionary *a = [NSDictionary dictionaryWithObjectsAndKeys:model.content,@"text",[NSNumber numberWithBool:NO],@"marked", nil];
            [daAnArr addObject:a];
        }
        
        
        GWQuestionnaireItem *item = [[GWQuestionnaireItem alloc] initWithQuestion:questionListModel.content
                                                                          answers:daAnArr                   type:GWQuestionnaireSingleChoice];
        [questions addObject:item];
    }
    
    
    _surveyController = [[GWQuestionnaire alloc] initWithItems:questions];
    _surveyController.tableView.bounces = NO;
    _surveyController.view.frame = CGRectMake(0,0,kDeviceWidth,self.view.frame.size.height);
    [_surveyController nowIndex:^(NSInteger nowIndex) {
        if (self.tableVBlock != nil) {
            self.tableVBlock(nowIndex);
        }
    }];
    [self.view addSubview:_surveyController.view];
    
    /*
    // add button
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:NSLocalizedString(@"Get answers!", nil) forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(getAnswersPressed:) forControlEvents:UIControlEventTouchUpInside];
    int btnW = 150;
    int btnX = (self.view.frame.size.width - btnW)/2;
    [btn setFrame:CGRectMake(btnX, self.view.frame.size.height - 40, btnW, 40)];
    [self.view addSubview:btn];
     */
}


-(void)getAnswersPressed:(id)sender
{
    if(![_surveyController isCompleted])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Questionnaire not completed." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    // NSLog answers
    for(GWQuestionnaireItem *item in _surveyController.surveyItems)
    {
        NSLog(@"-----------------");
        NSLog(@"%@",item.question);
        NSLog(@"-----------------");
        if(item.type == GWQuestionnaireOpenQuestion){
            NSLog(@"Answer: %@", item.userAnswer);
        }else{
            for(NSDictionary *dict in item.answers)
            {
                NSLog(@"%d - %@",[[dict objectForKey:@"marked"]boolValue], [dict objectForKey:@"text"]);
            }
        }
    }
}

#pragma mark----block方法-------
- (void)HJSurverTableVNowIndex:(HJSurverTableVBlock)block
{
    self.tableVBlock = block;
}
@end
