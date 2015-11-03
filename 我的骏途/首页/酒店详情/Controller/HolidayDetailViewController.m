//
//  HolidayDetailViewController.m
//  我的骏途
//
//  Created by mac on 15/10/23.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import "HolidayDetailViewController.h"
#import "HolidayDetailCell.h"
#import "MyNetWorkQuery.h"
#import "RoomListModel.h"
#import "RegexKitLite.h"
#import "MapViewController.h"

@interface HolidayDetailViewController ()

@end

@implementation HolidayDetailViewController{
    UITableView *_tableView;
    NSMutableArray *_roomArray;
    NSDictionary *_holidayDic;
    NSString *_arriveDate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"酒店详情";
    [self _createTableView];
}

-(void)setHotelId:(NSString *)hotelId {
    
    [self showProgress];
    if (_hotelId != hotelId) {
        _hotelId = hotelId;
        
        //获取今天的日期
        NSDate *date = [NSDate date];
        NSString *dateS = [NSString stringWithFormat:@"%@",date];
        //读取年月日
        NSString *regx= @"\\b\\d{4}-\\d{2}-\\d{2}\\b";
        NSArray *array = [dateS componentsMatchedByRegex:regx];
        _arriveDate = array[0];
        //请求数据
        NSString *urlString = [NSString stringWithFormat:@"http://www.juntu.com/index.php?m=app&c=hotel_rec&a=hotel_show&hotelid=%@&todate=%@",_hotelId,_arriveDate];
        NSLog(@"%@",urlString);
        [MyNetWorkQuery requestData:urlString HTTPMethod:@"GET" params:nil completionHandle:^(id result) {
            //读取头部视图数据
            NSArray *hotelShow = result[@"hotelShow"];
            _holidayDic = [hotelShow lastObject];
            _roomArray  = [NSMutableArray array];
            NSArray *roomList = _holidayDic[@"roomlist"];
            for (NSDictionary *dic in roomList) {
                RoomListModel *roomModel = [[RoomListModel alloc] initContentWithDic:dic];
                if (![roomModel.juntu_price isEqualToString:@"0"]) {
                    [_roomArray addObject:roomModel];
                }
            }
            //回到主线程
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView reloadData];
                [self hidProgress];
            });
        } errorHandle:^(NSError *error) {
            NSLog(@"出错了");
        }];
    }
}

//创建tableView
-(void)_createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    //注册单元格
    UINib *nib = [UINib nibWithNibName:@"HolidayDetailCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"HolidayDetailCell"];
    
}

#pragma mark - UITableView 代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 3){
        return _roomArray.count;
    }else{
        return 0;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 3){
        return 90;
    }else{
        return 0;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 150;
    }else {
    return 30;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 2) {
        return 10;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HolidayDetailCell *detailCell = [tableView dequeueReusableCellWithIdentifier:@"HolidayDetailCell" forIndexPath:indexPath];
    if (indexPath.section == 3) {
        detailCell.model = _roomArray[indexPath.row];
        return detailCell;
    }else {
        return nil;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    view.backgroundColor = [UIColor whiteColor];
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-15, 10, 8, 10)];
    image.image = [UIImage imageNamed:@"arrow2x"];
    [view addSubview:image];
    
    //第一组
    if (section == 0) {
         UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:headView.bounds];
        //图片
        NSArray *imageArray = _holidayDic[@"images"];
        NSDictionary *dic = imageArray[0];
        [imageView sd_setImageWithURL:[NSURL URLWithString:dic[@"url"]] placeholderImage:[UIImage imageNamed:@"300.jpg"]];
        [headView addSubview:imageView];
        
        //显示张数背景
        UIImageView *countImage = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 30, 80, 30, 25)];
        countImage.image = [UIImage imageNamed:@"weiba2x.png"];
        UILabel *countLabel = [[UILabel alloc] initWithFrame:countImage.bounds];
        countLabel.textColor = [UIColor whiteColor];
        countLabel.font = [UIFont systemFontOfSize:12];
        countLabel.text = [NSString stringWithFormat:@"%li张 ",imageArray.count];
        countLabel.textAlignment = NSTextAlignmentRight;
        [countImage addSubview:countLabel];
        [headView addSubview:countImage];
        
        //显示名称
        UILabel *titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, headView.size.height - 30, kScreenWidth, 30)];
        titlelabel.text = _holidayDic[@"title"];
        titlelabel.backgroundColor = [UIColor colorWithWhite:0 alpha:.4];
        titlelabel.textColor = [UIColor whiteColor];
        titlelabel.font = [UIFont systemFontOfSize:13];
        [headView addSubview:titlelabel];
        return headView;
        
    }else if (section == 1) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 8, 10, 15)];
        //weizhi12x.png
        imageView.image = [UIImage imageNamed:@"weizhi12x.png"];
        [view addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 280, 20)];
        label.text = _holidayDic[@"position"];
        label.font = [UIFont systemFontOfSize:13];
        [view addSubview:label];
        
        //跳转到地图界面
        UIButton *button = [[UIButton alloc] initWithFrame:view.bounds];
        button.backgroundColor = [UIColor clearColor];
        [button addTarget:self action:@selector(runToMap) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        return view;
        
    }else if (section == 2){
        //xingcheng12x.png
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 8, 10, 15)];
        //weizhi12x.png
        imageView.image = [UIImage imageNamed:@"xingcheng12x.png"];
        [view addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 280, 20)];
        label.text = @"酒店简介";
        label.font = [UIFont systemFontOfSize:15];
        [view addSubview:label];
        
        UIButton *button = [[UIButton alloc] initWithFrame:view.bounds];
        button.backgroundColor = [UIColor clearColor];
        [button addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        return  view;
        
    }else if (section == 3){
        UILabel *enterInLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 30, 20)];
        enterInLabel.text = @"入住";
        enterInLabel.font = [UIFont systemFontOfSize:15];
        
        UILabel *enterTime = [[UILabel alloc] initWithFrame:CGRectMake(38, 5, 100, 20)];
        enterTime.textColor = [UIColor colorWithRed:54/255.0 green:183/255.0 blue:200/255.0 alpha:1];
        enterTime.text = _arriveDate;
        enterTime.font = [UIFont systemFontOfSize:14];
        
        UILabel *outLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2-20, 5, 30, 20)];
        outLabel.text=  @"离店";
        outLabel.font = [UIFont systemFontOfSize:15];
        
        UILabel *outTime = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2 + 15, 5, 100, 20)];
        outTime.textColor = [UIColor colorWithRed:54/255.0 green:183/255.0 blue:200/255.0 alpha:1];
        outTime.text = _arriveDate;
        outTime.font = [UIFont systemFontOfSize:14];
        
        UILabel *changeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-50, 5, 30, 20)];
        changeLabel.textColor = [UIColor colorWithRed:54/255.0 green:183/255.0 blue:200/255.0 alpha:1];
        changeLabel.text = @"修改";
        changeLabel.font = [UIFont systemFontOfSize:15];
        
        [view addSubview:enterInLabel];
        [view addSubview:enterTime];
        [view addSubview:outLabel];
        [view addSubview:outTime];
        [view addSubview:changeLabel];
        return view;
    }else{
        return nil;
    }
}

-(void)clickButton{
    NSLog(@"酒店简介");
}
-(void)runToMap{
    MapViewController *mapView = [[MapViewController alloc] init];
    mapView.placeName = _holidayDic[@"position"];
    mapView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:mapView animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
