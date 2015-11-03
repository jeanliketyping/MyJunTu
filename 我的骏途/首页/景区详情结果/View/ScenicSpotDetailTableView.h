//
//  ScenicSpotDetailTableView.h
//  我的骏途
//
//  Created by mac on 15/10/18.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScenicSpotDetailModel.h"

@interface ScenicSpotDetailTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)ScenicSpotDetailModel *model;

@end
