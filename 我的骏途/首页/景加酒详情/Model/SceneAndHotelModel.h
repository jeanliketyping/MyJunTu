//
//  SceneAndHotelModel.h
//  我的骏途
//
//  Created by mac on 15/10/24.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

/*
 {
 "id": "65",
 "title": "自选华清宫-华清池骊山2张/兵马俑往返车2位/兵马俑门票2张+西安宾馆客房1晚",
 "juntu_price": "321",
 "code": "00000038",
 "play_day": "2",
 "images": [
 {
 "url": "http://image.juntu.com/uploadfile/2015/0820/20150820060148240.jpg",
 "name": "华清池"
 },...],
 "images_num": 7,
 "price": [
 {
 "id": "103",
 "price_name": "西安宾馆1晚+华清池-骊山-兵马俑往返景区直通车2位",
 "coupon_status": "N",
 "suit_people_adult": "2",
 "least_buy_quantity": "1",
 "most_buy_quantity": "9",
 "amount": "0",
 "min_price": "321",
 "items": [
 {
 "id": "931",
 "title": "【直通秦朝 东线直通车】直通车往返",
 "sub_title": "",
 "num": "2",
 "times": "",
 "type": "1"
 },
 {
 "id": "272",
 "title": "西安宾馆",
 "sub_title": "标准间",
 "num": "1",
 "times": "1",
 "type": "2"
 }
 ]
 },
 {
 "id": "106",
 "price_name": "西安宾馆1晚+华清池-骊山-兵马俑门票各2张+往返直通车2位",
 "coupon_status": "N",
 "suit_people_adult": "2",
 "least_buy_quantity": "1",
 "most_buy_quantity": "9",
 "amount": "0",
 "min_price": "868",
 "items": [
 {
 "id": "762",
 "title": "【套票】秦始皇陵博物院 陕西旅游手绘地图珍藏版 （旺季）3.1-11.30",
 "sub_title": "",
 "num": "2",
 "times": "",
 "type": "1"
 },
 {
 "id": "931",
 "title": "【直通秦朝 东线直通车】直通车往返",
 "sub_title": "",
 "num": "2",
 "times": "",
 "type": 1
 },
 {
 "id": "982",
 "title": "华清宫（华清池 骊山）（旺季3.1-11.30）",
 "sub_title": "",
 "num": "2",
 "times": "",
 "type": 1
 },
 {
 "id": "272",
 "title": "西安宾馆",
 "sub_title": "标准间",
 "num": "1",
 "times": "1",
 "type": "2"
 }
 ]
 },
 {
 "id": "108",
 "price_name": "西安宾馆1晚+华清池-骊山-兵马俑门票各2张+赠送陕西旅游手绘地图2本",
 "coupon_status": "N",
 "suit_people_adult": "2",
 "least_buy_quantity": "1",
 "most_buy_quantity": "9",
 "amount": "0",
 "min_price": "523",
 "items": [
 {
 "id": "982",
 "title": "华清宫（华清池 骊山）（旺季3.1-11.30）",
 "sub_title": "",
 "num": "2",
 "times": "",
 "type": "1"
 },
 {
 "id": "762",
 "title": "【套票】秦始皇陵博物院 陕西旅游手绘地图珍藏版 （旺季）3.1-11.30",
 "sub_title": "",
 "num": "2",
 "times": "",
 "type": 1
 },
 {
 "id": "272",
 "title": "西安宾馆",
 "sub_title": "标准间",
 "num": "1",
 "times": "1",
 "type": "2"
 }
 ]
 }
 ]
 }
 */


#import "BaseModel.h"

@interface SceneAndHotelModel :BaseModel

@property (nonatomic,copy)NSString *sceneAndHotelId;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *code;
@property (nonatomic,strong)NSArray *images;
@property (nonatomic,copy)NSString *juntu_price;
@property (nonatomic,copy)NSString *images_num;
@property (nonatomic,strong)NSArray *price;


@end
