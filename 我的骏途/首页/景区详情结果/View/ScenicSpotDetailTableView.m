//
//  ScenicSpotDetailTableView.m
//  我的骏途
//
//  Created by mac on 15/10/18.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import "ScenicSpotDetailTableView.h"
#import "ScenicSpotDetailModel.h"
#import <CoreText/CoreText.h>
#import "UIImageView+WebCache.h"
#import "DetailCell.h"

#import "UIView+UIViewController.h"
#import "MapViewController.h"
#import "WebViewController.h"
#import "BaseNavigationController.h"
@implementation ScenicSpotDetailTableView {
    
    UIImageView *_topImageView; //头部图片视图
    UILabel *_titleLabel; //头部标题
    UILabel *_countLabel; //图片数量显示
    UILabel *_specialLabel; //景区特色详情
    NSString *_scenicId; //景区id
    NSString *_position; //景区位置
    NSMutableArray *_showList; //以门票为例有多少种类的门票
    NSMutableArray *_showTypeNames;  //组头类型名称，例如秒杀、门票等
    NSMutableArray *_iconImages;  //组头图片
    
    
    BOOL _isTouch[6]; //被点击的状态，默认为no
}

//重写set方法，在model改变的时候 更新界面
- (void)setModel:(ScenicSpotDetailModel *)model{
    
    if (_model != model) {
        _model = model;
        
        //读取头部图片
        NSDictionary *imageDic = _model.images[0];
        NSString *imageURLStr = imageDic[@"url"];
        NSURL *imageURL = [NSURL URLWithString:imageURLStr];
        [_topImageView sd_setImageWithURL:imageURL];
        //读取头部标题
        _titleLabel.text = _model.title;
        //读取头部图片的数量
        NSInteger count = _model.images.count;
        _countLabel.text = [NSString stringWithFormat:@"%ld张",count];
        //获取景区id
        _scenicId = _model.scenicId;
        //读取位置信息
        _position = _model.position;
        
        NSArray *show = _model.show;
        NSArray *showImage = @[@"miaosha@2x.png",@"ticket@2x.png",@"maizeng@2x.png",@"taocan@2x.png",@"jingjiajiu@2x.png",@"taocan@2x.png"];
        //循环读取秒杀、门票等不定数据
        for (int i = 0;i < show.count;i ++) {
            NSDictionary *dic = show[i];
            NSArray *lists = dic[@"lists"];
            if (lists.count != 0) {
                [_showList addObject:dic[@"lists"]];
                [_showTypeNames addObject:dic[@"type_name"]];
                [_iconImages addObject:showImage[i]];
            }
        }
        //更新界面
        [self reloadData];
    }
    
}

//初始化方法
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.dataSource = self;
        self.delegate = self;
        //注册一个单元格
        UINib *nib = [UINib nibWithNibName:@"DetailCell" bundle:nil];
        [self registerNib:nib forCellReuseIdentifier:@"DetailCell"];
        //初始化数组
        _showList = [NSMutableArray array];
        _showTypeNames = [NSMutableArray array];
        _iconImages = [NSMutableArray array];
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
    //标题
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 130, kScreenWidth, 20)];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    [_topImageView addSubview:_titleLabel];
    //图片数量显示视图
    UIImageView *countImage = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 40, 80, 40, 25)];
    countImage.image = [UIImage imageNamed:@"weiba2x.png"];
    [_topImageView addSubview:countImage];
    _countLabel = [[UILabel alloc] initWithFrame:countImage.bounds];
    _countLabel.textColor = [UIColor whiteColor];
    _countLabel.textAlignment = NSTextAlignmentCenter;
    _countLabel.font = [UIFont systemFontOfSize:10];
    _countLabel.text = @"张";
    [countImage addSubview:_countLabel];
    //设置表视图的头部视图
    self.tableHeaderView = _topImageView;
}



#pragma mark - UITableViewDataSource\UITableViewDelegate
//组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1 + _showTypeNames.count + 4;
}

//每组的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else if (section > _showTypeNames.count){
        return 0;
    }else{
        if (_showList.count != 0) {
            
            if (_isTouch[section]) {
                
                return 0;
            }
            
            return [_showList[section - 1] count];
            
            
        }
        return 0;
    }
}

//设置每组的单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    
    //在数据读取的情况下
    if (_showList.count != 0) {
        
        if (indexPath.section != 0 && indexPath.section <= _showTypeNames.count) {
            
            NSArray *list = _showList[indexPath.section - 1];
            NSDictionary *dic = list[indexPath.row];
            
            if ([_showTypeNames[indexPath.section - 1] isEqualToString:@"秒杀"]) {
                
                cell.nameLabel.text = dic[@"seckill_name"];
                cell.junTuPriceLabel.text = [NSString stringWithFormat:@"¥%@",dic[@"seckill_price"]];
                cell.marketPriceLabel.text = [NSString stringWithFormat:@"¥%@",dic[@"market_price"]];
                
                cell.orderImageView.image = [UIImage imageNamed:@"order-btn-disabled.png"];
                cell.buyWayLabel.text = @"尚未开始";
                cell.buyWayLabel.textColor = [UIColor grayColor];
            }
            else if ([_showTypeNames[indexPath.section - 1] isEqualToString:@"门票"]) {
                
                cell.nameLabel.text = dic[@"ticket_name"];
                cell.junTuPriceLabel.text = [NSString stringWithFormat:@"¥%@",dic[@"juntu_price"]];
                cell.marketPriceLabel.text = [NSString stringWithFormat:@"¥%@",dic[@"market_price"]];
                cell.orderImageView.image = [UIImage imageNamed:@"order-btn.png"];
                cell.buyWayLabel.text = @"在线支付";
            }
            else if ([_showTypeNames[indexPath.section - 1] isEqualToString:@"优惠活动"]){
                
                cell.nameLabel.text = dic[@"seckill_name"];
                cell.junTuPriceLabel.text = [NSString stringWithFormat:@"¥%@",dic[@"seckill_price"]];
                cell.marketPriceLabel.text = [NSString stringWithFormat:@"¥%@",dic[@"market_price"]];
                
                cell.orderImageView.image = [UIImage imageNamed:@"order-btn.png"];
                cell.buyWayLabel.text = @"在线支付";
                
            }
            else if ([_showTypeNames[indexPath.section - 1] isEqualToString:@"精选套餐"]){
                
                cell.nameLabel.text = dic[@"package_ticket_name"];
                cell.junTuPriceLabel.text = [NSString stringWithFormat:@"¥%@",dic[@"juntu_price"]];
                cell.marketPriceLabel.text = [NSString stringWithFormat:@"¥%@",dic[@"market_price"]];
                
                cell.orderImageView.image = [UIImage imageNamed:@"order-btn.png"];
                cell.buyWayLabel.text = @"在线支付";
                
            }
            else{
                cell.nameLabel.text = dic[@"seckill_name"];
                cell.junTuPriceLabel.text = [NSString stringWithFormat:@"¥%@",dic[@"juntu_price"]];
                cell.marketPriceLabel.text = [NSString stringWithFormat:@"¥%@",dic[@"market_price"]];
                
                cell.orderImageView.image = [UIImage imageNamed:@"order-btn.png"];
                cell.buyWayLabel.text = @"在线支付";
            }
            
            //设置市场价格的删除线
            NSString *str = cell.marketPriceLabel.text;
            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
            [attrStr addAttribute:NSStrikethroughStyleAttributeName value:@10 range:[str rangeOfString:str]];
            cell.marketPriceLabel.attributedText = attrStr;
        }
    }
    
    return cell;
}

//设置每组的头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    //组头总视图
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    bgView.backgroundColor = [UIColor whiteColor];
    //组头图片视图
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 15, 15, 15)];
    [bgView addSubview:iconImageView];
    //组头标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 12, 250, 20)];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:15];
    [bgView addSubview:titleLabel];
    //标记视图
    UIImageView *indicatorView = [[UIImageView alloc] init];
    [bgView addSubview:indicatorView];
    //给组头添加一个button，覆盖整个组头
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, kScreenWidth, 44);
    button.backgroundColor = [UIColor clearColor];
    [button addTarget:self action:@selector(webmapAction:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:button];
    
    if (section == 0) {
        iconImageView.image = [UIImage imageNamed:@"location.png"];
        titleLabel.text = _position;
        indicatorView.frame = CGRectMake(kScreenWidth - 27, 17, 7, 10);
        indicatorView.image = [UIImage imageNamed:@"arrow2x.png"];
        button.tag = 1100;
    }else if (section <= _showTypeNames.count){
        if (section != 0) {
            iconImageView.image = [UIImage imageNamed:_iconImages[section-1]];
            titleLabel.text = _showTypeNames[section-1];
            indicatorView.frame = CGRectMake(kScreenWidth - 30, 18, 10, 7);
            if (_isTouch[section]) {
                indicatorView.image = [UIImage imageNamed:@"arrow_up_expanablelistview1"];
            }else{
                indicatorView.image = [UIImage imageNamed:@"arrow_down_expanablelistview1.png"];
            }
            
            button.tag = 700+section;
            [button addTarget:self action:@selector(upDownAction:) forControlEvents:UIControlEventTouchUpInside];
        }
    }else if (section == _showTypeNames.count+1){
        iconImageView.image = [UIImage imageNamed:@"tese.png"];
        titleLabel.text = @"景区特色";
        
    }else if (section == _showTypeNames.count+2){
        
        _specialLabel = [[UILabel alloc] init];
        //设置自动换行
        _specialLabel.numberOfLines = 0;
        _specialLabel.textColor = [UIColor darkGrayColor];
        _specialLabel.font = [UIFont systemFontOfSize:13];
        _specialLabel.text = _model.dest_highlight;
        //根据字符串的长度 计算label的大小
        CGSize maxSize = CGSizeMake(kScreenWidth, CGFLOAT_MAX);
        NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:15]};
        CGRect rect = [_specialLabel.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        _specialLabel.frame = CGRectMake(10, 0, kScreenWidth-20, rect.size.height);
        [bgView addSubview:_specialLabel];
        
    }else if (section == _showTypeNames.count+3){
        iconImageView.image = [UIImage imageNamed:@"xuzhi.png"];
        titleLabel.text = @"预定须知";
        indicatorView.frame = CGRectMake(kScreenWidth - 27, 17, 7, 10);
        indicatorView.image = [UIImage imageNamed:@"arrow2x.png"];
        button.tag = 1101;
    }else if (section == _showTypeNames.count+4){
        iconImageView.image = [UIImage imageNamed:@"detail.png"];
        titleLabel.text = @"景区详情";
        indicatorView.frame = CGRectMake(kScreenWidth - 27, 17, 7, 10);
        indicatorView.image = [UIImage imageNamed:@"arrow2x.png"];
        button.tag = 1102;
    }
    return bgView;
}

//设置每组的头部视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == _showTypeNames.count + 2) {
        //介绍内容
        NSString *string = _model.dest_highlight;
        //根据字符串的长度 计算label的大小
        CGSize maxSize = CGSizeMake(kScreenWidth, CGFLOAT_MAX);
        NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:15]};
        CGRect rect = [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        
        _specialLabel.height = rect.size.height;
        return rect.size.height;
    }
    return 44;
}
//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section != 0 && indexPath.section <= _showTypeNames.count) {
        return 100;
    }
    return 44;
}
//设置尾视图的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }else if (section == _showTypeNames.count){
        return 10;
    }else if (section == _showTypeNames.count + 2){
        return 10;
    }else if (section == _showTypeNames.count + 4){
        return 10;
    }else{
        return 2;
    }
}

#pragma mark - 表头视图按钮的方法，将表视图收起
- (void)upDownAction:(UIButton *)button{
    NSLog(@"收起表视图");
    NSInteger section = button.tag - 700;
    _isTouch[section] = !_isTouch[section];
    NSIndexSet  *set = [NSIndexSet indexSetWithIndex:section];
    [self reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
    
}

- (void)webmapAction:(UIButton *)button{
    
    if (button.tag == 1100) {
        NSLog( @"跳转到地图页面");
        
        MapViewController *mapVC = [[MapViewController alloc] init];
        mapVC.placeName = _position;
        mapVC.hidesBottomBarWhenPushed = YES;
        [self.viewController.navigationController pushViewController:mapVC animated:YES];
        
    }else if (button.tag == 1101){
        NSLog(@"预定须知");
        WebViewController *webVC = [[WebViewController alloc] init];
        webVC.showTitle = @"预定须知";
        webVC.urlString = [NSString stringWithFormat:@"http://s.juntu.com/index.php?m=mobile&c=dest&a=should_know&id=%@&client_type=3",_scenicId];
        webVC.hidesBottomBarWhenPushed = YES;
        BaseNavigationController *webNav = [[BaseNavigationController alloc] initWithRootViewController:webVC];
        [self.viewController.navigationController presentViewController:webNav animated:YES completion:nil];
        
    }else if (button.tag == 1102){
        NSLog(@"景区详情");
        WebViewController *webVC = [[WebViewController alloc] init];
        webVC.showTitle = @"景区详情";
        webVC.urlString = [NSString stringWithFormat:@"http://s.juntu.com/index.php?m=mobile&c=dest&a=show_detail&id=%@&client_type=3",_scenicId];
        webVC.hidesBottomBarWhenPushed = YES;
        BaseNavigationController *webNav = [[BaseNavigationController alloc] initWithRootViewController:webVC];
        [self.viewController.navigationController presentViewController:webNav animated:YES completion:nil];
    }
}




@end
