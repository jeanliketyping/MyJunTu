//
//  SceneAndHotelModel.m
//  我的骏途
//
//  Created by mac on 15/10/24.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import "SceneAndHotelModel.h"

@implementation SceneAndHotelModel

-(NSDictionary *)attributeMapDictionary:(NSDictionary *)jsonDic {
    
    NSMutableDictionary *mapDic = [NSMutableDictionary dictionary];
    for (id key in jsonDic) {
        [mapDic setObject:key forKey:key];
    }
    [mapDic setObject:@"sceneAndHotelId" forKey:@"id"];
    
    return mapDic;
}

@end
