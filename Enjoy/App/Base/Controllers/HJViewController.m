//
//  HJViewController.m
//  Cancer
//
//  Created by zhipeng-mac on 16/2/25.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import "HJViewController.h"
#import "UIViewController+AOP.h"
@interface HJViewController ()

@end

@implementation HJViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self doSomeThingInViewDidLoad];
    
    
    XYQButton *backBtn = [UIViewController aopBackButton];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    [backBtn addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor clearColor];
    
}

-(void)back{
    [self.navigationController popVC];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    //
    [self doSomeThingInViewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - HJViewControllerProtocol

- (void)doSomeThingInViewDidLoad {
    
    
}

- (void)doSomeThingInViewWillAppear {
    
    
}

@end
