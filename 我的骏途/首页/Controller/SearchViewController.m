//
//  SearchViewController.m
//  我的骏途
//
//  Created by mac on 15/10/6.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import "SearchViewController.h"
#import "MySearchBar.h"
#import "SearchListViewController.h"
#import "MyNetWorkQuery.h"

@interface SearchViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_searchArray;
    NSString *_text;
    UITableView *_tableView;
}
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _createTableView];
    [self _createSearchBar];
    
}

-(void)_createSearchBar {
    MySearchBar *searchBar = [[MySearchBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth-50, 40) placeholder:@"搜索目的地、景点、酒店等"];
    searchBar.urlString = kSearch;
    self.navigationItem.titleView = searchBar;
    
    [searchBar setBlock:^(NSString *text,NSArray *array){
        _searchArray = [NSMutableArray array];
        _text = text;
        for (NSDictionary *dic in array) {
            if (![dic[@"num"] isEqualToString:@"0"]) {
                [_searchArray addObject:dic];
            }
        }
        if (_searchArray.count == 0) {
            NSLog(@"没有数据");
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
    }];
}

-(void)_createTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"searchCell"];
    [self.view addSubview:_tableView];
}

//组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([_text isEqualToString:@""]) {
        return 0;
    }else{
    return _searchArray.count;
    }
}

//组头高
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier=@"searchCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];

    NSDictionary *dic = _searchArray[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@相关的%@%@项",_text,dic[@"name"],dic[@"num"]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%li",indexPath.row);
    NSDictionary *dic = _searchArray[indexPath.row];
    SearchListViewController *listVc = [[SearchListViewController alloc] init];
    listVc.searchTitle = _text;
    listVc.dictionary = dic;
    listVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:listVc animated:YES];
}
@end
