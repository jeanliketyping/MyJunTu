//
//  HomeViewController.m
//  我的骏途
//
//  Created by mac on 15/10/6.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import "HomeViewController.h"
#import "SearchViewController.h"
#import "AFNetworking.h"
#import "MainCollectionView.h"
#import "UIButton+WebCache.h"
#import "MyNetWorkQuery.h"
#import "RegexKitLite.h"
#import "OutDomesticViewController.h"
#import "BaseNavigationController.h"
#import "WebViewController.h"
#import "JunTuImageView.h"
//下拉刷新
#import "MJRefresh.h"
#import "MJDIYHeader.h"

#define Bcolor [UIColor colorWithRed:52/255.0 green:186/255.0 blue:200/255.0 alpha:1]
@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UIWebViewDelegate>
{
    UIScrollView *_scrollView;
    NSArray *_scrollViewData;//滚动视图的数据
    UIPageControl *_pageControl;
    UIButton *_outboundButton;//出境游
    UIButton *_domesticButton;//错峰游
    UITableView *_tableView;
    UIView *_buttonLine;//选中按钮的下划线
    UIImageView *_leftImgView;
    UIWebView *_showWeb;
    NSURLRequest *_request;
    NSArray *_fourButtonData;
    NSTimer *_timer;
}
@end

@implementation HomeViewController

-(void)viewDidAppear:(BOOL)animated{
    [_timer invalidate];
    _pageControl.currentPage = 0;
    _scrollView.contentOffset = CGPointMake(0, 0);
    [self starTimerAction];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //加载数据
    [self _loadData];
    //创建导航栏
    [self _createNavi];
    //创建表视图
    [self creatTableView];
    
}

#pragma mark - 导航栏
-(void)_createNavi {
    //设置导航栏小马
    _leftImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_white2x"]];
    _leftImgView.frame = CGRectMake(0, 0, 37, 23);
    //导航栏小马
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:_leftImgView];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    
    //导航栏搜索框
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 230, 30)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = titleView.bounds;
    //设置字体
    [button setTitle:@"搜索目的地、景点、酒店等" forState:UIControlStateNormal];
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    //设置搜索条
    [button setBackgroundImage:[UIImage imageNamed:@"1136_menu_btn_sousuotiao"] forState:UIControlStateNormal];
    //设置圆角
    button.layer.cornerRadius = 10;
    button.layer.masksToBounds = YES;
    
    [button addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    
    [titleView addSubview:button];
    [self.navigationItem setTitleView:titleView];

}
-(void)searchAction {
    //跳到搜索页
    SearchViewController *search = [[SearchViewController alloc] init];
    [search setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:search animated:YES];
}

#pragma mark - 数据加载
-(void)_loadData {
    
    //读取ScrollerView的数据
    NSString *urlString = @"http://www.juntu.com/index.php?m=app&c=index&a=index_focus&version=1.3";
    
    //开启多线程
     [MyNetWorkQuery requestData:urlString HTTPMethod:@"GET" params:nil completionHandle:^(id result) {
        //滚动视图的数据
        _scrollViewData = result[@"subject"];
        //特别推荐的数据
        _fourButtonData = result[@"recommend"];
         
         //更新
         dispatch_async(dispatch_get_main_queue(), ^{
             [_tableView.header endRefreshing];
             [_tableView reloadData];
         });
         
    } errorHandle:^(NSError *error) {
        NSLog(@"error");
    }];
    
}

#pragma mark - 表视图
-(void)creatTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    
    //添加下拉刷新
    _tableView.header = [MJDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshAction)];
    
    //网页视图
    _showWeb = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-130)];
    _request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://s.juntu.com/index.php?m=mobile&c=index&a=bottom_classify_left"]];
    _showWeb.delegate = self;
    _showWeb.scrollView.delegate = self;
    _showWeb.backgroundColor = [UIColor clearColor];
    [_showWeb loadRequest:_request];
}

-(void)refreshAction{
    NSLog(@"下拉刷新");
    _scrollViewData = nil;
    _fourButtonData = nil;
    [self _loadData];
}

-(void)starTimerAction {
    _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
}
-(void)timeAction{
    if (_pageControl.currentPage == _scrollViewData.count-1) {
        _pageControl.currentPage=0;
        _scrollView.contentOffset = CGPointMake(_pageControl.currentPage*kScreenWidth, 0);
        
    }else{
    [UIView animateWithDuration:0.5 animations:^{
            _pageControl.currentPage++;
            _scrollView.contentOffset = CGPointMake(_pageControl.currentPage*kScreenWidth, 0);
            
    }];
    }
}

#pragma mark - UITableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 400;
    }else{
        return 30;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kScreenHeight-130;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (indexPath.section == 1) {
        [cell.contentView addSubview:_showWeb];
    }
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 400)];
        
        //滑动视图
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
        _scrollView.contentSize = CGSizeMake(kScreenWidth * _scrollViewData.count, 150);
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        //插入图片
        for (int i = 0; i<_scrollViewData.count; i++) {
            NSDictionary *dic = _scrollViewData[i];
            NSString *imageUrl = dic[@"thumb"];
            NSString *linkUrl = dic[@"linkurl"];
            JunTuImageView *imageView = [[JunTuImageView alloc] initWithFrame:CGRectMake(i*kScreenWidth, 0, kScreenWidth, 150)];
            imageView.urlString = linkUrl;
            [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"384.jpg"]];
            [_scrollView addSubview:imageView];
        }
        [view addSubview:_scrollView];

        //分页
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(kScreenWidth/4, 135, kScreenWidth/2, 15)];
        _pageControl.numberOfPages = _scrollViewData.count;
        _pageControl.currentPage = 0;
        
        [view addSubview:_pageControl];
        
        
        //collectionview
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ImageList" ofType:@"plist"];
        NSArray *imageData = [NSArray arrayWithContentsOfFile:filePath];
        NSArray *imageNames = @[@"btnTop8_1",@"btnTop8_2",@"btnTop8_3",@"btnTop8_4",@"btnTop8_5",@"btnTop8_6",@"btnTop8_7",@"btnTop8_8"];
        NSArray *titles = @[@"景点门票",@"出境游",@"国内游",@"天天特价",@"西安周边游",@"度假酒店",@"景加酒",@"自驾游"];
        MainCollectionView *mainCollectionView = [[MainCollectionView alloc]initWithFrame:CGRectMake(0, 150, kScreenWidth, 150) titles:titles imageData:imageData imageNames:imageNames];
        mainCollectionView.backgroundColor = [UIColor whiteColor];
        [view addSubview:mainCollectionView];
        
        //四个模块的宽高
        CGFloat width = kScreenWidth / 2;
        CGFloat height = 45;
        
        //循环创建四个推荐模块
        for (int i = 0; i < 2; i ++)
        {
            for (int j = 0; j < 2 ; j ++)
            {
                int index = i * 2 + j;
                UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(j * (width + 2), i * (height + 2) + 305, width -1, height-1)];
                NSDictionary *dic = _fourButtonData[index];
                NSString *urlString = dic[@"thumb"];
                [button sd_setImageWithURL:[NSURL URLWithString:urlString] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@""]];
                [button addTarget:self action:@selector(fourButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                button.tag = 100 + index;
                button.backgroundColor = [UIColor whiteColor];
                [view addSubview:button];
            }
        }
        
        
        return view;
    }else{
        
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
        //出境游
        _outboundButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 1, kScreenWidth/2 , 28)];
        [_outboundButton setTitle:@"出境精品游" forState:UIControlStateNormal];
        _outboundButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_outboundButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_outboundButton setTitleColor:Bcolor forState:UIControlStateSelected];
        _outboundButton.backgroundColor = [UIColor whiteColor];
        [_outboundButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        _outboundButton.tag = 100;
        _outboundButton.selected = YES;
        //错峰游
        _domesticButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/2 , 1, kScreenWidth/2, 28)];
        [_domesticButton setTitle:@"国内错峰游" forState:UIControlStateNormal];
        _domesticButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_domesticButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_domesticButton setTitleColor:Bcolor forState:UIControlStateSelected];
        _domesticButton.backgroundColor = [UIColor whiteColor];
        [_domesticButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        _domesticButton.tag = 101;
        [headView addSubview:_outboundButton];
        [headView addSubview:_domesticButton];
        
        //下滑线
        _buttonLine = [[UIView alloc] initWithFrame:CGRectMake(10, 28, kScreenWidth/2 - 20, 2)];
        _buttonLine.backgroundColor = Bcolor;
        [headView addSubview:_buttonLine];
        
        return headView;
    }
}

#pragma mark - scrollViewDidScroll
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat moveDis = scrollView.contentOffset.y;
    //白马-->蓝马
    if (moveDis > 0) {
        _leftImgView.image = [UIImage imageNamed:@"组合3"];
    }
    //蓝马-->白马
    else{
        _leftImgView.image = [UIImage imageNamed:@"logo_white2x"];
    }
    NSInteger offset = scrollView.contentOffset.x;
    NSInteger page = offset/kScreenWidth;
    _pageControl.currentPage = page;
    
    CGFloat offY = _showWeb.scrollView.contentOffset.y;
    if (offY <0) {
        _showWeb.scrollView.contentOffset = CGPointMake(0, 0);
        CGPoint offSet = CGPointMake(0, -64);
        [UIView animateWithDuration:.5 animations:^{
            _tableView.contentOffset = offSet;
        }];
    }
    
}

//出境游和错峰游
-(void)buttonAction:(UIButton *)button {
    
    if (button.tag == 100) {
        
        _request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://s.juntu.com/index.php?m=mobile&c=index&a=bottom_classify_left"]];
        
        _outboundButton.selected = YES;
        _domesticButton.selected = NO;
        [UIView animateWithDuration:.2 animations:^{
            _buttonLine.transform = CGAffineTransformIdentity;
        }];
        
    }else if(button.tag == 101){
        
        _request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://s.juntu.com/index.php?m=mobile&c=index&a=bottom_classify_right"]];
        
        _outboundButton.selected = NO;
        _domesticButton.selected = YES;
        [UIView animateWithDuration:.2 animations:^{
            _buttonLine.transform = CGAffineTransformMakeTranslation(kScreenWidth/2, 0);
        }];
    }
    
    [_showWeb loadRequest:_request];
}

//四个推荐button
-(void)fourButtonAction:(UIButton *)button {
    NSInteger index = button.tag - 100;
    NSDictionary *dic = _fourButtonData[index];
    NSString *urlString = dic[@"linkurl"];
    
    WebViewController *webView = [[WebViewController alloc] init];
    webView.urlString = urlString;
    webView.showTitle = dic[@"name"];
    BaseNavigationController *navWeb = [[BaseNavigationController alloc] initWithRootViewController:webView];
    [self.navigationController presentViewController:navWeb animated:YES completion:nil];
    
}



#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType
{
    //用代理获取点击位置的url
    NSString *urlString = request.URL.absoluteString;
//    NSLog(@"%@",urlString);
    //使用正则表达式取出id
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
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSURLCache * cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
    
}
@end
