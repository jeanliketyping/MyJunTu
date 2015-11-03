//
//  SceneAndHotelTableView.h
//  我的骏途
//
//  Created by mac on 15/10/24.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SceneAndHotelModel.h"

@interface SceneAndHotelTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)SceneAndHotelModel *model;

@end
