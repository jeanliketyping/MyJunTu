//
//  BaseViewController.m
//  我的骏途
//
//  Created by mac on 15/10/6.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseTabBarController.h"
#import "HUProgressView.h"

@interface BaseViewController ()
{
    UILabel *_titleLabel;
    BOOL _isHiddenTabBar;
    UIView *_hiddenView;
}
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.text = @"title";
    self.navigationItem.titleView = _titleLabel;
    
    //返回button
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [leftButton setImage:[UIImage imageNamed:@"back2x1"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftButtonAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    //设置背景
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bkg.jpg"]];
}

-(void)leftButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setTitle:(NSString *)title {
    [super setTitle:title];
    _titleLabel.text = title;
}

#pragma mark - 设置标签栏的隐藏和显示
-(void)viewWillAppear:(BOOL)animated {
    if (_isHiddenTabBar) {
        //隐藏标签栏
        BaseTabBarController *tabBar = (BaseTabBarController *)self.tabBarController;
        [tabBar setTabBarHidden:YES];
    }else {
        //显示标签栏
        BaseTabBarController *tabBar = (BaseTabBarController *)self.tabBarController;
        [tabBar setTabBarHidden:NO];
    }
}
-(void)viewWillDisappear:(BOOL)animated {
    //显示标签栏
    BaseTabBarController *tabBar = (BaseTabBarController *)self.tabBarController;
    [tabBar setTabBarHidden:NO];
}

-(void)setHidesBottomBarWhenPushed:(BOOL)hidesBottomBarWhenPushed {
    _isHiddenTabBar = hidesBottomBarWhenPushed;
}

#pragma mark - 显示进度
-(void)showProgress{
    //创建遮罩视图
    _hiddenView = [[UIView alloc] initWithFrame:self.view.bounds];
    _hiddenView.backgroundColor = [UIColor colorWithWhite:0 alpha:.2];
    [self.view addSubview:_hiddenView];
    
    HUProgressView *progress = [[HUProgressView alloc] initWithProgressIndicatorStyle:HUProgressIndicatorStyleLarge];
    progress.center = _hiddenView.center;
    progress.strokeColor = [UIColor cyanColor];
    [_hiddenView addSubview:progress];
    [progress startProgressAnimating];
    
    UIImageView *horseimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    horseimage.center = _hiddenView.center;
    horseimage.image = [UIImage imageNamed:@"ma"];
    [_hiddenView addSubview:horseimage];
}

-(void)hidProgress{
    [self performSelector:@selector(hidAction) withObject:self afterDelay:.5];
}
-(void)hidAction{
    [_hiddenView removeFromSuperview];
}
@end
