//
//  MovieJSON.h
//  TimeMovie
//
//  Created by mac10 on 15/8/22.
//  Copyright (c) 2015年 zhujiacong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestJSON : NSObject

+(id)loadData:(NSString *)file;
//网络资源
+(id)loadDataInternet:(NSString *)http;
@end
