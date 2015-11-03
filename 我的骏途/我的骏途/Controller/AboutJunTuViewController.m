//
//  AboutJunTuViewController.m
//  我的骏途
//
//  Created by 俞烨梁 on 15/10/26.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import "AboutJunTuViewController.h"
#import "WebViewController.h"
#import "BaseNavigationController.h"
#import "MyNetWorkQuery.h"
#import "LeadViewController.h"

#define kContent_announcement @"http://www.juntu.com/index.php?m=app&a=content_announcement"
#define kContent_user_registration @"http://www.juntu.com/index.php?m=app&a=content_user_registration"
#define kContent_help @"http://www.juntu.com/index.php?m=app&a=content_help"

@interface AboutJunTuViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSArray *_titles;
    WebViewController *_webView;
    NSMutableArray *_contentArray;
}
@end

@implementation AboutJunTuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"关于骏途";
    
    [self loadData];
    
    [self createTableView];

}

//获取数据
- (void)loadData{
    _titles = @[@"骏途公告",@"我的引导页",@"新功能介绍",@"当前版本",@"常见问题",@"意见反馈"];
    
    _contentArray = [[NSMutableArray alloc]initWithCapacity:3];
    
    [MyNetWorkQuery requestData:kContent_announcement HTTPMethod:@"GET" params:nil completionHandle:^(id result) {
        
        NSDictionary *content_announcementDic = result[@"content_announcement"];
        NSString *content_announcement = content_announcementDic[@"content"];
        
        [_contentArray addObject:content_announcement];
        
    } errorHandle:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];
    
    
    [MyNetWorkQuery requestData:kContent_user_registration HTTPMethod:@"GET" params:nil completionHandle:^(id result) {
        
        NSDictionary *content_user_registrationDic = result[@"content_user_registration"];
        NSString *content_user_registration = content_user_registrationDic[@"content"];

        [_contentArray addObject:content_user_registration];

    
    } errorHandle:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];
    
    [MyNetWorkQuery requestData:kContent_help HTTPMethod:@"GET" params:nil completionHandle:^(id result) {
        
        NSDictionary *content_helpDic = result[@"content_help"];
        NSString *content_help = content_helpDic[@"content"];

        [_contentArray addObject:content_help];
        
    } errorHandle:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];
    
   
    
}


//创建tableview
- (void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    //设置无法滚动
    _tableView.scrollEnabled = NO;
    
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier ];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (indexPath.row != 3) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //辅助箭头
    }
    if (indexPath.row == 3) {
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 100, 0, 100, 44)];
        lable.text = @"当前版本:2.2.1";
        lable.textColor = [UIColor orangeColor];
        lable.font = [UIFont systemFontOfSize:12];
        [cell.contentView addSubview:lable];
    }
    
    cell.textLabel.text =  _titles[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;   //选中效果
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectZero];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 10, kScreenWidth-100, 80)];
    imageView.image = [UIImage imageNamed:@"logo2x"];
    
    imageView.contentMode = UIViewContentModeScaleAspectFit;   //图片自适应
    
    [view addSubview:imageView];
    
    return view;
}

//选中事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _webView = [[WebViewController alloc]init];
    
    if (_contentArray.count == 3) {
        if (indexPath.row == 0) {
            
            _webView.showTitle = _titles[0];
            
            _webView.showContent = _contentArray[0];
            BaseNavigationController *baseNavi = [[BaseNavigationController alloc]initWithRootViewController:_webView];
            [self.navigationController presentViewController:baseNavi animated:YES completion:nil];
            
        }else if (indexPath.row == 1){
            
            LeadViewController *leadViewC = [[LeadViewController alloc]init];
            leadViewC.index = 3;
            [self presentViewController:leadViewC animated:YES completion:nil];
            
        }else if (indexPath.row == 2){
            
            _webView.showTitle = _titles[2];
            _webView.showContent = _contentArray[1];
            BaseNavigationController *baseNavi = [[BaseNavigationController alloc]initWithRootViewController:_webView];
            [self.navigationController presentViewController:baseNavi animated:YES completion:nil];
            
        }else if (indexPath.row == 4){
            
            _webView.showTitle = _titles[4];
            _webView.showContent = _contentArray[2];
            BaseNavigationController *baseNavi = [[BaseNavigationController alloc]initWithRootViewController:_webView];
            [self.navigationController presentViewController:baseNavi animated:YES completion:nil];
            
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
