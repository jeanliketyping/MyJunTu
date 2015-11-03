//
//  OutDomesticModel.h
//  我的骏途
//
//  Created by mac on 15/10/19.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import "BaseModel.h"

@interface OutDomesticModel : BaseModel
/*
 {
 "toursShow": [
 {
 "id": "1217",
 "title": "<曼谷、芭堤雅完美6日游>",
 "description": "西安直飞曼谷，全程0自费，仅3站购物，观皇宫、游湄南、骑大象、赏人妖、享按摩",
 "is_self_drive": "N",
 "is_train": "N",
 "juntu_price": "2099.00",
 "production_no": "3484201",
 "market_price": "5000",
 "is_sales_by_package": "N",
 "package_explain": "",
 "setup_city": "西安",
 "spend_time": "6",
 "least_buy_quantity": "1",
 "most_buy_quantity": "9",
 "minus_amount": "0",
 "offered_nature": "1",
 "features": "★西安直飞：一站直达，无需中转\n★品质保证：全程保证0自费，仅3站购物\n★特别安排：继《泰囧》之后又一力作喜剧电影《唐人街探案》--拍摄地，运气好的话，可能会看到王宝强，刘昊然，佟丽娅，陈赫，小沈阳等明星\n★一价全含：落地签（200元）+导服服务费（300元）+保证夫妻一间房",
 "travel_date": "2015-10-23",
 "baby_price": "1899.00",
 "images": [
 {
 "url": "http://image.juntu.com/uploadfile/2015/1012/20151012120850732.jpg",
 "alt": "封面1"
 },
 {
 "url": "http://image.juntu.com/uploadfile/2015/1012/20151012121443587.jpg",
 "alt": "曼谷唐人街"
 },
 {
 "url": "http://image.juntu.com/uploadfile/2015/1012/20151012121444861.jpg",
 "alt": "曼谷唐人街1"
 },
 {
 "url": "http://image.juntu.com/uploadfile/2015/1012/20151012121445236.jpg",
 "alt": "曼谷唐人街2"
 }
 ],
 "group_type": "group",
 "tours_type": "3",
 "is_deal": "2"
 }
 ]
 }
 */

/*
 景点:destShow
 */


@property(nonatomic,copy)NSString *myId;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *myDescription;
@property(nonatomic,copy)NSString *is_self_drive;//自驾游YN
@property(nonatomic,copy)NSString *is_train;//直通车YN
@property(nonatomic,copy)NSString *production_no;//编号
@property(nonatomic,copy)NSString *juntu_price;//骏途价格
@property(nonatomic,copy)NSString *market_price;//市场价
@property(nonatomic,copy)NSString *baby_price;//儿童价
@property(nonatomic,copy)NSString *is_sales_by_package;//YN
@property(nonatomic,copy)NSString *package_explain;
@property(nonatomic,copy)NSString *setup_city;//出发地
@property(nonatomic,copy)NSString *spend_time;//花费的时间
@property(nonatomic,copy)NSString *least_buy_quantity;
@property(nonatomic,copy)NSString *most_buy_quantity;
@property(nonatomic,copy)NSString *minus_amount;
@property(nonatomic,copy)NSString *offered_nature;
@property(nonatomic,copy)NSString *features;//线路特色
@property(nonatomic,copy)NSString *travel_date;//旅行时间
@property(nonatomic,copy)NSString *group_type;
@property(nonatomic,copy)NSString *tours_type;
@property(nonatomic,copy)NSString *is_deal;
@property(nonatomic,strong)NSArray *images;//展示图


@end
