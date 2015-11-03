//
//  MyNetWorkQuery.h
//
//  Created by kangkathy on 15/8/28.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyNetWorkQuery : NSObject

//使用NSURLConnection组件来做网络申请
+ (void)requestData:(NSString *)urlString HTTPMethod:(NSString *)method  params:(NSMutableDictionary *)params completionHandle:(void(^)(id result))completionblock errorHandle:(void(^)(NSError *error))errorblock;


//封装使用AFNetWorking来申请网络的方法（不上传文件）
+ (void)AFRequestData:(NSString *)urlString HTTPMethod:(NSString *)method params:(NSMutableDictionary *)params completionHandle:(void(^)(id result))completionblock errorHandle:(void(^)(NSError *error))errorblock;


//封装上传文件的方法:data是和文件上传相关的参数
+ (void)AFRequestData:(NSString *)urlString HTTPMethod:(NSString *)method params:(NSMutableDictionary *)params data:(NSMutableDictionary *)datas completionHandle:(void(^)(id result))completionblock errorHandle:(void(^)(NSError *error))errorblock;




@end
