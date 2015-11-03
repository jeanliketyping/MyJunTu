//
//  ScreenToursViewController.h
//  我的骏途
//
//  Created by mac on 15/10/22.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import "BaseViewController.h"

@interface ScreenToursViewController : BaseViewController

@property(nonatomic,copy)NSString *placeholder;//搜索栏上显示字
@property(nonatomic,copy)NSString *urlString;//列表url
@property(nonatomic,copy)NSString *searchString;//搜索url
@property(nonatomic,copy)NSString *listType;//初始列表类型
@property(nonatomic,copy)NSString *showType;//下一层要用的show类型
@property(nonatomic,copy)NSString *searchlistType;//搜索到的数据list类型
@property(nonatomic,copy)NSString *titleL;
@end
