//
//  ViewController.m
//  周边游
//
//  Created by 俞烨梁 on 15/10/22.
//  Copyright (c) 2015年 俞烨梁. All rights reserved.
//

#import "ViewController.h"
#import "SelectedView.h"
#import "MySearchBar.h"
#import "BaseListTableView.h"
#import "MyNetWorkQuery.h"
#import "RequestJSON.h"
#import "SiftType.h"
#import "ShareButton.h"

@interface ViewController ()
{
    NSArray *_data;
    BaseListTableView *_tableView;
    NSArray *_selectedArray;
    NSMutableArray *_selectedMutableArray;
    NSArray *_titles;
    NSString *_url;
    NSString *_searchUrl;
    NSString *_key;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([_showType isEqualToString:@"toursShow"]) {
        self.title = @"周边游";
        //周边
        _url = kRouteTourstype;
        _searchUrl = KForeign;
        _key =@"toursList";
    }else if ([_showType isEqualToString:@"info"]){
        self.title = @"景+酒";
        //景加酒
        _url = kScenicHotelLists;
        _searchUrl = KScenicHotel;
        _key =@"info";
    }
    [self createTableView];
    [self createSearchBar];
    [self createSelectedView];
    [self loadData];
    
    [self createShareButton];
}

- (void)createShareButton{
    ShareButton *shareButton = [[ShareButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc]initWithCustomView:shareButton];
    
    self.navigationItem.rightBarButtonItem = shareItem;
}

- (void)loadData{

    [MyNetWorkQuery requestData:_url HTTPMethod:@"GET" params:nil completionHandle:^(id result) {
        NSArray *toursList = [result objectForKey:_key];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            _tableView.dataArray = toursList;
            _tableView.type = _showType;
        });
        
    } errorHandle:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];
}


//选择视图
- (void)createSelectedView{

    NSArray *titleArray;
    NSArray *dataArray;
    siftType *sift = [[siftType alloc] init];
    if ([_showType isEqualToString:@"toursShow"]){
        sift.type = @"周边游";
        titleArray = [sift gettitle:@"周边游"];
        dataArray = [sift getData:@"周边游"];
    }else if ([_showType isEqualToString:@"info"]){
        sift.type = @"景+酒";
        titleArray = [sift gettitle:@"景+酒"];
        dataArray = [sift getData:@"景+酒"];
    }
    SelectedView *selectedView = [[SelectedView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 40) titles:titleArray data:dataArray];
    [self.view addSubview:selectedView];
}

- (void)createSearchBar{
    MySearchBar *searchBar = [[MySearchBar alloc]initWithFrame:CGRectMake(0, 104, kScreenWidth, 30) placeholder:@"输入景区/目的地"];
    searchBar.urlString = _searchUrl;
    searchBar.type = _key;
    
    //搜索数据
    [searchBar setBlock:^(NSString *text,NSArray *array){
        NSLog(@"数据:%@",array);
        if (array == nil) {
            return;
        }else{
            NSMutableArray *searchArray = [NSMutableArray array];
            for (NSDictionary *dic in array) {
                [searchArray addObject:dic];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                _tableView.type = _showType;
                _tableView.dataArray = searchArray;
            });
        }
    }];
    [self.view addSubview:searchBar];
}

//创建表视图
- (void)createTableView{
    _tableView = [[BaseListTableView alloc]initWithFrame:CGRectMake(0, 70, kScreenWidth, kScreenHeight-26) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
