//
//  BaseNavigationController.m
//  我的骏途
//
//  Created by mac on 15/10/6.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏背景
    [self.navigationBar setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"1136_menu_background_lvkuang"]]];
    
    
}

@end
