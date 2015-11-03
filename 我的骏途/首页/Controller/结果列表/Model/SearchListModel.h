//
//  SearchListModel.h
//  我的骏途
//
//  Created by mac on 15/10/15.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import "BaseModel.h"

@interface SearchListModel : BaseModel
/*
 {
 "id" : "1957",
 "thumb" : "http:\/\/image.juntu.com\/uploadfile\/2015\/1010\/20151010113216261.jpg",
 "description" : "西安成团含全陪",
 "is_self_drive" : "N",//自驾游
 "juntu_price" : "1980",
 "coupon_status" : "N",//优惠券
 "minus" : 0, //立减吧？
 "title" : "【爸妈游】<广深珠、港澳、厦门、鼓浪屿双卧11日游>",
 "is_train" : "N",
 "group_type" : "group", //是否跟团
 "offered_nature" : "2"
 }
 
 market_price
 */

@property(nonatomic,copy)NSString *myId;//id
@property(nonatomic,copy)NSString *thumb;//图片
@property(nonatomic,copy)NSString *myDescription;//描述
@property(nonatomic,copy)NSString *is_self_drive;//自驾游YN
@property(nonatomic,copy)NSString *juntu_price;//价格
@property(nonatomic,copy)NSString *market_price;//市场价
@property(nonatomic,copy)NSString *coupon_status;//优惠券
@property(nonatomic,copy)NSString *minus;//立减
@property(nonatomic,copy)NSString *title;//标题
@property(nonatomic,copy)NSString *is_train;//直通车
@property(nonatomic,copy)NSString *group_type;//组团类型
@property(nonatomic,copy)NSString *max_price;//最高价格（酒店使用）
@property(nonatomic,copy)NSString *min_price;//最低价格（酒店使用）
@property(nonatomic,copy)NSString *map;//地图位置 109.013076|33.999559|18
@property(nonatomic,copy)NSString *position;//地址信息
@property(nonatomic,copy)NSString *offered_nature;//自然提供难道是
@property(nonatomic,copy)NSString *sub_title;//也是描述（在首页按钮进入）

-(NSDictionary *)attributeMapDictionary:(NSDictionary *)jsonDic;
@end
