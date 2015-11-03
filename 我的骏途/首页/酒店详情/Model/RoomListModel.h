//
//  RoomListModel.h
//  我的骏途
//
//  Created by mac on 15/10/24.
//  Copyright (c) 2015年 wendan. All rights reserved.
//


/*
 "roomlist": [
 {
 "fund": "不含",
 "bed_width": "1.2",
 "breakfast": "双早",
 "broadband": "免费",
 "floor": "2-6层",
 "in_number": "2",
 "media_tech": "国内长途电话",
 "bed_type": "双床",
 "is_extra_bed": "可以",
 "no_smoking": "是",
 "id": "964",
 "hotelid": "314",
 "room_name": "标准间",
 "hotel_special_price": "418.00",
 "minus_amount": "0",
 "least_buy_quantity": "1",
 "most_buy_quantity": "9",
 "market_price": "518",
 "juntu_price": "418.00",
 "thumb": "http://image.juntu.com/uploadfile/2015/0910/20150910102104172.jpg",
 "quantity": "9",
 "open_buy": "Y",
 "status": "show",
 "coupon_status": "N",
 "coupon_code_status": "N"
 }
 ]
 */
#import "BaseModel.h"
@interface RoomListModel : BaseModel

@property(nonatomic,copy)NSString *fund;
@property(nonatomic,copy)NSString *bed_width;
@property(nonatomic,copy)NSString *breakfast;//早饭
@property(nonatomic,copy)NSString *broadband;
@property(nonatomic,copy)NSString *floor;
@property(nonatomic,copy)NSString *in_number;
@property(nonatomic,copy)NSString *media_tech;
@property(nonatomic,copy)NSString *bed_type;//床类型
@property(nonatomic,copy)NSString *is_extra_bed;
@property(nonatomic,copy)NSString *no_smoking;
@property(nonatomic,copy)NSString *myId;//房间id
@property(nonatomic,copy)NSString *hotelid;//酒店id
@property(nonatomic,copy)NSString *room_name;//房间名
@property(nonatomic,copy)NSString *hotel_special_price;
@property(nonatomic,copy)NSString *minus_amount;
@property(nonatomic,copy)NSString *least_buy_quantity;
@property(nonatomic,copy)NSString *market_price;//市场价
@property(nonatomic,copy)NSString *juntu_price;//骏途价
@property(nonatomic,copy)NSString *thumb;//图片
@property(nonatomic,copy)NSString *quantity;
@property(nonatomic,copy)NSString *open_buy;
@property(nonatomic,copy)NSString *status;
@property(nonatomic,copy)NSString *coupon_status;
@property(nonatomic,copy)NSString *coupon_code_status;
@end
