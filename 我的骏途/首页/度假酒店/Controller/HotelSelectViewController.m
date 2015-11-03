//
//  HotelSelectViewController.m
//  我的骏途
//
//  Created by mac on 15/10/23.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import "HotelSelectViewController.h"
#import "MyNetWorkQuery.h"
#import "HolidayHotelViewController.h"

@interface HotelSelectViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    
    NSMutableArray *_cityArray;
}
@end

@implementation HotelSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"城市选择";
    _cityArray = [NSMutableArray array];
    
    [self createView];
    [self loadData];
}
//加载数据
- (void)loadData{
    
    NSString *urlStr = @"http://www.juntu.com/index.php?m=app&c=scenic_rec&a=city";
    
    //开启多线程
    [MyNetWorkQuery requestData:urlStr HTTPMethod:@"GET" params:nil completionHandle:^(id result) {
        _cityArray = result[@"cityList"];
        //更新
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
        
    } errorHandle:^(NSError *error) {
        NSLog(@"error");
    }];
    
}
//创建视图
- (void)createView{
    
    //创建表视图
    _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    //注册一个单元格
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

//组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//组头高
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1;
}

//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cityArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSDictionary *dic = _cityArray[indexPath.row];
    
    cell.textLabel.text = dic[@"city"];
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

//选择
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    _block(_cityArray[indexPath.row]);
    
    [self.navigationController popViewControllerAnimated:YES];  
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
