//
//  CouponViewController.m
//  我的骏途
//
//  Created by mac on 15/10/26.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

/*
 no_list_tu.png
 no_youhuijuan.png
 no_dianzijuan.png
 no_list_btn.png
 */

#import "CouponViewController.h"
#import "HomeViewController.h"
#import "AppDelegate.h"
#import "BaseTabBarController.h"

@interface CouponViewController ()

@end

@implementation CouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.couponType == 0) {
        self.title = @"优惠券";
    }else if (self.couponType == 1){
        self.title = @"电子券";
    }
    [self createViews];
}

- (void)createViews{
    
    UIImageView *faceImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - 58)/2, 180, 58, 58)];
    faceImageView.image = [UIImage imageNamed:@"no_list_tu.png"];
    [self.view addSubview:faceImageView];
    
    UIImageView *noCouponImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - 95)/2, 250, 95, 14)];
    if (self.couponType == 0) {
        noCouponImageView.image = [UIImage imageNamed:@"no_youhuijuan.png"];
    }else if (self.couponType == 1){
        noCouponImageView.image = [UIImage imageNamed:@"no_dianzijuan.png"];
    }
    [self.view addSubview:noCouponImageView];
    
    UIButton *backToMainButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backToMainButton.frame = CGRectMake((kScreenWidth-183)/2, 280, 183, 38);
    [backToMainButton setBackgroundImage:[UIImage imageNamed:@"no_list_btn"] forState:UIControlStateNormal];
    [backToMainButton addTarget:self action:@selector(backToMain:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backToMainButton];

}


- (void)backToMain:(UIButton *)button{
    NSLog( @"返回主页");

    [self.navigationController popToRootViewControllerAnimated:YES];
    self.tabBarController.selectedIndex = 0;

}


@end
