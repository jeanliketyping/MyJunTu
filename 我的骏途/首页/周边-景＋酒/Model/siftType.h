//
//  siftType.h
//  骏途旅游
//
//  Created by mac10 on 15/10/20.
//  Copyright (c) 2015年 xs27_Group3. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface siftType : NSObject

@property(nonatomic,copy)NSString *type;

-(NSArray *)getData:(NSString *)type;
-(NSArray *)gettitle:(NSString *)type;
@end
