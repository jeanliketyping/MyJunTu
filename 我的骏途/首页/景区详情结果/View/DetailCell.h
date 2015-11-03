//
//  DetailCell.h
//  我的骏途
//
//  Created by mac on 15/10/20.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;  //景点名称

@property (strong, nonatomic) IBOutlet UILabel *junTuPriceLabel;  //骏途价格

@property (strong, nonatomic) IBOutlet UILabel *marketPriceLabel;  //市场价格

@property (strong, nonatomic) IBOutlet UIImageView *orderImageView;  //订购背景视图

@property (strong, nonatomic) IBOutlet UILabel *buyWayLabel;  //付款方式


@property (strong, nonatomic) IBOutlet UIButton *buyMsgButton;  //购买须知按钮


@end
