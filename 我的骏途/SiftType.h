//
//  SiftType.h
//  我的骏途
//
//  Created by mac on 15/10/24.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SiftType : NSObject

@property(nonatomic,copy)NSString *type;

-(NSArray *)getData:(NSString *)type;
-(NSArray *)gettitle:(NSString *)type;
@end
