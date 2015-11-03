//
//  SearchListModel.m
//  我的骏途
//
//  Created by mac on 15/10/15.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import "SearchListModel.h"

@implementation SearchListModel

-(NSDictionary *)attributeMapDictionary:(NSDictionary *)jsonDic {
    NSMutableDictionary *mapDoic = [NSMutableDictionary dictionary];
    for (id key in jsonDic) {
        [mapDoic setObject:key forKey:key];
    }
    [mapDoic setObject:@"myId" forKey:@"id"];
    [mapDoic setObject:@"myDescription" forKey:@"description"];
    return mapDoic;
}

@end
