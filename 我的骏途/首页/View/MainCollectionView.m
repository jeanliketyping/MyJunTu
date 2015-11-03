//
//  MainCollectionView.m
//  骏途旅游
//
//  Created by 俞烨梁 on 15/10/7.
//  Copyright (c) 2015年 俞烨梁. All rights reserved.
//

#import "MainCollectionView.h"
#import "ScreenToursViewController.h"
#import "UIView+UIViewController.h"
#import "ViewController.h"
#import "WebViewController.h"
#import "HolidayHotelViewController.h"
#import "BaseNavigationController.h"

@implementation MainCollectionView

- (instancetype)initWithFrame:(CGRect)frame
                       titles:(NSArray *)titles
                    imageData:(NSArray *)imageData
                   imageNames:(NSArray *)imageNames{
    
    _titles = titles;
    _imageNames = imageNames;
    _imageData = imageData;
    
    //布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];

    //单元格size
    layout.itemSize = CGSizeMake(43, 43);
    //垂直间距
    layout.minimumLineSpacing = 30;
    //水平间距
    layout.minimumInteritemSpacing = 20;
    //四周间距
    layout.sectionInset = UIEdgeInsetsMake(10, 15, 20, 15);
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.showsHorizontalScrollIndicator = NO;
    }
    
    //注册
    [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:cell.frame];
    
    //载入图片
    [imageView sd_setImageWithURL:_imageData[indexPath.row] placeholderImage:[UIImage imageNamed:_imageNames[indexPath.row]]];
    
    cell.backgroundView = imageView;
    
    //添加label
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(-5, 28, 50, 50)];
    label.text = _titles[indexPath.row];
    [label setTextAlignment:NSTextAlignmentCenter];
    label.font = [UIFont systemFontOfSize:10];
    
    [cell addSubview:label];

    return cell;
}

//选中单元格事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger index = indexPath.item;
    NSLog(@"%li",index);
    //景区、出境游、国内游
    //3个URL数据
    NSArray *urlArray = @[kScenicRecommend,kRouteReForeign,kRouteReInland];
    NSArray *searchArray = @[kScenic,kAround,kInland];
    //3个字典key
    NSArray *listType = @[@"destList",@"list",@"list"];
    NSArray *showType = @[@"destShow",@"toursShow",@"toursShow"];
    NSArray *searchListType = @[@"destList",@"toursList",@"toursList"];
    if (index < 3) {
        ScreenToursViewController *screenVC = [[ScreenToursViewController alloc] init];
        if (index == 0) {
            screenVC.titleL = @"景点";
            screenVC.placeholder = @"搜索景点名称";
        }if (index > 0 && index < 3) {
            screenVC.placeholder = @"搜索线路名称/目的地";
            if (index == 1) {
                screenVC.titleL = @"出境游";
            }else{
                screenVC.titleL = @"国内游";
            }
        }
        
        screenVC.urlString = urlArray[index];
        screenVC.searchString = searchArray[index];
        screenVC.listType = listType[index];
        screenVC.searchlistType = searchListType[index];
        screenVC.showType = showType[index];
        screenVC.hidesBottomBarWhenPushed = YES;
        [self.viewController.navigationController pushViewController:screenVC animated:YES];
    }
    
    //周边游、景加酒
    else if (index == 4 || index == 6) {
        ViewController *view = [[ViewController alloc] init];
        if (index == 4) {
            view.showType = @"toursShow";
        }else if(index == 6){
            view.showType = @"info";
        }
        view.hidesBottomBarWhenPushed = YES;
        [self.viewController.navigationController pushViewController:view animated:YES];
    }
    else if (index == 3 || index == 7) {
        
        WebViewController *webView = [[WebViewController alloc] init];
        if (index == 3) {
            //天天特价
            webView.urlString = @"http://s.juntu.com/index.php?m=mobile&c=index&a=seckill_list&type=3";
            webView.showTitle = @"天天特价";
        }else{
            //自驾游
            webView.urlString = @"http://s.juntu.com/index.php?m=mobile&c=index&a=drive_lists&type=3";
            webView.showTitle = @"自驾游";
        }
        BaseNavigationController *webNav = [[BaseNavigationController alloc] initWithRootViewController:webView];
        [self.viewController.navigationController presentViewController:webNav animated:YES completion:nil];
    }
    
    //度假酒店
    else if (index == 5) {
        HolidayHotelViewController *holiday = [[HolidayHotelViewController alloc] init];
        holiday.hidesBottomBarWhenPushed = YES;
        [self.viewController.navigationController pushViewController:holiday animated:YES];
    }
}




@end
