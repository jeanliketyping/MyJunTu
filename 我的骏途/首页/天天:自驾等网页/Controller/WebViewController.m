//
//  WebViewController.m
//  我的骏途
//
//  Created by mac on 15/10/23.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import "WebViewController.h"
#import "RegexKitLite.h"
#import "OutDomesticViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController{
    UIWebView *_webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置标题
    self.title = _showTitle;
    //返回button
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [leftButton setImage:[UIImage imageNamed:@"back2x1"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftButtonAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    [self _createWebView];
}
//返回button
-(void)leftButtonAction{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

//创建网页视图
-(void)_createWebView {
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    if (self.urlString != nil) {
        NSURL *url = [NSURL URLWithString:self.urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:request];
    }else{
        [_webView loadHTMLString:self.showContent baseURL:nil];
    }
    _webView.delegate = self;
    [self.view addSubview:_webView];
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType
{
    //用代理获取点击位置的url
    NSString *urlString = request.URL.absoluteString;
    //使用正则表达式取出id,仅限出境、周边、国内
    NSString *regx = @"\\b\\d{4}\\b";
    NSArray *array = [urlString componentsMatchedByRegex:regx];
    if (array.count > 0) {
        OutDomesticViewController *outDomestic = [[OutDomesticViewController alloc] init];
        outDomestic.idStr = array[0];
        outDomestic.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:outDomestic animated:YES];
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
