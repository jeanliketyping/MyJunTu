//
//  ScenicSpotDetailModel.m
//  我的骏途
//
//  Created by mac on 15/10/18.
//  Copyright (c) 2015年 wendan. All rights reserved.
//



#import "ScenicSpotDetailModel.h"

@implementation ScenicSpotDetailModel

-(NSDictionary *)attributeMapDictionary:(NSDictionary *)jsonDic {
    NSMutableDictionary *mapDoic = [NSMutableDictionary dictionary];
    for (id key in jsonDic) {
        [mapDoic setObject:key forKey:key];
    }
    [mapDoic setObject:@"scenicId" forKey:@"id"];
    return mapDoic;
}

@end
