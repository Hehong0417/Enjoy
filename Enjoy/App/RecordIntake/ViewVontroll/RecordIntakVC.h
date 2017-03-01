//
//  RecordIntakVC.h
//  Enjoy
//
//  Created by IMAC on 16/3/19.
//  Copyright © 2016年 hejing. All rights reserved.
//

typedef NS_ENUM(NSUInteger, HJSuitType) {
    HJbreafestType,
    HJLunchType,
    HJdinnerType,
};

#import "HJViewController.h"

@interface RecordIntakVC : HJViewController

@property (strong, nonatomic) IBOutlet UIButton *breakfast;
@property (strong, nonatomic) IBOutlet UIButton *lunch;
@property (strong, nonatomic) IBOutlet UIButton *dinner;
@property (strong, nonatomic) IBOutlet UIView *fatherV;
@property (strong, nonatomic) IBOutlet UIButton *extraBtn;
@property (strong, nonatomic) IBOutlet UILabel *titleStr;
@property (strong, nonatomic) IBOutlet UITextField *kg;

@property (strong, nonatomic) IBOutlet UIImageView *image1;
@property (strong, nonatomic) IBOutlet UIImageView *image2;
@property (strong, nonatomic) IBOutlet UIImageView *image3;
@property (strong, nonatomic) IBOutlet UIImageView *image4;

@property (strong, nonatomic) IBOutlet UILabel *name1;
@property (strong, nonatomic) IBOutlet UILabel *name2;
@property (strong, nonatomic) IBOutlet UILabel *name3;
@property (strong, nonatomic) IBOutlet UILabel *name4;

@property (strong, nonatomic) IBOutlet UIButton *haveEaten;
@property (strong, nonatomic) IBOutlet UIButton *eatenOther;
@property (strong, nonatomic) IBOutlet UILabel *line;

@end
