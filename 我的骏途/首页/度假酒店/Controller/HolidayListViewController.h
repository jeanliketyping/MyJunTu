//
//  HolidayListViewController.h
//  我的骏途
//
//  Created by mac on 15/10/23.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import "BaseViewController.h"

@interface HolidayListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,copy)NSString *urlString;

@end
