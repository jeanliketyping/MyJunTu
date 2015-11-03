//
//  OrderListViewController.m
//  我的骏途
//
//  Created by mac on 15/10/11.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import "OrderListViewController.h"
#import "OrderCell.h"
#import "MyNetWorkQuery.h"
#import "OrderModel.h"

@interface OrderListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIImageView *_selectImageView;
    CGFloat width;
    UITableView *_tabeleView;
    
    NSMutableArray *_listInfo;
}
@end

@implementation OrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置标题
    NSString *name = [NSString stringWithFormat:@"%@列表",_orderTitle];
    self.title = name;
    self.view.backgroundColor = [UIColor colorWithRed:236/255.0 green:235/255.0 blue:243/255.0 alpha:1];
    [self _creatTopView];

}

//数据加载
- (void)setOrder_type:(NSString *)order_type {
    
    if (_order_type != order_type) {
        _order_type = order_type;
        
        [self _createTableView];
        [self showProgress];
        
        NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:kUserID];
        //读取数据
        NSString *urlString = [NSString stringWithFormat:@"http://www.juntu.com/index.php?m=app&c=member_order&a=%@_order&type=1&page=1&userid=%@",_order_type,userid];
        //开启多线程
        [MyNetWorkQuery requestData:urlString HTTPMethod:@"GET" params:nil completionHandle:^(id result) {
            
            NSArray *list = result[@"list"];
            _listInfo = [NSMutableArray array];
            for (NSDictionary *dic in list) {
                OrderModel *model = [[OrderModel alloc] initContentWithDic:dic];
                model.order_type = _order_type;
                [_listInfo addObject:model];
                
            }
            //更新
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tabeleView reloadData];
                [self hidProgress];
                if (_listInfo.count == 0) {
                    [self _createNormalView];
                }
            });
            
            
        } errorHandle:^(NSError *error) {
            NSLog(@"error");
        }];
    }
    
}

//创建头部选中视图
-(void)_creatTopView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 40)];
    view.backgroundColor = [UIColor whiteColor];
    NSArray *buttonNames = @[@"全部",@"未支付",@"未验证",@"退款单"];
    width = self.view.frame.size.width/4;
    
    _selectImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 38, width, 2)];
    _selectImageView.image = [UIImage imageNamed:@"1136_menu_background_lvkuang11"];
    [view addSubview:_selectImageView];
    for (int i = 0; i < 4; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i*width, 0, width, 40)];
        [button setTitle:buttonNames[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        button.tag = i + 100;
    }
    [self.view addSubview:view];
    
    
}



//创建表视图
- (void)_createTableView{
    
    _tabeleView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    _tabeleView.dataSource= self;
    _tabeleView.delegate = self;
    [self.view addSubview:_tabeleView];
    //注册一个单元格
    UINib *nib = [UINib nibWithNibName:@"OrderCell" bundle:nil];
    [_tabeleView registerNib:nib forCellReuseIdentifier:@"OrderCell"];

}

//创建没有订单时的视图
- (void)_createNormalView{
    
    UIImageView *faceImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - 58)/2, 180, 58, 58)];
    faceImageView.image = [UIImage imageNamed:@"no_list_tu.png"];
    [self.view addSubview:faceImageView];
    
    UIImageView *noCouponImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - 95)/2, 250, 95, 14)];
    noCouponImageView.image = [UIImage imageNamed:@"no_list_zi"];
    
    [self.view addSubview:noCouponImageView];
    
    UIButton *backToMainButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backToMainButton.frame = CGRectMake((kScreenWidth-183)/2, 280, 183, 38);
    [backToMainButton setBackgroundImage:[UIImage imageNamed:@"no_list_btn"] forState:UIControlStateNormal];
    [backToMainButton addTarget:self action:@selector(backToMain:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backToMainButton];
    
}

-(void)buttonAction:(UIButton *)btn{
    
    NSInteger i = btn.tag - 100;
    [UIView animateWithDuration:0.3 animations:^{
        _selectImageView.frame = CGRectMake(i*width, 38, width, 2) ;
        
    }];
    NSLog(@"订单类型%ld",i);
    
    NSMutableArray *array = [NSMutableArray array];
    array = _listInfo;
    _listInfo = [NSMutableArray array];
    if (i == 0) {
        for (OrderModel *model in array) {
            [_listInfo addObject:model];
        }
        [_tabeleView reloadData];
        _listInfo = array;
    }
    
    if (i == 1) {
        for (OrderModel *model in array) {
            
            if ([model.order_status isEqualToNumber:@2]) {
                [_listInfo addObject:model];
            }
        }
        [_tabeleView reloadData];
        _listInfo = array;

    }else if (i == 2){
        for (OrderModel *model in array) {
            
            if ([model.order_status isEqualToNumber:@3]) {
                [_listInfo addObject:model];
            }
        }
        [_tabeleView reloadData];
        _listInfo = array;

    }else if (i == 3){
        for (OrderModel *model in array) {
            
            if ([model.order_status isEqualToNumber:@4]) {
                [_listInfo addObject:model];
            }
        }
        [_tabeleView reloadData];
        _listInfo = array;

    }
    
    
}

- (void)backToMain:(UIButton *)button{
    NSLog( @"返回主页");
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    self.tabBarController.selectedIndex = 0;
    
}

#pragma mark - UITableViewDataSource\UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _listInfo.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderCell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.model = _listInfo[indexPath.section];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}










@end
