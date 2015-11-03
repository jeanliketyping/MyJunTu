//
//  MyOrderViewController.m
//  我的骏途
//
//  Created by mac on 15/10/8.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import "MyOrderViewController.h"
#import "OrderListViewController.h"
#import "LoginViewController.h"

@interface MyOrderViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    UITableView *_tableView;
    NSArray *_orderData;
}
@end

@implementation MyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
    self.navigationItem.leftBarButtonItem = nil;
    
    [self _createTableView];
}

- (void)_createTableView{
    
    _orderData = @[@"酒店订单",@"景区订单",@"旅游路线订单",@"景加酒订单",@"门加门订单",@"套票订单",@"体验团订单"];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 372) style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    
    [self.view addSubview:_tableView];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _orderData.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = _orderData[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    //单元格选中风格
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //单元格辅助风格
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%li",indexPath.row);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userId = [defaults objectForKey:kUserID];
    if (userId == nil) {//未登录时弹出登录提示
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"您还没有登录" message:@"请登录" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alertView.delegate = self;
        [alertView show];
        
        
    }
    else{
        
        //登录的时候进行跳转
        OrderListViewController *orderList = [[OrderListViewController alloc] init];
        orderList.hidesBottomBarWhenPushed = YES;
        orderList.orderTitle = _orderData[indexPath.row];
        if (indexPath.row == 0) {
            orderList.order_type = @"hotel";
        }else if (indexPath.row == 1){
            orderList.order_type = @"dest";
        }else if (indexPath.row == 2){
            orderList.order_type = @"tours";
        }else if (indexPath.row == 3){
            orderList.order_type = @"scenic_hotel";
        }else if (indexPath.row == 4){
            orderList.order_type = @"package_ticket";
        }else if (indexPath.row == 5){
            orderList.order_type = @"group_ticket";
        }else if (indexPath.row == 6){
            orderList.order_type = @"packet_group";
        }
        [self.navigationController pushViewController:orderList animated:YES];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
}


@end
