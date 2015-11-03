//
//  JunTuImageView.m
//  我的骏途
//
//  Created by mac on 15/10/26.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import "JunTuImageView.h"
#import "WebViewController.h"
#import "BaseNavigationController.h"
#import "UIView+UIViewController.h"

@implementation JunTuImageView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //接受点击事件
        self.userInteractionEnabled = YES;
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    WebViewController *webView = [[WebViewController alloc] init];
    webView.showTitle = @"骏途旅游";
    webView.urlString = self.urlString;
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:webView];
    [self.viewController.navigationController presentViewController:nav animated:YES completion:nil];
}

@end
