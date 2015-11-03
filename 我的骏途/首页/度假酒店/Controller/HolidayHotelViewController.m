//
//  HolidayHotelViewController.m
//  我的骏途
//
//  Created by mac on 15/10/22.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import "HolidayHotelViewController.h"
#import "HotelSelectViewController.h"
#import "HolidayListViewController.h"

@interface HolidayHotelViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    
    UITableView *_tableView;
    //遮罩视图
    UIView *_maskView;
    //城市
    UILabel *_cityLabel;
    //入住日期
    UILabel *_getInDataLabel;
    UILabel *_getInWeedDayLabel;
    //居住时长
    UILabel *_stayDayLabel;
    //离店日期
    UILabel *_getOutDataLabel;
    UILabel *_getOutWeedDayLabel;
    //关键字文本
    UITextField *_keyTextF;
    //价格星级
    UILabel *_priceLevelLabel;
    //星级／价格选择视图
    UIView *_selectView;
    //可移动的选择滑块
    UIView *_priceSelectedView;
    UIView *_levelSelectedView;
    //可移动的选择滑块上的label
    UILabel *_priceSelectedLabel;
    UILabel *_levelSelectedLabel;
    //价格、星级选项
    UILabel *_priceItemLabel;
    UILabel *_levelItemLabel;
    
    //城市id
    NSString *_cityId;
    //酒店星级
    NSString *_level;
    //酒店最低价
    NSString *_minPrice;
    //酒店最高价
    NSString *_maxPrice;
    
}
@end

@implementation HolidayHotelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"酒店";
    _cityId = @"";
    //创建视图
    [self createViews];
    
}

//创建视图
- (void)createViews{
    //创建一个表视图
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 300) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    //注册一个单元格
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    //创建遮罩视图
    _maskView = [[UIView alloc] initWithFrame:_tableView.bounds];
    _maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    _maskView.hidden = YES;
    [_tableView addSubview:_maskView];
    
    //创建一个星级价格选择视图
    _selectView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 320)];
    _selectView.backgroundColor = [UIColor whiteColor];
    
    //价格label
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 50, 20)];
    priceLabel.text = @"价格";
    priceLabel.font = [UIFont systemFontOfSize:15];
    priceLabel.textColor = [UIColor darkGrayColor];
    [_selectView addSubview:priceLabel];
    NSArray *priceArray = @[@"不限",@"¥150以下",@"¥150-¥300",@"¥300-¥600",@"¥600以上"];
    //星级label
    UILabel *levelLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20+125, 50, 20)];
    levelLabel.text = @"星级";
    levelLabel.font = [UIFont systemFontOfSize:15];
    levelLabel.textColor = [UIColor darkGrayColor];
    [_selectView addSubview:levelLabel];
    NSArray *levelArray = @[@"不限",@"二星级以下",@"三星级",@"四星级",@"五星级"];
    
    //循环创建价格、星级选项
    for (int i = 0; i < 5; i ++) {
        //选项按钮
        UIButton *priceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i/3 == 0) {
            priceButton.frame = CGRectMake((i%3)*kScreenWidth/3+10, 50, kScreenWidth/3 - 20, 30);
        }else{
            priceButton.frame = CGRectMake((i%3)*kScreenWidth/3+10, 50+45, kScreenWidth/3 - 20, 30);
        }
        //按钮上的label
        _priceItemLabel = [[UILabel alloc] init];
        _priceItemLabel.backgroundColor = [UIColor yellowColor];
        _priceItemLabel.font = [UIFont systemFontOfSize:14];
        _priceItemLabel.textColor = [UIColor blackColor];
        _priceItemLabel.textAlignment = NSTextAlignmentCenter;
        _priceItemLabel.frame = priceButton.bounds;
        _priceItemLabel.text = priceArray[i];
        _priceItemLabel.tag = 900+i;
        [priceButton addSubview:_priceItemLabel];
        [priceButton addTarget:self action:@selector(selectedAction:) forControlEvents:UIControlEventTouchUpInside];
        priceButton.tag = 700+i;
        [_selectView addSubview:priceButton];
        //选项按钮
        UIButton *levelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i/3 == 0) {
            levelButton.frame = CGRectMake((i%3)*kScreenWidth/3+10, 50+125, kScreenWidth/3 - 20, 30);
        }else{
            levelButton.frame = CGRectMake((i%3)*kScreenWidth/3+10, 50+45+125, kScreenWidth/3 - 20, 30);
        }
        //按钮上的label
        _levelItemLabel = [[UILabel alloc] init];
        _levelItemLabel.backgroundColor = [UIColor yellowColor];
        _levelItemLabel.font = [UIFont systemFontOfSize:14];
        _levelItemLabel.textColor = [UIColor blackColor];
        _levelItemLabel.textAlignment = NSTextAlignmentCenter;
        _levelItemLabel.frame = levelButton.bounds;
        _levelItemLabel.text = levelArray[i];
        _levelItemLabel.tag = 1000+i;
        [levelButton addSubview:_levelItemLabel];
        
        [levelButton addTarget:self action:@selector(selectedAction:) forControlEvents:UIControlEventTouchUpInside];
        levelButton.tag = 800+i;
        [_selectView addSubview:levelButton];
    }
    //确定按钮
    UIButton *checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    checkButton.frame = CGRectMake(10, 270, kScreenWidth - 20, 30);
    [checkButton setBackgroundImage:[UIImage imageNamed:@"1136_menu_img_xiayibu1"] forState:UIControlStateNormal];
    [checkButton addTarget:self action:@selector(checkAction:) forControlEvents:UIControlEventTouchUpInside];
    [_selectView addSubview:checkButton];
    //查询标签
    UILabel *checkLabel = [[UILabel alloc] initWithFrame:checkButton.bounds];
    checkLabel.text = @"查询";
    checkLabel.textAlignment = NSTextAlignmentCenter;
    checkLabel.textColor = [UIColor whiteColor];
    checkLabel.font = [UIFont systemFontOfSize:15];
    [checkButton addSubview:checkLabel];
    
    //默认价格选择
    _priceSelectedView = [[UIView alloc] initWithFrame:CGRectMake(10, 50, kScreenWidth/3-20, 30)];
    _priceSelectedView.backgroundColor = [UIColor colorWithRed:53/255.0 green:168/255.0 blue:184/255.0 alpha:1];
    _priceSelectedLabel = [[UILabel alloc] initWithFrame:_priceSelectedView.bounds];
    _priceSelectedLabel.text = @"不限";
    _priceSelectedLabel.textColor = [UIColor whiteColor];
    _priceSelectedLabel.textAlignment = NSTextAlignmentCenter;
    _priceSelectedLabel.font = [UIFont systemFontOfSize:14];
    [_priceSelectedView addSubview:_priceSelectedLabel];
    [_selectView addSubview:_priceSelectedView];
    //默认星级选择
    _levelSelectedView = [[UIView alloc] initWithFrame:CGRectMake(10, 50+125, kScreenWidth/3-20, 30)];
    _levelSelectedView.backgroundColor = [UIColor colorWithRed:53/255.0 green:168/255.0 blue:184/255.0 alpha:1];
    _levelSelectedLabel = [[UILabel alloc] initWithFrame:_priceSelectedView.bounds];
    _levelSelectedLabel.text = @"不限";
    _levelSelectedLabel.textColor = [UIColor whiteColor];
    _levelSelectedLabel.textAlignment = NSTextAlignmentCenter;
    _levelSelectedLabel.font = [UIFont systemFontOfSize:14];
    [_levelSelectedView addSubview:_levelSelectedLabel];
    [_selectView addSubview:_levelSelectedView];
    
    [self.view addSubview:_selectView];
    
}

#pragma mark - UITableViewDataSource
//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        //左侧label
        UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 12, 60, 20)];
        leftLabel.text = @"目的地";
        leftLabel.textColor = [UIColor lightGrayColor];
        leftLabel.font = [UIFont systemFontOfSize:15];
        [cell.contentView addSubview:leftLabel];
        //选择城市显示label
        _cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 100, 12, 60, 20)];
        _cityLabel.text = @"城市";
        _cityLabel.textColor = [UIColor colorWithRed:53/255.0 green:168/255.0 blue:184/255.0 alpha:1];
        _cityLabel.font = [UIFont systemFontOfSize:15];
        _cityLabel.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:_cityLabel];
        //添加标记
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }else if (indexPath.row == 1){
        //入住label
        UILabel *getInLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 40, 20)];
        getInLabel.text = @"入住";
        getInLabel.textColor = [UIColor lightGrayColor];
        getInLabel.font = [UIFont systemFontOfSize:12];
        [cell.contentView addSubview:getInLabel];
        //入住日期label
        _getInDataLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 25, 70, 20)];
        _getInDataLabel.text = @"10月22";
        _getInDataLabel.font = [UIFont systemFontOfSize:16];
        [cell.contentView addSubview:_getInDataLabel];
        
        _getInWeedDayLabel= [[UILabel alloc] initWithFrame:CGRectMake(85, 25, 30, 20)];
        _getInWeedDayLabel.text = @"周四";
        _getInWeedDayLabel.textColor = [UIColor lightGrayColor];
        _getInWeedDayLabel.font = [UIFont systemFontOfSize:13];
        [cell.contentView addSubview:_getInWeedDayLabel];
        //添加标记
        UIImageView *indicatorLeftView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2- 40, 30, 7, 11)];
        indicatorLeftView.image = [UIImage imageNamed:@"arrow2x"];
        [cell.contentView addSubview:indicatorLeftView];
        
        //给左侧罩一个按钮
        UIButton *getInButton = [UIButton buttonWithType:UIButtonTypeCustom];
        getInButton.frame = CGRectMake(0, 0, kScreenWidth/2 - 20, 44);
        getInButton.backgroundColor  = [UIColor clearColor];
        [getInButton addTarget:self action:@selector(getInDataSelect:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:getInButton];
        
        CGFloat add = kScreenWidth/2;
        //入住label
        UILabel *getOutLabel = [[UILabel alloc] initWithFrame:CGRectMake(15+add+20, 5, 40, 20)];
        getOutLabel.text = @"离店";
        getOutLabel.textColor = [UIColor lightGrayColor];
        getOutLabel.font = [UIFont systemFontOfSize:13];
        [cell.contentView addSubview:getOutLabel];
        //入住日期label
        _getOutDataLabel = [[UILabel alloc] initWithFrame:CGRectMake(15+add+20, 25, 70, 20)];
        _getOutDataLabel.text = @"10月23";
        _getOutDataLabel.font = [UIFont systemFontOfSize:16];
        [cell.contentView addSubview:_getOutDataLabel];
        
        _getOutWeedDayLabel= [[UILabel alloc] initWithFrame:CGRectMake(90+add+20, 25, 30, 20)];
        _getOutWeedDayLabel.text = @"周五";
        _getOutWeedDayLabel.textColor = [UIColor lightGrayColor];
        _getOutWeedDayLabel.font = [UIFont systemFontOfSize:13];
        [cell.contentView addSubview:_getOutWeedDayLabel];
        //添加标记
        UIImageView *indicatorRightView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2- 20+add, 30, 7, 11)];
        indicatorRightView.image = [UIImage imageNamed:@"arrow2x"];
        [cell.contentView addSubview:indicatorRightView];
        
        UIButton *getOutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        getOutButton.frame = CGRectMake(kScreenWidth/2+20, 0, kScreenWidth/2 - 20, 44);
        getOutButton.backgroundColor  = [UIColor clearColor];
        [getOutButton addTarget:self action:@selector(getOutDataSelect:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:getOutButton];
        
        //中间的圆圈
        UIImageView *roundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 20, 4, 40, 40)];
        roundImageView.image = [UIImage imageNamed:@"weixuan_2x"];
        [cell.contentView addSubview:roundImageView];
        //入住时长
        _stayDayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 40, 20)];
        _stayDayLabel.textAlignment = NSTextAlignmentCenter;
        _stayDayLabel.text = @"1";
        [roundImageView addSubview:_stayDayLabel];
        
    }else if (indexPath.row == 2){
        //关键词文本
        _keyTextF = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth - 10, 44)];
        _keyTextF.placeholder = @"关键字、位置、品牌、酒店名";
        [cell.contentView addSubview:_keyTextF];
        
    }else if (indexPath.row == 3){
        //星级价格label
        _priceLevelLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth - 100, 44)];
        _priceLevelLabel.text = @"星级/价格";
        _priceLevelLabel.textColor = [UIColor lightGrayColor];
        _priceLevelLabel.font = [UIFont systemFontOfSize:16];
        [cell.contentView addSubview:_priceLevelLabel];
        //添加标记
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }else{
        //查询按钮
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10, 15, kScreenWidth - 20, 30)];
        [button setBackgroundImage:[UIImage imageNamed:@"1136_menu_img_xiayibu1"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(enquireAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:button];
        //查询标签
        UILabel *label = [[UILabel alloc] initWithFrame:button.bounds];
        label.text = @"查询";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:15];
        [button addSubview:label];
        
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 4) {
        return 70;
    }
    return 44;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        
        NSLog(@"城市选择");
        HotelSelectViewController *hotelSelect = [[HotelSelectViewController alloc] init];
        
        //参数回传的方法
        [hotelSelect setBlock:^(NSDictionary *dic){
            
            _cityId = dic[@"cityid"];
            _cityLabel.text = dic[@"city"];
            NSMutableDictionary *reDic = [NSMutableDictionary dictionary];
            [reDic setObject:_cityId forKey:@"cityid"];
            [reDic setObject:_cityLabel.text forKey:@"city"];
            return reDic;
            
        }];
        //隐藏标签栏
        hotelSelect.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:hotelSelect animated:YES];
    }
    else if (indexPath.row == 3){
        
        NSLog( @"星级价格选择");
        [UIView animateWithDuration:0.4 animations:^{
            _selectView.transform = CGAffineTransformMakeTranslation(0, -320);
            _maskView.hidden = NO;
        }];
        
    }
    
    
}

- (void)getInDataSelect:(UIButton *)button{
    
    NSLog(@"入住日期选择");
}

- (void)getOutDataSelect:(UIButton *)button{
    NSLog(@"离店日期选择");
}

#pragma mark - 查询
- (void)enquireAction:(UIButton *)button{
    
    //http://www.juntu.com/index.php?m=app&c=hotel_rec&a=hotel&city=610100&level=&min_price=300&max_price=600&keyword=%E5%B8%83%E4%B8%81
    //城市id           ok
    //星级
    //最低价、最高价
    //关键字
    
    NSLog(@"城市id:%@,星级:%@,最低价:%@,最高价:%@,关键字:%@",_cityId,_level,_minPrice,_maxPrice,_keyTextF.text);
    
    NSString *urlString = [NSString stringWithFormat:@"http://www.juntu.com/index.php?m=app&c=hotel_rec&a=hotel&city=%@&level=%@&min_price=%@&max_price=%@&keyword=%@",_cityId,_level,_minPrice,_maxPrice,_keyTextF.text];
    
    HolidayListViewController *holidayList = [[HolidayListViewController alloc] init];
    holidayList.urlString = urlString;
    holidayList.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:holidayList animated:YES];
    
    
}

- (void)selectedAction:(UIButton *)button{
    
    NSLog(@"选择价格、星级");
    
    NSInteger index = button.tag;
    
    if (index >= 700 && index < 800) {
        //价格选择视图的移动
        _priceSelectedView.transform = CGAffineTransformMakeTranslation(button.left - 10, button.top - 50);
        UILabel *label = (UILabel *)[self.view viewWithTag:index+200];
        _priceSelectedLabel.text = label.text;
        if (button.tag == 700) {
            _minPrice = @"";
            _maxPrice = @"";
        }else if (button.tag == 701){
            _minPrice = @"0";
            _maxPrice = @"150";
        }else if (button.tag == 702){
            _minPrice = @"150";
            _maxPrice = @"300";
        }else if (button.tag == 703){
            _minPrice = @"300";
            _maxPrice = @"600";
        }else if (button.tag == 704){
            _minPrice = @"600";
            _maxPrice = @"9900";
        }
    }else if (index >= 800){
        //星级选择视图的移动
        _levelSelectedView.transform = CGAffineTransformMakeTranslation(button.left - 10, button.top - 50-125);
        UILabel *label = (UILabel *)[self.view viewWithTag:index+200];
        _levelSelectedLabel.text = label.text;
        if (button.tag == 800) {
            _level = @"";
        }else if (button.tag == 801){
            _level = @"2";
        }else if (button.tag == 802){
            _level = @"3";
        }else if (button.tag == 803){
            _level = @"4";
        }else if (button.tag == 804){
            _level = @"5";
        }
    }
    
}

- (void)checkAction:(UIButton *)button{
    
    NSLog(@"星级、价格选择完成");
    _priceLevelLabel.text = [NSString stringWithFormat:@"%@、%@",_priceSelectedLabel.text,_levelSelectedLabel.text];
    _priceLevelLabel.textColor = [UIColor blackColor];
    //显示价格星级选项视图
    [UIView animateWithDuration:0.4 animations:^{
        _selectView.transform = CGAffineTransformIdentity;
        _maskView.hidden = YES;
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
