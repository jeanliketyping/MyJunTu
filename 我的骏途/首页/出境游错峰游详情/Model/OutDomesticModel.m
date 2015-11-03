//
//  OutDomesticModel.m
//  我的骏途
//
//  Created by mac on 15/10/19.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import "OutDomesticModel.h"

@implementation OutDomesticModel

-(NSDictionary *)attributeMapDictionary:(NSDictionary *)jsonDic {
    NSMutableDictionary *mapDic = [NSMutableDictionary dictionary];
    
    for (id key in jsonDic) {
        [mapDic setObject:key forKey:key];
    }
    // 添加 key 和 model中属性名的映射关系
    [mapDic setObject:@"myId" forKey:@"id"];
    [mapDic setObject:@"myDescription" forKey:@"description"];
    return mapDic;
}

@end
