//
//  SceneAndHotelTableView.m
//  我的骏途
//
//  Created by mac on 15/10/24.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import "SceneAndHotelTableView.h"
#import <CoreText/CoreText.h>
#import "UIImageView+WebCache.h"
#import "WebViewController.h"
#import "BaseNavigationController.h"
#import "UIView+UIViewController.h"

@implementation SceneAndHotelTableView{
    
    UIImageView *_topImageView; //头部图片视图
    UILabel *_codeLabel; //产品编号
    UILabel *_countLabel; //图片数量显示
    NSString *_sceneAndHotelId; //景加酒id
    NSString *_sceneAndHotelTitle; //景加酒标题
    NSString *_sceneAndHotelPrice; //景加酒价格
    
    NSMutableArray *_priceArray; //套餐数组
    NSMutableArray *_priceNameArray; //套餐名称
    NSMutableArray *_minPriceArray;  //套餐价格
    NSMutableArray *_items; //套餐详情
    
    
}

//重写set方法，在model改变的时候 更新界面
- (void)setModel:(SceneAndHotelModel *)model {
    
    if (_model != model) {
        _model = model;
        
        
        //读取头部图片
        NSDictionary *imageDic = _model.images[0];
        NSString *imageURLStr = imageDic[@"url"];
        NSURL *imageURL = [NSURL URLWithString:imageURLStr];
        [_topImageView sd_setImageWithURL:imageURL];
        
        //读取头部编号
        _codeLabel.text = [NSString stringWithFormat:@"产品编号：%@",_model.code];
        
        //读取头部图片的数量
        _countLabel.text = [NSString stringWithFormat:@"%@张",_model.images_num];
        
        //获取景加酒id
        _sceneAndHotelId = _model.sceneAndHotelId;
        
        //获取景加酒标题
        _sceneAndHotelTitle = _model.title;
        
        //获取景加酒价格
        _sceneAndHotelPrice = _model.juntu_price;
        
        //套餐数组
        NSArray *price = _model.price;
        //循环读取套餐各项内容
        for (int i = 0;i < price.count;i ++) {
            NSDictionary *dic = price[i];
            if (dic.count != 0) {
                [_priceNameArray addObject:dic[@"price_name"]];
                [_minPriceArray addObject:dic[@"min_price"]];
                [_items addObject:dic[@"items"]];
            }
        }
        //更新界面
        dispatch_async(dispatch_get_main_queue(), ^{
            [self reloadData];
        });
    }
    
}


//初始化方法
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.dataSource = self;
        self.delegate = self;
        //初始化数组
        _priceNameArray = [NSMutableArray array];
        _minPriceArray = [NSMutableArray array];
        _items = [NSMutableArray array];
        //创建头视图
        [self createHeaderView];
        
    }
    return self;
}

//创建头部视图
- (void)createHeaderView{

    //图片视图
    _topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
    _topImageView.backgroundColor = [UIColor lightGrayColor];
    //编号
    _codeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 120, kScreenWidth, 30)];
    _codeLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    _codeLabel.textColor = [UIColor whiteColor];
    _codeLabel.font = [UIFont systemFontOfSize:14];
    [_topImageView addSubview:_codeLabel];
    //图片数量显示视图
    UIImageView *countImage = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 40, 0, 25, 31)];
    countImage.image = [UIImage imageNamed:@"shuliang.png"];
    [_topImageView addSubview:countImage];
    _countLabel = [[UILabel alloc] initWithFrame:countImage.bounds];
    _codeLabel.numberOfLines = 0;
    _countLabel.textColor = [UIColor whiteColor];
    _countLabel.textAlignment = NSTextAlignmentCenter;
    _countLabel.font = [UIFont systemFontOfSize:12];
    _countLabel.text = @"张";
    [countImage addSubview:_countLabel];
    //设置表视图的头部视图
    self.tableHeaderView = _topImageView;
    
}


#pragma mark - UITableViewDataSource\UITableViewDelegate
//组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2 + _priceNameArray.count;
}

//每组的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section < 2) {
        return 0;
    }else{
        return 3;
    }
}

//设置每组的单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell = nil;
    //在数据读取的情况下
    if (_items.count != 0) {
        NSArray *item = _items[indexPath.section-2];
        
        if (indexPath.section >= 2) {
            
            if (indexPath.row == 0) {

                if (cell == nil) {
                    
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
                    
                    cell.backgroundColor = [UIColor clearColor];
                    NSDictionary *dic = item[0];
                    //单元格左侧图标
                    UIImageView *iconImageView = [[UIImageView alloc] init];
                    iconImageView.frame = CGRectMake(10, 14, 20, 15);
                    iconImageView.image = [UIImage imageNamed:@"ticket12x"];
                    
                    [cell.contentView addSubview:iconImageView];
                    //单元格标题
                    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, kScreenWidth-90, 44)];
                    titleLabel.numberOfLines = 0;
                    titleLabel.font = [UIFont systemFontOfSize:13];
                    titleLabel.textColor = [UIColor darkGrayColor];
                    titleLabel.text = [NSString stringWithFormat:@"%@%@%@张",dic[@"title"],dic[@"sub_title"],dic[@"num"]];
                    [cell.contentView addSubview:titleLabel];
                    //须知
                    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                    button.frame = CGRectMake(kScreenWidth-55, 10, 40, 25);
                    [button setBackgroundImage:[UIImage imageNamed:@"xiang_qing.png"] forState:UIControlStateNormal];
                    [cell.contentView addSubview:button];
                    
                }
                
                return cell;

            }else if (indexPath.row == 1){

                if (cell == nil) {
                    
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
                    
                    cell.backgroundColor = [UIColor clearColor];
                    NSDictionary *dic = item[1];
                    
                    //单元格左侧图标
                    UIImageView *iconImageView = [[UIImageView alloc] init];
                    iconImageView.frame = CGRectMake(10, 13, 20, 18);
                    iconImageView.image = [UIImage imageNamed:@"house12x"];
                    [cell.contentView addSubview:iconImageView];
                    //单元格标题
                    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, kScreenWidth-90, 44)];
                    titleLabel.numberOfLines = 0;
                    titleLabel.font = [UIFont systemFontOfSize:13];
                    titleLabel.textColor = [UIColor darkGrayColor];
                    titleLabel.text = [NSString stringWithFormat:@"%@%@%@晚",dic[@"title"],dic[@"sub_title"],dic[@"num"]];
                    [cell.contentView addSubview:titleLabel];
                    //详情
                    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                    button.frame = CGRectMake(kScreenWidth-55, 10, 40, 25);
                    [button setBackgroundImage:[UIImage imageNamed:@"xu_zhi.png"] forState:UIControlStateNormal];
                    [cell.contentView addSubview:button];
                    
                }
                
                return cell;
               
            }else if (indexPath.row == 2){
                
                if (cell == nil) {
                    
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
                    
                    cell.backgroundColor = [UIColor clearColor];
                    cell.contentView.backgroundColor = [UIColor whiteColor];
                    
                    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
                    titleLabel.text = @"套餐价:";
                    titleLabel.textAlignment = NSTextAlignmentCenter;
                    titleLabel.font = [UIFont systemFontOfSize:15];
                    [cell.contentView addSubview:titleLabel];
                    
                    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 0, 50, 44)];
                    priceLabel.text = [NSString stringWithFormat:@"¥%@",_minPriceArray[indexPath.section-2]];
                    priceLabel.textColor = [UIColor redColor];
                    priceLabel.font = [UIFont systemFontOfSize:17];
                    [cell.contentView addSubview:priceLabel];
                    
                    UILabel *unitLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 15, 25, 20)];
                    unitLabel.textColor = [UIColor redColor];
                    unitLabel.text = @"起/份";
                    unitLabel.font = [UIFont systemFontOfSize:10];
                    [cell.contentView addSubview:unitLabel];
                    
                    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                    button.frame = CGRectMake(kScreenWidth - 80, 7, 73, 30);
                    [button setImage:[UIImage imageNamed:@"btn_yuding_1.png"] forState:UIControlStateNormal];
                    [button addTarget:self action:@selector(bookingAction:) forControlEvents:UIControlEventTouchUpInside];
                    
                    [cell.contentView addSubview:button];
                    
                }
                
                return cell;
            }
            
        }
    }
    return nil;
    
}

//设置每组的头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    //组头总视图
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    bgView.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:15];
    [bgView addSubview:titleLabel];
    
    //标记视图
    UIImageView *indicatorView = [[UIImageView alloc] init];
    [bgView addSubview:indicatorView];
    
    if (section == 0) {
        
        titleLabel.frame = CGRectMake(10, 0, kScreenWidth- 30, 40);
        titleLabel.numberOfLines = 0;
        titleLabel.text = _model.title;
        
        
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-90, 40, 50, 30)];
        priceLabel.text = [NSString stringWithFormat:@"¥%@",_sceneAndHotelPrice];
        priceLabel.textColor = [UIColor redColor];
        priceLabel.font = [UIFont systemFontOfSize:17];
        [bgView addSubview:priceLabel];
        
        UILabel *unitLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 40, 47, 25, 20)];
        unitLabel.textColor = [UIColor redColor];
        unitLabel.text = @"起/份";
        unitLabel.font = [UIFont systemFontOfSize:10];
        [bgView addSubview:unitLabel];
        
    }else if (section == 1){
        
        UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 14, 15, 15)];
        iconImageView.image = [UIImage imageNamed:@"star12x.png"];
        [bgView addSubview:iconImageView];
        
        titleLabel.frame = CGRectMake(35, 0, kScreenWidth - 70, 44);
        titleLabel.text = @"特色介绍";
        
        indicatorView.frame = CGRectMake(kScreenWidth - 27, 17, 7, 10);
        indicatorView.image = [UIImage imageNamed:@"arrow2x.png"];
        //点击跳转网页
//        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
//        button.backgroundColor = [UIColor clearColor];
//        [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
//        [bgView addSubview:button];
        
    }else{
        
        titleLabel.frame = CGRectMake(10, 0, 250, 44);
        titleLabel.text = _priceNameArray[section-2];
        
        indicatorView.frame = CGRectMake(kScreenWidth - 30, 18, 10, 7);
        indicatorView.image = [UIImage imageNamed:@"arrow_down_expanablelistview1.png"];
    }

    return bgView;
}
//
//-(void)buttonAction {
//    WebViewController *webView = [[WebViewController alloc] init];
//    webView.showTitle = @"景区详情";
//    webView.urlString = [NSString stringWithFormat:@"http://www.juntu.com/index.php?m=app&c=scenic_hotel&a=get_intro&id=47"];
//    webView.hidesBottomBarWhenPushed = YES;
//    BaseNavigationController *webNav = [[BaseNavigationController alloc] initWithRootViewController:webView];
//    webNav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//    [self.viewController.navigationController presentViewController:webNav animated:YES completion:nil];
//
//    
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 70;
    }
        
    return 44;

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section == 1) {
        return 20;
    }
    return 1;

}

- (void)bookingAction:(UIButton *)button{
    
    NSLog(@"立即预订");
}





@end
