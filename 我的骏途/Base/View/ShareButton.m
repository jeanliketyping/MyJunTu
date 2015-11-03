//
//  ShareButton.m
//  我的骏途
//
//  Created by 俞烨梁 on 15/10/27.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import "ShareButton.h"
#import "UIView+UIViewController.h"
#import <ShareSDK/ShareSDK.h>

#define Bcolor [UIColor colorWithRed:52/255.0 green:186/255.0 blue:200/255.0 alpha:1]

@implementation ShareButton
{
    UIView *_view;   //分享视图
    UIWindow *_window;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createWindow];
        
        [self createViews];
    }
    return self;
}

- (void)createWindow{
    _window = [[UIWindow alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    //优先级
    _window.windowLevel = UIWindowLevelStatusBar;
    
    _window.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    //给window添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    
    [_window addGestureRecognizer:tap];
}

- (void)tap:(UITapGestureRecognizer *)tap{
    //动态下移效果
    [UIView animateWithDuration:.3 animations:^{
        _view.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 120);

    }];

    //延时调用 隐藏window
    [self performSelector:@selector(hidden) withObject:self afterDelay:.3];

}

- (void)hidden{
    _window.hidden = YES;
}

- (void)createViews{
    [self setImage:[UIImage imageNamed:@"share2x"] forState:UIControlStateNormal];
    
    [self addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _view = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 120)];
    
    _view.backgroundColor = [UIColor whiteColor];
    
    [self.viewController.view addSubview:_view];
    
    CGFloat btnWidth = (kScreenWidth - 100)/4;
    NSArray *titles = @[@"微信好友",@"微信朋友圈",@"新浪微博",@"信息"];
    
    for (int i = 0; i < 4; i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake((btnWidth + 20)*i + 20, 40, btnWidth, 55)];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"shar_%i",i+1]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i + 100;
        
        [_view addSubview:button];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((btnWidth + 20)*i + 20, 100, btnWidth, 10)];
        label.text = titles[i];
        label.font = [UIFont systemFontOfSize:10];
        label.textAlignment = NSTextAlignmentCenter;
        
        [_view addSubview:label];
        
    }
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2 - 20, 10, 40, 20)];

    label.text = @"分享";
    label.textColor = Bcolor;
    
    [_view addSubview:label];
    
    [_window addSubview:_view];
    
}

- (void)shareAction:(UIButton *)button{
    
    _window.hidden = NO;
    
    [UIView animateWithDuration:.3 animations:^{
        _view.frame = CGRectMake(0, kScreenHeight - 120, kScreenWidth, 120);
    }];
    
}


- (void)buttonAction:(UIButton *)button{
    
    NSInteger index = button.tag - 100;
    
    if (index == 2) {
        NSLog(@"分享微博");
        
        //动态下移效果
        [UIView animateWithDuration:.3 animations:^{
            _view.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 120);
            
        }];
        
        //延时调用 隐藏window
        [self performSelector:@selector(hidden) withObject:self afterDelay:.3];

        
        //创建分享参数
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"骏途旅游推广"
                                         images:@[[UIImage imageNamed:@"logo2x"]]
                                            url:[NSURL URLWithString:@"www.juntu.com"]
                                          title:@"分享标题"
                                           type:SSDKContentTypeImage];
        
        //进行分享
        [ShareSDK share:SSDKPlatformTypeSinaWeibo
             parameters:shareParams
         onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
             
             switch (state) {
                 case SSDKResponseStateSuccess:
                 {
                     UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                         message:nil
                                                                        delegate:nil
                                                               cancelButtonTitle:@"确定"
                                                               otherButtonTitles:nil];
                     [alertView show];
                     break;
                 }
                 case SSDKResponseStateFail:
                 {
                     UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                         message:[NSString stringWithFormat:@"%@", error]
                                                                        delegate:nil
                                                               cancelButtonTitle:@"确定"
                                                               otherButtonTitles:nil];
                     [alertView show];
                     break;
                 }
                 case SSDKResponseStateCancel:
                 {
                     UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
                                                                         message:nil
                                                                        delegate:nil
                                                               cancelButtonTitle:@"确定"
                                                               otherButtonTitles:nil];
                     [alertView show];
                     break;
                 }
                 default:
                     break;
             }
             
         }];

    }else{
        NSLog(@"分享");
    }
    

    
}

@end
