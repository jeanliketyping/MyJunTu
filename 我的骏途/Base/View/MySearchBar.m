//
//  MySearchBar.m
//  我的骏途
//
//  Created by mac on 15/10/13.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import "MySearchBar.h"
#import "MyNetWorkQuery.h"

@implementation MySearchBar

-(instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder {
    self = [super initWithFrame:frame];
    if (self) {
        self.placeholder = placeholder;
        self.delegate = self;
    }
    return self;
}

#pragma mark - uisearchbar delegate

//点击搜索
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
//    NSLog(@"搜索内容：%@",self.text);
    //get网络资源
    [self _getSource:self.text];
    //使其上层控制器关闭键盘
    [super resignFirstResponder];
}

////内容改变
//-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
//    NSLog(@"%@",searchText);
////    [self _getSource:searchText];
//}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    //使其上层控制器关闭键盘
    [super resignFirstResponder];
}

-(void)_getSource:(NSString *)keyword {
    NSString *urlString = self.urlString;
    NSString *searchUrl = [urlString stringByAppendingString:keyword];
    [MyNetWorkQuery requestData:searchUrl HTTPMethod:@"GET" params:nil completionHandle:^(id result) {
        
        //需要对不同的进行处理
        if (_type != nil) {
            result = result[_type];
        }
        //判断是否为空
        NSArray *resultArray = result;
        if (resultArray.count == 0) {
            //回到主线程
            dispatch_async(dispatch_get_main_queue(), ^{
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有搜索结果" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            });
        }
        //回调数据
        else{
        _block(self.text,result);
        }
    } errorHandle:^(NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请检查网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }];
}
@end
