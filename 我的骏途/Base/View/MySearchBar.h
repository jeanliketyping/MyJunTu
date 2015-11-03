//
//  MySearchBar.h
//  我的骏途
//
//  Created by mac on 15/10/13.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SearchBlock)(NSString *,NSArray *);
@interface MySearchBar : UISearchBar<UISearchBarDelegate>

@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *urlString;
@property(nonatomic,copy)SearchBlock block;
-(instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder;

@end
