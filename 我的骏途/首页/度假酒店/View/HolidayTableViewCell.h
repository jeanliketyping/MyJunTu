//
//  HolidayTableViewCell.h
//  我的骏途
//
//  Created by mac on 15/10/23.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchListModel.h"

@interface HolidayTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *thumbImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *positionLabel;
@property (strong, nonatomic) IBOutlet UILabel *juntu_priceLabel;
@property (strong, nonatomic) IBOutlet UILabel *market_priceLabel;
@property (strong, nonatomic) IBOutlet UILabel *mapLabel;

@property(nonatomic,strong)SearchListModel *model;
@end
