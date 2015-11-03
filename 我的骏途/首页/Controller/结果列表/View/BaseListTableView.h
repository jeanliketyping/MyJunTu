//
//  BaseListTableView.h
//  我的骏途
//
//  Created by mac on 15/10/22.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseListTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,copy)NSString *type;
@property(nonatomic,strong)NSArray *dataArray;
@end
