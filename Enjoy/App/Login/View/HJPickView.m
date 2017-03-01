//
//  HJPIckView.m
//  Enjoy
//
//  Created by Pro on 16/4/21.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJPIckView.h"
#import "HJHeightListAPI.h"
#import "HJJobListAPI.h"
#import "TSLocation.h"
@interface HJPickView ()<UITableViewDelegate,UIPickerViewDelegate>
{
    NSArray *provinces;
    NSArray	*cities;
}
@property (nonatomic, strong) NSMutableArray *selectDateArr;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (strong, nonatomic) TSLocation *locate;

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *line;
- (IBAction)sureBtn:(UIButton *)sender;
- (IBAction)cancleBtn:(UIButton *)sender;
@end
@implementation HJPickView
- (void)awakeFromNib {
    
    self.selectDateArr = [NSMutableArray array];
    NSDate *maxdate = [NSDate date];
    self.timePick.maximumDate = maxdate;
    
    NSDate *minidate = [NSDate lh_formerDateFromYear:-120];
    self.timePick.minimumDate = minidate;
}
- (void)pickViewWithStyle:(HJPickViewStyle)pickViewStyle {
    
    self.frame = [UIScreen mainScreen].bounds;
    switch (pickViewStyle) {
        case HJPickViewStyleNone:
        {
            self.tableView.hidden = YES;
            self.timePickView.hidden = YES;
            [self getDataRequest];
            self.pickView.delegate = self;
        }
            break;
        case HJPickViewStyleDate:
        {
            self.tableView.hidden = YES;
            self.pickView.hidden = YES;
            NSDate *currentDate = [NSDate date];
            [self getDateStr:currentDate];
            [self.timePick addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
        }
            break;
        case HJPickViewStyleTable:
        {
            self.timePickView.hidden = YES;
            self.pickView.hidden = YES;
        }
            break;
        default:
            break;
    }
}
- (void)getDataRequest{
    switch (self.personInfoStyle) {
        case HJHeightStyle:{
          [[[HJHeightListAPI getHeightListWithPage:@1 rows:@100] netWorkClient] postRequestInView:self successBlock:^(id responseObject) {
              HJHeightListAPI *api = responseObject;
              [self.dataSource removeAllObjects];
              self.dataSource = api.data.mutableCopy;
              [self pickerView:self.pickView didSelectRow:0 inComponent:0];
              [self.pickView reloadAllComponents];
          }];
        }
            break;
        case HJJobStyle:{
            [[[HJJobListAPI getJobListWithPage:@1 rows:@100] netWorkClient] postRequestInView:self successBlock:^(id responseObject) {
                HJJobListAPI *api = responseObject;
                [self.dataSource removeAllObjects];
                self.dataSource = api.data.mutableCopy;
                [self pickerView:self.pickView didSelectRow:0 inComponent:0];
                [self.pickView reloadAllComponents];
            }];
        }
            break;
        case HJRegionStyle:{
            //加载数据
            provinces = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ProvincesAndCities.plist" ofType:nil]];
            cities = [[provinces objectAtIndex:0] objectForKey:@"Cities"];
            //初始化默认数据
            self.locate = [[TSLocation alloc] init];
            self.locate.state = [[provinces objectAtIndex:0] objectForKey:@"State"];
            self.locate.city = [[cities objectAtIndex:0] objectForKey:@"city"];
            [self.pickView reloadAllComponents];
        }
            break;
        case HJSexStyle:{

            [self.dataSource removeAllObjects];
            NSArray *sexArray = @[@"男", @"女"];
            self.dataSource = [NSMutableArray arrayWithArray:sexArray];
            [self pickerView:self.pickView didSelectRow:0 inComponent:0];
            [self.pickView reloadAllComponents];
        }
        default:
            break;
    }
}
- (void)dismiss {
    [self removeFromSuperview];
}
- (IBAction)sureBtn:(UIButton *)sender {
    if (self.pickViewStyle == HJPickViewStyleDate){
        if (self.selectDateArr.count == 1) {
            NSString *dateStr = self.selectDateArr[0];
            self.dateBlock(dateStr);
        }
    }else {
        
        if (self.selectDateArr.count == 1) {
            NSString *dateStr = self.selectDateArr[0];
            self.dateBlock(dateStr);
        }
        if (self.personInfoStyle == HJRegionStyle) {
            TSLocation *location = self.locate;
            NSLog(@"city:%@ lat:%@", location.city, location.state);
            self.dateBlock(location);
        }

    }
    [self removeFromSuperview];
}
- (IBAction)cancleBtn:(UIButton *)sender {
    [self removeFromSuperview]; 
}
-(void)dateChanged:(UIDatePicker *)sender{
    NSDate *selectDate = [sender date];
    [self getDateStr:selectDate];
}
- (void)getDateStr:(NSDate *)selectDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormatter stringFromDate:selectDate];
    [self.selectDateArr removeAllObjects];
    [self.selectDateArr addObject:dateStr];
}
#pragma mark- pickViewDelegate & dataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (self.personInfoStyle == HJRegionStyle) {
        return 2;
    }else {
    return 1;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (self.personInfoStyle == HJRegionStyle) {
        switch (component) {
            case 0:
                return [provinces count];
                break;
            case 1:
                return [cities count];
                break;
            default:
                return 0;
                break;
        }
    }else {
    return self.dataSource.count;
    }
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (self.personInfoStyle == HJRegionStyle) {
        switch (component) {
            case 0:
                cities = [[provinces objectAtIndex:row] objectForKey:@"Cities"];
                [self.pickView selectRow:0 inComponent:1 animated:NO];
                [self.pickView reloadComponent:1];
                
                self.locate.state = [[provinces objectAtIndex:row] objectForKey:@"State"];
                self.locate.city = [[cities objectAtIndex:0] objectForKey:@"city"];
                break;
            case 1:
                self.locate.city = [[cities objectAtIndex:row] objectForKey:@"city"];
                break;
            default:
                break;
        }

    }else{
        NSString *title = self.dataSource[row];
        [self.selectDateArr removeAllObjects];
        [self.selectDateArr addObject:title];
    }
}
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (self.personInfoStyle == HJRegionStyle) {
        switch (component) {
            case 0:
                return [[provinces objectAtIndex:row] objectForKey:@"State"];
                break;
            case 1:
                return [[cities objectAtIndex:row] objectForKey:@"city"];
                break;
            default:
                return nil;
                break;
        }
    }else{
        return self.dataSource[row];
    }
}
@end
