//
//  SearchListViewController.m
//  我的骏途
//
//  Created by mac on 15/10/15.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import "SearchListViewController.h"
#import "ListTableViewCell.h"
#import "BaseListTableView.h"
#import "MyNetWorkQuery.h"
#import "SiftType.h"
#import "SelectedView.h"

@interface SearchListViewController (){
    BaseListTableView *_tableView;
    NSString *_siftType;
}
@end

@implementation SearchListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _searchTitle;
    [self _createTableView];
    [self _createSelectedView];
}

-(void)_createTableView {
    _tableView = [[BaseListTableView alloc] initWithFrame:CGRectMake(0, 40, kScreenWidth, kScreenHeight-40) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
}

//创建筛选视图
-(void)_createSelectedView {
    siftType *sift = [[siftType alloc] init];
    sift.type = _tableView.type;
    NSArray *titleArray = [sift gettitle:_tableView.type];
    NSArray *dataArray = [sift getData:_tableView.type];
    SelectedView *selectView = [[SelectedView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 40) titles:titleArray data:dataArray];
    [self.view addSubview:selectView];
}


-(void)setDictionary:(NSMutableDictionary *)dictionary {
    
    [self showProgress];
    
    NSArray *typeArray = @[@"scenic",@"around",@"inland",@"foreign",@"hotel",@"scenic_hotel"];
    NSArray *urlArray = @[kScenic,kAround,kInland,KForeign,KHotel,KScenicHotel];
    
    for (int i = 0; i < 6; i ++) {
        if ([dictionary[@"type"] isEqualToString:typeArray[i]]) {
            NSString *selectedString = urlArray[i];
            NSString *urlString = [selectedString stringByAppendingString:_searchTitle];
            
            [MyNetWorkQuery requestData:urlString HTTPMethod:@"GET" params:nil completionHandle:^(id result) {
                
                //destList-->scenic
                //toursList-->around\inland\foreign
                //hotelList-->hotel
                //info-->scenic_hotel
                //回到主线程
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSArray *array = [[NSArray alloc] init];
                    if (i == 0) {
                        array = result[@"destList"];
                        _tableView.type = @"destShow";
                        _siftType = @"风景";
                    }else if (i == 4){
                        array = result[@"hotelList"];
                        _tableView.type = @"hotelShow";
                        _siftType = @"酒店";
                    }else if (i == 5){
                        array = result[@"info"];
                        _tableView.type = @"info";
                        _siftType = @"景+酒";
                    }else{
                        array = result[@"toursList"];
                        _tableView.type = @"toursShow";
                        _siftType = @"游";
                    }
                    _tableView.dataArray = array;
                    
                    [self hidProgress];
                });
                
            } errorHandle:^(NSError *error) {
                NSLog(@"失败%@",error);
            }];
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
