//
//  BaseModel.m
//  WXMovie
//
//  Created by wei.chen on 13-9-3.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

- (id)initContentWithDic:(NSDictionary *)jsonDic {
    self = [super init];
    if (self != nil) {
        [self setAttributes:jsonDic];
    }
    
    return self;
}

- (void)setAttributes:(NSDictionary *)jsonDic {
    
    /*
     key:  json字典的key名
     value: model对象的属性名
     */
    //mapDic： 属性名与json字典的key 的映射关系
    NSDictionary *mapDic = [self attributeMapDictionary:jsonDic];
    
    for (NSString *jsonKey in mapDic) {
        
        //modelAttr:"newsId"
        //jsonKey : "id" 
        NSString *modelAttr = [mapDic objectForKey:jsonKey];
        SEL seletor = [self stringToSel:modelAttr];
        
        //判断self 是否有seletor 方法
        if ([self respondsToSelector:seletor]) {
            //json字典中的value
            id value = [jsonDic objectForKey:jsonKey];
            
            if ([value isKindOfClass:[NSNull class]]) {
                value = @"";
            }
            
            //调用属性的设置器方法，参数是json的value
            [self performSelector:seletor withObject:value];
        }
        
    }
}

/*
  SEL 类型的创建方式有两种，例如：setNewsId: 的SEL类型
  1.第一种
   SEL selector = @selector(setNewsId:)
  2.第二种
   SEL selector = NSSelectorFromString(@"setNewsId:");
 */

//将属性名转成SEL类型的set方法
//newsId  --> setNewsId:
- (SEL)stringToSel:(NSString *)attName {
    //截取收字母
    NSString *first = [[attName substringToIndex:1] uppercaseString];
    NSString *end = [attName substringFromIndex:1];
    
    NSString *setMethod = [NSString stringWithFormat:@"set%@%@:",first,end];
    
    //将字符串转成SEL类型
    return NSSelectorFromString(setMethod);
}

/*
  属性名与json字典中key的映射关系
    key:  json字典的key名
    value: model对象的属性名
 */
- (NSDictionary *)attributeMapDictionary:(NSDictionary *)jsonDic {
    
    NSMutableDictionary *mapDic = [NSMutableDictionary dictionary];
    
    for (id key in jsonDic) {
        [mapDic setObject:key forKey:key];
    }
    
    return mapDic;
}

@end
