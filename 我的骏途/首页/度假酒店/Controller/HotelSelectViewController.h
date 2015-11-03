//
//  HotelSelectViewController.h
//  我的骏途
//
//  Created by mac on 15/10/23.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import "BaseViewController.h"
typedef NSDictionary* (^CityBlock) (NSDictionary*);
@interface HotelSelectViewController : BaseViewController

@property (nonatomic,copy)CityBlock block;

@end
