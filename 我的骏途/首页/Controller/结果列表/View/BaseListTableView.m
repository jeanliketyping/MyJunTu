//
//  BaseListTableView.m
//  我的骏途
//
//  Created by mac on 15/10/22.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import "BaseListTableView.h"
#import "ListTableViewCell.h"
#import "OutDomesticViewController.h"
#import "UIView+UIViewController.h"
#import "ScenicSpotDetailViewController.h"
#import "SceneAndHotelViewController.h"

@implementation BaseListTableView{
    NSMutableArray *_listArray;
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self _initTable];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)_initTable{
    self.delegate = self;
    self.dataSource = self;
    //注册单元格
    UINib *nib = [UINib nibWithNibName:@"ListTableViewCell" bundle:nil];
    [self registerNib:nib forCellReuseIdentifier:@"ListTableViewCell"];
}

-(void)setDataArray:(NSArray *)dataArray {
    
    if (_dataArray != dataArray) {
        _dataArray = dataArray;
        
        _listArray = [[NSMutableArray alloc] init];
        //存入数据
        for (NSDictionary *dic in _dataArray) {
            SearchListModel *searchModel = [[SearchListModel alloc] initContentWithDic:dic];
            if (searchModel.juntu_price == nil) {
                searchModel.juntu_price = searchModel.min_price;
            }if (searchModel.market_price == nil) {
                searchModel.market_price = searchModel.max_price;
            }if (searchModel.myDescription == nil) {
                searchModel.myDescription = searchModel.sub_title;
            }
            [_listArray addObject:searchModel];
        }
        [self reloadData];
    }
}

#pragma mark - UITableView 代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _listArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListTableViewCell" forIndexPath:indexPath];
    cell.model = _listArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
//行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}
//组头高
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.type isEqualToString:@"toursShow"]) {
        //如果是toursShow 调用出境、周边游、国内游详情界面
        OutDomesticViewController *outDo = [[OutDomesticViewController alloc] init];
        SearchListModel *model = _listArray[indexPath.row];
        outDo.idStr = model.myId;
        outDo.hidesBottomBarWhenPushed = YES;
        [self.viewController.navigationController pushViewController:outDo animated:YES];
    }
    //如果是destShow-->景区详情界面
    if ([self.type isEqualToString:@"destShow"]) {
        ScenicSpotDetailViewController *scenicVC = [[ScenicSpotDetailViewController alloc] init];
        SearchListModel *model = _listArray[indexPath.row];
        scenicVC.scenicSpotId = model.myId;
        scenicVC.hidesBottomBarWhenPushed = YES;
        [self.viewController.navigationController pushViewController:scenicVC animated:YES];
    }
    //如果是info-->景加酒详情界面
    if ([self.type isEqualToString:@"info"]) {
        SceneAndHotelViewController *sceneVC = [[SceneAndHotelViewController alloc] init];
        SearchListModel *model = _listArray[indexPath.row];
        sceneVC.sceneAndHotelId = model.myId;
        sceneVC.hidesBottomBarWhenPushed = YES;
        [self.viewController.navigationController pushViewController:sceneVC animated:YES];
    }
}

@end
