//
//  HolidayListViewController.m
//  我的骏途
//
//  Created by mac on 15/10/23.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import "HolidayListViewController.h"
#import "HolidayTableViewCell.h"
#import "SelectedView.h"
#import "MyNetWorkQuery.h"
#import "SearchListModel.h"
#import "HolidayDetailViewController.h"
#import "siftType.h"

@interface HolidayListViewController ()

@end

@implementation HolidayListViewController{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"酒店";
    [self _createTableView];
    [self _createSelectedView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void)setUrlString:(NSString *)urlString {
    
    [self showProgress];
    if (_urlString != urlString) {
        _urlString = urlString;
        
        [MyNetWorkQuery requestData:_urlString HTTPMethod:@"GET" params:nil completionHandle:^(id result) {
            
            NSArray *array = result[@"hotelList"];
            if (array.count == 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[[UIAlertView alloc] initWithTitle:@"提示" message:@"没有匹配内容" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
                });
            }
            _dataArray = [NSMutableArray array];
            for (NSDictionary *dic in array) {
                SearchListModel *model = [[SearchListModel alloc] initContentWithDic:dic];
                [_dataArray addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView reloadData];
                [self hidProgress];
            });
            
        } errorHandle:^(NSError *error) {
            [[[UIAlertView alloc] initWithTitle:@"提示" message:@"网络出错" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        }];
        
    }
}

//创建筛选视图
-(void)_createSelectedView {
    siftType *sift = [[siftType alloc] init];
    sift.type = @"酒店";
    NSArray *titleArray = [sift gettitle:@"酒店"];
    NSArray *dataArray = [sift getData:@"酒店"];
    SelectedView *selectView = [[SelectedView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 44) titles:titleArray data:dataArray];
    [self.view addSubview:selectView];
}

//创建tableView
-(void)_createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource =self;
    [self.view addSubview:_tableView];
    //注册单元格
    UINib *nib = [UINib nibWithNibName:@"HolidayTableViewCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"HolidayCell"];
}

#pragma mark - UITableView 代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HolidayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HolidayCell" forIndexPath:indexPath];
    cell.model = _dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchListModel *model = _dataArray[indexPath.row];
    NSString *myId = model.myId;
    
    //跳转到酒店详情界面
    HolidayDetailViewController *detailHoliday = [[HolidayDetailViewController alloc] init];
    detailHoliday.hotelId = myId;
    detailHoliday.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailHoliday animated:YES];
}
@end
