//
//  ScenicSpotDetailViewController.m
//  我的骏途
//
//  Created by mac on 15/10/22.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import "ScenicSpotDetailViewController.h"
#import "ScenicSpotDetailTableView.h"
#import "ScenicSpotDetailModel.h"

@interface ScenicSpotDetailViewController ()
{
    ScenicSpotDetailTableView *_tableView;
    ScenicSpotDetailModel *_model;
}
@end

@implementation ScenicSpotDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"景区详情";
    //创建表视图
    [self createViews];
    
}

- (void)setScenicSpotId:(NSString *)scenicSpotId{
    
    [self showProgress];
    if (_scenicSpotId != scenicSpotId) {
        _scenicSpotId = scenicSpotId;
        [self createViews];
        //1. 构造url
        NSString *urlString = [kScenicShow stringByAppendingString:_scenicSpotId];
        
        NSURL *url = [NSURL URLWithString:urlString];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        //将请求的url数据放到NSData对象中
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSArray *destShow = dic[@"destShow"];
        NSDictionary *infoDic = [destShow lastObject];
        
        //创建model对象，添加数据
        _model = [[ScenicSpotDetailModel alloc] init];
        _model.title = infoDic[@"title"];
        _model.images = infoDic[@"images"];
        _model.position = infoDic[@"position"];
        _model.dest_highlight = infoDic[@"dest_highlight"];
        _model.show = infoDic[@"show"];
        _model.scenicId = infoDic[@"id"];
        _tableView.model = _model;
        [_tableView reloadData];
        [self hidProgress];
    }
}


// 创建视图
- (void)createViews{
    
    _tableView = [[ScenicSpotDetailTableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
