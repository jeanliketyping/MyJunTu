//
//  LeadViewController.m
//  我的骏途
//
//  Created by 俞烨梁 on 15/10/26.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import "LeadViewController.h"

@interface LeadViewController ()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
}
@end

@implementation LeadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"first"];
    [self createScrollView];
    
}

- (void)createScrollView{
    _scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    //全局大小
    _scrollView.contentSize = CGSizeMake(kScreenWidth * 4, kScreenHeight);
    //分页
    _scrollView.pagingEnabled = YES;
    //隐藏滚动栏
    _scrollView.showsHorizontalScrollIndicator = NO;
    //代理
    _scrollView.delegate = self;
    //无反弹效果
    _scrollView.bounces = NO;
    
    for (int i = 0; i < 4; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * kScreenWidth, 0, kScreenWidth, kScreenHeight)];
        
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"6引导%i",i+1]];
        
        [_scrollView addSubview:imageView];
    }
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth *3 + 88, kScreenHeight - 100, 142, 35)];
    button.backgroundColor = [UIColor clearColor];
    
    [button addTarget:self action:@selector(start:) forControlEvents:UIControlEventTouchUpInside];
    
    [_scrollView addSubview:button];
    
    [self.view addSubview:_scrollView];
    
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, kScreenHeight - 50, kScreenWidth, 35)];
    _pageControl.numberOfPages = 4;
    _pageControl.backgroundColor = [UIColor clearColor];
    
    _pageControl.currentPage = 0;
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    
    [_pageControl addTarget:self action:@selector(pageCon:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:_pageControl];
}


//pageControl方法
- (void)pageCon:(UIPageControl *)sender{
    
    NSInteger index = sender.currentPage;
    
    CGFloat contentOffsetX = index * kScreenWidth;
    
    CGPoint off = CGPointMake(contentOffsetX, 0);
    
    [_scrollView setContentOffset:off animated:YES];
    
}

//滚动结束时
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat xOffset = scrollView.contentOffset.x;
    NSInteger index = xOffset/kScreenWidth;
    
    //pageControl当前页改变
    _pageControl.currentPage = index;
}

#pragma mark - 跳转到主界面
- (void)start:(UIButton *)btn{
    NSLog( @"进入");
    if (_index == 0) {//进入主界面
        UIApplication *app = [UIApplication sharedApplication];
        [app setStatusBarHidden:NO];
        
        //读取故事版 获取ViewController
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        
        //获取故事版中的第一个ViewController
        BaseViewController *vc = [storyboard instantiateInitialViewController];
        //获取当前控制器的_view所显示在那个窗口上
        self.view.window.rootViewController = vc;
        
        //界面显示动画
        vc.view.transform = CGAffineTransformMakeScale(0.2, 0.2);
        
        [UIView animateWithDuration:0.5 animations:^{
            vc.view.transform = CGAffineTransformIdentity;
        }];
    }else if (_index == 3){//回到我的骏途
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
