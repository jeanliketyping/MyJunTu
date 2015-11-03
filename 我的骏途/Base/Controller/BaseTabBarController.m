//
//  BaseTabBarController.m
//  我的骏途
//
//  Created by mac on 15/10/6.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import "BaseTabBarController.h"
#import "TabBarButton.h"

#define Bcolor [UIColor colorWithRed:52/255.0 green:186/255.0 blue:200/255.0 alpha:1]

@interface BaseTabBarController ()<UIAlertViewDelegate>
{
    UIView *_newTabBar;//自定义标签栏
    NSMutableArray *_btnArray;
    NSMutableArray *_selectedImages;
    NSMutableArray *_normalImages;
}
@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
    //创建自定义标签栏
    [self _createTabBar];
    
}

- (void)loadData{
    _btnArray = [NSMutableArray array];
    _selectedImages = [NSMutableArray array];
    _normalImages = [NSMutableArray array];
    
    for (int i = 0; i < 4; i++) {
        UIImage *selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"图标a1%i",i+1]];
        [_selectedImages addObject:selectedImage];
        
        UIImage *normalImage = [UIImage imageNamed:[NSString stringWithFormat:@"图标a%i",i+1]];
        [_normalImages addObject:normalImage];
    }
    
}

#pragma mark - 设置标签栏隐藏/显示
-(void)setTabBarHidden:(BOOL)isHidden {
    _newTabBar.hidden = isHidden;
}

-(void)_createTabBar {
    self.tabBar.hidden = YES;
    //创建自定义标签栏
    _newTabBar = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 49, kScreenWidth, 49)];
    _newTabBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"1_4"]];
    [self.view addSubview:_newTabBar];
    
    //按钮宽度
    CGFloat buttonWidth = kScreenWidth / 4;
    
    NSArray *nameArray = @[@"首页",
                           @"我的订单",
                           @"我的骏途",
                           @"联系骏途"
                           ];
    for (int i = 0; i < 4; i++) {
        //创建一个子类化按钮
        TabBarButton *button = [[TabBarButton alloc] initWithTitle:nameArray[i] imageName:[NSString stringWithFormat:@"图标a%i",i+1] frame:CGRectMake(buttonWidth * i, 0, buttonWidth, 49)];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i + 100;
        [_newTabBar addSubview:button];
        [_btnArray addObject:button];
        if (i == 0) {
            button.label.textColor = Bcolor;
            button.myImageView.image = _selectedImages[0];
        }
    }
}

-(void)buttonAction:(TabBarButton *)button {
    NSInteger index = button.tag - 100;
    self.selectedIndex = index;
    if (index == 3) {
        //创建电话alertView
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"400-029-9966" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫", nil];
        [alert show];
    }
    
    for (int i = 0; i < 4; i++) {
        if (index == i) {
            continue;
        }else{
            TabBarButton *btn = _btnArray[i];
            btn.label.textColor = [UIColor grayColor];
            btn.myImageView.image = _normalImages[i];
        }
    }
    
    button.label.textColor = Bcolor;
    button.myImageView.image = _selectedImages[index];
    
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        NSLog(@"呼叫");
    }
}

@end
