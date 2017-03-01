//
//  RecordIntakVC.m
//  Enjoy
//
//  Created by IMAC on 16/3/19.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "RecordIntakVC.h"
#import "FoodLibraryVC.h"
#import "HJSuitFoodListAPI.h"
#import "HJFoodListAPI.h"
#import "HJAddSuitRecordAPI.h"
@interface RecordIntakVC ()
@property (nonatomic, weak) HJSuitFoodListModel *suitFoodListModel;
@property (strong, nonatomic) IBOutlet UIImageView *eatImg;
@property (strong, nonatomic) IBOutlet UIImageView *eatTypeImg;

@property (nonatomic, assign) NSInteger suitId;
@property (nonatomic, strong) NSNumber *eatType;
@end

@implementation RecordIntakVC
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self getSuitFoodList:@2];
    self.title = @"记录摄入";
    self.fatherV.layer.cornerRadius = 8;
    self.fatherV.layer.borderWidth  = 1;
    self.fatherV.layer.borderColor  = IWColor(190, 190, 190).CGColor;
    
    self.extraBtn.layer.cornerRadius = 8;
    
    self.haveEaten.layer.cornerRadius  = 5;
    self.eatenOther.layer.cornerRadius = 5;
    
    self.haveEaten.hidden = NO;
    self.eatenOther.hidden = NO;
    
    self.eatImg.hidden = YES;
    self.eatImg.contentMode = UIViewContentModeCenter;
    [self.fatherV addSubview:self.eatImg];
    
}

#pragma mark--------------netWorkingRequest----------------------
- (void)getSuitFoodList:(NSNumber *)eatType {
    self.eatType = eatType;
    [[[HJSuitFoodListAPI getSuitFoodListWithEatType:eatType] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
        HJSuitFoodListAPI *api = responseObject;
        self.suitFoodListModel = api.data;
        if ([api.data isKindOfClass:[HJSuitFoodListModel class]]) {
            self.suitId = self.suitFoodListModel.suitId;
            if ([eatType isEqualToNumber:@1]) {
                self.kg.text = self.suitFoodListModel.calory;
                [self breafestData];
            }else if([eatType isEqualToNumber:@2]){
                self.kg.text = self.suitFoodListModel.calory;
                [self lunchData];
            }else {
                self.kg.text = self.suitFoodListModel.calory;
                [self dinnerData];
            }
        }
    }];
}

- (void)breafestData {
    [self refreshHavedEatButtonAndExtanEatButtonWithEatState:@"1"];
    if (self.suitFoodListModel.foodList.count<=0) {
        self.image1.image = [UIImage imageNamed:@""];
        self.name1.text = @"";
    }else{
        HJSuitModel *suitModel1 = self.suitFoodListModel.foodList[0];
        [self.image1 sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(suitModel1.ico)]placeholderImage:kImageNamed(@"placeholderImage")];
        self.name1.text = suitModel1.name;
    }
    
    
    if (self.suitFoodListModel.foodList.count<=1) {
        self.image2.image = [UIImage imageNamed:@""];
        self.name2.text = @"";
    }else{
        HJSuitModel *suitModel2 = self.suitFoodListModel.foodList[1];
        [self.image2 sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(suitModel2.ico)]placeholderImage:kImageNamed(@"placeholderImage")];
        self.name2.text = suitModel2.name;
    }
    
    if (self.suitFoodListModel.foodList.count<=2) {
        self.image3.image = [UIImage imageNamed:@""];
        self.name3.text = @"";
    }else{
        HJSuitModel *suitModel3 = self.suitFoodListModel.foodList[2];
        [self.image3 sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(suitModel3.ico)]placeholderImage:kImageNamed(@"placeholderImage")];
        self.name3.text = suitModel3.name;
    }
    
    
    if (self.suitFoodListModel.foodList.count<=3) {
        self.image4.image = [UIImage imageNamed:@""];
        self.name4.text = @"";
    }else{
        HJSuitModel *suitModel4 = self.suitFoodListModel.foodList[3];
        [self.image4 sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(suitModel4.ico)]placeholderImage:kImageNamed(@"placeholderImage")];
        self.name4.text = suitModel4.name;
    }
}

- (void)lunchData {
    [self refreshHavedEatButtonAndExtanEatButtonWithEatState:@"2"];
    if (self.suitFoodListModel.foodList.count<=0) {
        self.image1.image = [UIImage imageNamed:@""];
        self.name1.text = @"";
    }else{
        HJSuitModel *suitModel1 = self.suitFoodListModel.foodList[0];
        [self.image1 sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(suitModel1.ico)]placeholderImage:kImageNamed(@"placeholderImage")];
        self.name1.text = suitModel1.name;
    }
    
    if (self.suitFoodListModel.foodList.count<=1) {
        self.image2.image = [UIImage imageNamed:@""];
        self.name2.text = @"";
    }else{
        HJSuitModel *suitModel2 = self.suitFoodListModel.foodList[1];
        [self.image2 sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(suitModel2.ico)]placeholderImage:kImageNamed(@"placeholderImage")];
        self.name2.text = suitModel2.name;
    }
    
    
    
    if (self.suitFoodListModel.foodList.count<=2) {
        self.image3.image = [UIImage imageNamed:@""];
        self.name3.text = @"";
    }else{
        HJSuitModel *suitModel3 = self.suitFoodListModel.foodList[2];
        [self.image3 sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(suitModel3.ico)]placeholderImage:kImageNamed(@"placeholderImage")];
        self.name3.text = suitModel3.name;
    }
    
    
    if (self.suitFoodListModel.foodList.count<=3) {
        self.image4.image = [UIImage imageNamed:@""];
        self.name4.text = @"";
    }else{
        HJSuitModel *suitModel4 = self.suitFoodListModel.foodList[3];
        [self.image4 sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(suitModel4.ico)]placeholderImage:kImageNamed(@"placeholderImage")];
        self.name4.text = suitModel4.name;
    }
//    NSLog(@"%@,%@,%@,%@",suitModel1.name,suitModel2.name,suitModel3.name,suitModel4.name);
}

- (void)dinnerData {
    [self refreshHavedEatButtonAndExtanEatButtonWithEatState:@"3"];
    if (self.suitFoodListModel.foodList.count<=0) {
        self.image1.image = [UIImage imageNamed:@""];
        self.name1.text = @"";
    }else{
        HJSuitModel *suitModel1 = self.suitFoodListModel.foodList[0];
        [self.image1 sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(suitModel1.ico)]placeholderImage:kImageNamed(@"placeholderImage")];
        self.name1.text = suitModel1.name;
    }
    
    if (self.suitFoodListModel.foodList.count<=1) {
        self.image2.image = [UIImage imageNamed:@""];
        self.name2.text = @"";
    }else{
        HJSuitModel *suitModel2 = self.suitFoodListModel.foodList[1];
        [self.image2 sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(suitModel2.ico)]placeholderImage:kImageNamed(@"placeholderImage")];
        self.name2.text = suitModel2.name;
    }
    
    if (self.suitFoodListModel.foodList.count<=2) {
        self.image3.image = [UIImage imageNamed:@""];
        self.name3.text = @"";
    }else{
        HJSuitModel *suitModel3 = self.suitFoodListModel.foodList[2];
        [self.image3 sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(suitModel3.ico)]placeholderImage:kImageNamed(@"placeholderImage")];
        self.name3.text = suitModel3.name;
    }
    
    if (self.suitFoodListModel.foodList.count<=3) {
        self.image4.image = [UIImage imageNamed:@""];
        self.name4.text = @"";
    }else{
        HJSuitModel *suitModel4 = self.suitFoodListModel.foodList[3];
        [self.image4 sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(suitModel4.ico)]placeholderImage:kImageNamed(@"placeholderImage")];
        self.name4.text = suitModel4.name;
    }
//    NSLog(@"%@,%@,%@,%@",suitModel1.name,suitModel2.name,suitModel3.name,suitModel4.name);
}

- (void)refreshHavedEatButtonAndExtanEatButtonWithEatState:(NSString *)eatState
{
    self.haveEaten.hidden = [self.suitFoodListModel.eatState rangeOfString:eatState].location != NSNotFound ? YES : NO;
    self.eatenOther.hidden = [self.suitFoodListModel.eatState rangeOfString:eatState].location != NSNotFound ? YES : NO;
    self.eatImg.hidden = [self.suitFoodListModel.eatState rangeOfString:eatState].location != NSNotFound ? NO : YES;
}

- (IBAction)breakfastMenth:(id)sender {
    NSLog(@"早餐");
    [self getSuitFoodList:@1];
    self.titleStr.text = @"早餐";
    [self sliderChange:sender];
    self.eatTypeImg.image = kImageNamed(@"ic_a33_18");
    [self.breakfast setTitleColor:IWColor(104, 212, 49) forState:(UIControlStateNormal)];
    [self.lunch setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [self.dinner setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    }


- (IBAction)lunchMenth:(id)sender {
    NSLog(@"午餐");
    [self getSuitFoodList:@2];
    self.titleStr.text = @"午餐";
    [self sliderChange:sender];
    self.eatTypeImg.image = kImageNamed(@"ic_a33_19");
    [self.breakfast setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [self.lunch setTitleColor:IWColor(104, 212, 49) forState:(UIControlStateNormal)];
    [self.dinner setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
}

- (IBAction)dinnerMenth:(id)sender {
    NSLog(@"晚餐");
    [self getSuitFoodList:@3];
    self.titleStr.text = @"晚餐";
    [self sliderChange:sender];
    self.eatTypeImg.image = kImageNamed(@"ic_a33_20");
    [self.breakfast setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [self.lunch setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [self.dinner setTitleColor:IWColor(104, 212, 49) forState:(UIControlStateNormal)];
    
}

//滑动条改变位置
-(void)sliderChange:(UIButton *)sender{
    self.line.center = CGPointMake(sender.center.x, sender.frame.origin.y+sender.frame.size.height+7);
}

- (IBAction)haveAllEaten:(id)sender {
    NSLog(@"我都吃了");
    self.haveEaten.hidden = YES;
    self.eatenOther.hidden = YES;
    self.eatImg.hidden = NO;
    [[[HJAddSuitRecordAPI addSuitRecordWithSuitId:[NSNumber numberWithInteger:self.suitId] eatType:self.eatType] netWorkClient] postRequestInView:self.view successBlock:^(id responseObject) {
        NSLog(@"记录套餐消耗成功");
    }];
}

- (IBAction)eatenOther:(id)sender {
    NSLog(@"吃了别的");
    FoodLibraryVC *VC = [[FoodLibraryVC alloc] init];
    VC.eatType = self.eatType;
    [self.navigationController pushVC:VC];
}

- (IBAction)extraM:(id)sender {
    NSLog(@"额外饮食");
    FoodLibraryVC *VC = [[FoodLibraryVC alloc] init];
    VC.eatType = @4;
    [self.navigationController pushVC:VC];
}

@end
