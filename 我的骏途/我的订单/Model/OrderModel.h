//
//  OrderModel.h
//  我的骏途
//
//  Created by mac on 15/10/26.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

/*
 {
 "list": [
 {
 "id": "279516",
 "order_id": "JD-FA0346202361762",
 "num": "1",
 "user_id": "46163",
 "hotel_name": "华山御温泉度假村",
 "hotel_id": "314",
 "room_id": "964",
 "room_name": "标准间",
 "travel_date": "1443801600",
 "in_date": "1443801600",
 "out_date": "1443888000",
 "create_time": "1443846202",
 "total": "458.00",
 "status_order": "Canceled",
 "status_payment": "Unpaid",
 "status_process": "Processed",
 "status_refund": "NoRefund",
 "status": "3",
 "order_type": "hotel",
 "arrival_time": "12:00",
 "room_number": "1",
 "allow_pay": "N",
 "refund": "N",
 "is_valid": "N",
 "order_status": 3,
 "order_status_name": "已取消",
 "person": "佳恩",
 "contact_name": "佳恩",
 "contact_mobile": "13758226514",
 "contact_email": "",
 "contact_tel": ""
 }
 ],
 "num": 1
 }
 */

#import "BaseModel.h"

@interface OrderModel : BaseModel

@property (nonatomic,copy) NSString *hotel_name;//订单名称(酒店)
@property (nonatomic,copy) NSString *order_name;//订单名称（景区）
@property (nonatomic,copy) NSString *product_name;//订单名称(路线)
@property (nonatomic,copy) NSString *order_id;//订单编号
@property (nonatomic,copy) NSString *create_time;//购买日期
@property (nonatomic,copy) NSString *travel_date;//入住日期/出游日期
@property (nonatomic,copy) NSString *travel_start_date;//有效期开始
@property (nonatomic,copy) NSString *to_date;//有效期截止
@property (nonatomic,copy) NSString *total;//价格
@property (nonatomic,copy) NSNumber *order_status;//订单状态对应数字
@property (nonatomic,copy) NSString *order_status_name;//订单状态名称
@property (nonatomic,copy) NSString *order_type;//订单类型




@end
