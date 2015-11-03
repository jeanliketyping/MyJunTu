//
//  SceneAndHotelViewController.m
//  我的骏途
//
//  Created by mac on 15/10/24.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import "SceneAndHotelViewController.h"
#import "SceneAndHotelTableView.h"
#import "MyNetWorkQuery.h"
#import "SceneAndHotelModel.h"

@interface SceneAndHotelViewController ()
{
    SceneAndHotelTableView *_tableView;
    UILabel *_label;
}
@end

@implementation SceneAndHotelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, kScreenWidth-200, 30)];
    _label.font = [UIFont systemFontOfSize:15];
    self.navigationItem.titleView = _label;
    
}


- (void)setSceneAndHotelId:(NSString *)sceneAndHotelId{
    
    [self showProgress];
    
    if (_sceneAndHotelId != sceneAndHotelId) {
        _sceneAndHotelId = sceneAndHotelId;
        
        [self createViews];
        //读取数据
        NSString *urlString = [NSString stringWithFormat:@"http://www.juntu.com/index.php?m=app&c=scenic_hotel&a=show&id=%@",_sceneAndHotelId];
        
        //开启多线程
        [MyNetWorkQuery requestData:urlString HTTPMethod:@"GET" params:nil completionHandle:^(id result) {
            SceneAndHotelModel *model = [[SceneAndHotelModel alloc] initContentWithDic:result];
            //更新
            dispatch_async(dispatch_get_main_queue(), ^{
                _label.text = model.title;
                _tableView.model = model;
                
                [_tableView reloadData];
                [self hidProgress];
            });
            
 
        } errorHandle:^(NSError *error) {
            NSLog(@"error");
        }];
        
    }
    
}

// 创建视图
- (void)createViews{
    
    _tableView = [[SceneAndHotelTableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
