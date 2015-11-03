//
//  ScreenToursViewController.m
//  我的骏途
//
//  Created by mac on 15/10/22.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import "ScreenToursViewController.h"
#import "MySearchBar.h"
#import "BaseListTableView.h"
#import "MyNetWorkQuery.h"

@interface ScreenToursViewController ()

@end

@implementation ScreenToursViewController{
    NSMutableArray *_showArray;//初始页面数组
    NSMutableArray *_searchArray;//搜索结果数组
    BaseListTableView *_tableView;//tableView
    UIView *_headView;//头视图
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置标题
    self.title = _titleL;
    [self _createHeadView];
    [self _createTableView];
    [self _createSearchBar];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//创建搜索栏
-(void)_createSearchBar {
    MySearchBar *searchBar = [[MySearchBar alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 30) placeholder:_placeholder];
    searchBar.urlString = _searchString;
    searchBar.type = _searchlistType;
    [self.view addSubview:searchBar];
    
    //搜索数据
    [searchBar setBlock:^(NSString *text,NSArray *array){
        NSLog(@"数据:%@",array);
        if (array == nil) {
            return;
        }else{
            _searchArray = [NSMutableArray array];
            for (NSDictionary *dic in array) {
                [_searchArray addObject:dic];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                _tableView.type = _showType;
                _tableView.dataArray = _searchArray;
            });
        }
    }];
}

//复写setUrlString
-(void)setUrlString:(NSString *)urlString {
    
    if (_urlString != urlString) {
        _urlString = urlString;
        
        [MyNetWorkQuery requestData:_urlString HTTPMethod:@"GET" params:nil completionHandle:^(id result) {
            NSArray *array = result[_listType];
//            NSLog(@"%@",array);
            _showArray =[NSMutableArray array];
            for (NSDictionary *dic in array) {
                [_showArray addObject:dic];
            }
            
            //回到主程序赋值
            dispatch_async(dispatch_get_main_queue(), ^{
                _tableView.dataArray = _showArray;
                _tableView.type = self.showType;
                
            });
        } errorHandle:^(NSError *error) {
            NSLog(@"error:%@",error);
        }];
    }
}

-(void)_createHeadView {
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:_headView.bounds];
    //推送
    //出境游
    //http://www.juntu.com/index.php?m=app&c=route_rec&a=get_foreign_pic
    //景区
    //http://www.juntu.com/index.php?m=app&c=scenic_rec&a=get_scenic_pic
    //国内游
    //http://www.juntu.com/index.php?m=app&c=route_rec&a=get_inland_pic

    NSString *urlStirng;
    if ([self.title isEqualToString:@"景点"]) {
        urlStirng = @"http://image.juntu.com/uploadfile/2015/0818/20150818111611116.jpg";
    }else if ([self.title isEqualToString:@"出境游"]){
        urlStirng = @"http://image.juntu.com/uploadfile/2015/0624/20150624040604914.jpg";
    }else if ([self.title isEqualToString:@"国内游"]){
        urlStirng = @"http://image.juntu.com/uploadfile/2015/0624/20150624024642670.jpg";
    }
    [imageView sd_setImageWithURL:[NSURL URLWithString:urlStirng] placeholderImage:[UIImage imageNamed:@"lunbotu.png"]];
    [_headView addSubview:imageView];
    
    if (urlStirng == nil) {
        [_headView removeFromSuperview];
    }
}

//创建表视图
-(void)_createTableView {
    _tableView = [[BaseListTableView alloc] initWithFrame:CGRectMake(0, 30, kScreenWidth, kScreenHeight+10) style:UITableViewStylePlain];
    _tableView.tableHeaderView = _headView;
    [self.view addSubview:_tableView];
}


@end
