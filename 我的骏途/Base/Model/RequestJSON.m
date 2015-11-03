//
//  MovieJSON.m
//  TimeMovie
//
//  Created by mac10 on 15/8/22.
//  Copyright (c) 2015年 zhujiacong. All rights reserved.
//

#import "RequestJSON.h"

@implementation RequestJSON
+(id)loadData:(NSString *)file{
    // 1. 获取文件路径
        NSString *filePath = [[NSBundle mainBundle] pathForResource:file ofType:@"json"];
    // 2. 读取文件
    // NSData 数据类 里面的数据是以二进制的形式储存 字符串，字典，数组，UIImage
        NSData *data = [NSData dataWithContentsOfFile:filePath];
    id json =[NSJSONSerialization JSONObjectWithData:data
                                                       options:NSJSONReadingMutableLeaves
                                                         error:nil];

    return json;
}
+(id)loadDataInternet:(NSString *)http{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:http]];
    
    //将请求的url数据放到NSData对象中
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    id json =[NSJSONSerialization JSONObjectWithData:data
                                                          options:NSJSONReadingMutableLeaves
                                                            error:nil];

    return json;
}
@end
