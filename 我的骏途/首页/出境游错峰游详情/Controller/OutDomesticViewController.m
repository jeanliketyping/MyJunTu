//
//  OutDomesticViewController.m
//  我的骏途
//
//  Created by mac on 15/10/18.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import "OutDomesticViewController.h"
#import "MyNetWorkQuery.h"
#import "OutDomesticModel.h"
#import "OutDomesticHeadView.h"

@interface OutDomesticViewController ()

@end

@implementation OutDomesticViewController{
    UITableView *_tableView;
    OutDomesticHeadView *_headView;//tableView的头视图
    OutDomesticModel *_headModel;
    UIImageView *_lineView;//下划线
    UIWebView *_showWeb;//网页视图
    NSURLRequest *_request;
    NSString *_endString;
    
    int height;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"出游详情";
    NSLog(@"%@",self.idStr);
    //创建网页视图
    [self _createWebView];
    //创建tableView
    [self _createTableView];
    //创建底部电话购买视图
    [self _createBottomView];
    [self _loadData];
}

//加载数据
-(void)_loadData {
    [self showProgress];
    NSString *string = kDetail;
    NSString *urlString = [string stringByAppendingString:self.idStr];
    [MyNetWorkQuery requestData:urlString HTTPMethod:@"GET" params:nil completionHandle:^(id result) {
        //得到数据
        //传值
        NSArray *toursArray = result[@"toursShow"];
        NSDictionary *toursDic = [toursArray lastObject];
        //在主线程赋值
        dispatch_async(dispatch_get_main_queue(), ^{
            OutDomesticModel *headModel = [[OutDomesticModel alloc] initContentWithDic:toursDic];
            _headView.model = headModel;
            _headModel = headModel;
            [_tableView reloadData];
            [self hidProgress];
        });
        
    } errorHandle:^(NSError *error) {
        NSLog(@"error:%@",error);
    }];
    
}

//创建视图
-(void)_createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    //头视图
    _headView = [[[NSBundle mainBundle] loadNibNamed:@"OutDomesticHeadView" owner:nil options:nil] lastObject];
    _headView.frame = CGRectMake(0, 0, kScreenWidth, 250);
    _tableView.tableHeaderView = _headView;
}

//创建网页视图
-(void)_createWebView {
    
    //stroke_detail
    _endString = [NSString stringWithFormat:@"%@&client_type=3",self.idStr];
    NSString *urlString = [kStrokeD stringByAppendingString:_endString];
    
    //网页视图
    _showWeb = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-150)];
    _showWeb.scrollView.delegate = self;
    _showWeb.delegate = self;
    _showWeb.backgroundColor = [UIColor whiteColor];
    _request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
   [_showWeb loadRequest:_request];
}

//创建尾视图
-(void)_createBottomView {
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-49, kScreenWidth, 49)];
    bottomView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"juntu_2_7.jpg"]];
    [self.view addSubview:bottomView];
    
    //电话咨询button
    UIButton *phoneButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 8, kScreenWidth/2 - 40, 30)];
    //立即购买button
    UIButton *buyButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 10, 8, kScreenWidth/2 - 10, 30)];
    [bottomView addSubview:phoneButton];
    [bottomView addSubview:buyButton];
    
    //添加属性
    [phoneButton setTitle:@"电话咨询" forState:UIControlStateNormal];
    [buyButton setTitle:@"立即购买" forState:UIControlStateNormal];
    //字体颜色
    [phoneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [buyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //button背景
    [phoneButton setBackgroundImage:[UIImage imageNamed:@"zixun_normal—111.png"] forState:UIControlStateNormal];
    [buyButton setBackgroundImage:[UIImage imageNamed:@"yuding_normal2x.png"] forState:UIControlStateNormal];
    
}

#pragma mark - UIWebView 代理
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    NSURLCache * cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
    
    [_showWeb stopLoading];
}



#pragma mark - UITableView 代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else{
        return 35;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 35;
    }else{
        return kScreenHeight-150;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 10;
    }else{
        return 0;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (indexPath.section == 0) {
        //日历图标
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 7.5, 20, 20)];
        imageView.image = [UIImage imageNamed:@"rili12x"];
        [cell.contentView addSubview:imageView];
        
        UILabel *explainLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right+5, 2.5, 150, 30)];
        explainLabel.text = @"请选择出发日期";
        explainLabel.font = [UIFont systemFontOfSize:14];
        [cell.contentView addSubview:explainLabel];
        //日期
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(180, 2.5, 100, 30)];
        timeLabel.text = _headModel.travel_date;
        timeLabel.font = [UIFont systemFontOfSize:14];
        timeLabel.textAlignment = NSTextAlignmentRight;
        timeLabel.textColor = [UIColor colorWithRed:50/255.0 green:184/255.0 blue:190/255.0 alpha:1];
        [cell.contentView addSubview:timeLabel];
        
        //设置右标
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if (indexPath.section == 1){//加载网页视图
        [cell.contentView addSubview:_showWeb];
    }
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        
        UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 35)];
        //四个button
        NSArray *array = @[@"行程介绍",@"线路特色",@"费用说明",@"重要提示"];
        CGFloat buttonWidth = kScreenWidth/array.count;
        for (int i = 0; i < array.count; i++) {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i*buttonWidth, 0, buttonWidth, 33)];
            [button setTitle:array[i] forState:UIControlStateNormal];
            button.backgroundColor = [UIColor whiteColor];
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            button.titleLabel.font = [UIFont boldSystemFontOfSize:14];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(selecteButton:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = i + 200;
            [sectionView addSubview:button];
        }
        
        //下划线
        _lineView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 33, buttonWidth-10, 2)];
        _lineView.backgroundColor = [UIColor colorWithRed:50/255.0 green:184/255.0 blue:190/255.0 alpha:1];
        [sectionView addSubview:_lineView];
        
        return sectionView;
    }else{
        return nil;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        NSLog(@"日历");
    }
}

//四个button，行程介绍等
-(void)selecteButton:(UIButton *)button {
    NSInteger index = button.tag - 200;
    [UIView animateWithDuration:.3 animations:^{
        _lineView.transform = CGAffineTransformMakeTranslation(index*button.width, 0);
    }];
    
    NSString *urlString;
    switch (index) {
        case 0://行程介绍
            urlString = [kStrokeD stringByAppendingString:_endString];
            break;
        case 2://费用说明
            urlString = [kFeeD stringByAppendingString:_endString];
            break;
        case 3://重要提示
            urlString = [kNoticeD stringByAppendingString:_endString];
            break;
        default:
            break;
    }
    _request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    //重新加载数据
    [_showWeb stopLoading];
    [_showWeb loadRequest:_request];
    
    //线路特色
    if (index == 1) {
        CGFloat fontSize = 14;
        NSString *fontColor = @"Gray";
        NSString *text = [_headModel.features stringByReplacingOccurrencesOfString:@"\n" withString:@"<br>"];
        NSString *jsString = [NSString stringWithFormat:@"<html> \n"
                              "<head> \n"
                              "<style type=\"text/css\"> \n"
                              "body {font-size: %f; color: %@;}\n"
                              "</style> \n"
                              "</head> \n"
                              "<body>%@</body> \n"
                              "</html>", fontSize, fontColor, text];
        [_showWeb loadHTMLString:jsString baseURL:nil];
    }
    _showWeb.scrollView.delegate = self;
    
}

//webView拉到顶部时
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGFloat offY = _showWeb.scrollView.contentOffset.y;
    if (offY <0) {
        _showWeb.scrollView.contentOffset = CGPointMake(0, 0);
        CGPoint offSet = CGPointMake(0, -64);
        [UIView animateWithDuration:.5 animations:^{
            _tableView.contentOffset = offSet;
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
