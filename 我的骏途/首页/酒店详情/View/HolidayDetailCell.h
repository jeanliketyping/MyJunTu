//
//  HolidayDetailCell.h
//  我的骏途
//
//  Created by mac on 15/10/24.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoomListModel.h"

@interface HolidayDetailCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *thumbImageView;
@property (strong, nonatomic) IBOutlet UILabel *room_nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *bed_type_breadfast;
@property (strong, nonatomic) IBOutlet UILabel *juntu_price;
@property (strong, nonatomic) IBOutlet UILabel *market_price;
@property (strong, nonatomic) IBOutlet UILabel *open_buyLabel;

@property(nonatomic,strong)RoomListModel *model;
@end
