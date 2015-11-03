//
//  ListTableViewCell.h
//  我的骏途
//
//  Created by mac on 15/10/15.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchListModel.h"

@interface ListTableViewCell : UITableViewCell
/*
 {
 "id" : "1957",
 "thumb" : "http:\/\/image.juntu.com\/uploadfile\/2015\/1010\/20151010113216261.jpg",
 "description" : "西安成团含全陪",
 "is_self_drive" : "N",//自驾游
 "juntu_price" : "1980",
 "coupon_status" : "N",//优惠券
 "title" : "【爸妈游】<广深珠、港澳、厦门、鼓浪屿双卧11日游>",
 "is_train" : "N",
 "group_type" : "group", //是否跟团
 "offered_nature" : "2"
 }
 */
@property (strong, nonatomic) IBOutlet UIImageView *bigImageView;
@property (strong, nonatomic) IBOutlet UIImageView *typeImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *discountLabel;
@property (strong, nonatomic) IBOutlet UILabel *markPrice;
@property (strong, nonatomic) IBOutlet UILabel *junTuPrice;


@property (nonatomic, strong) SearchListModel *model;


@end
