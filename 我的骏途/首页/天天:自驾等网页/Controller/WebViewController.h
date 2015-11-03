//
//  WebViewController.h
//  我的骏途
//
//  Created by mac on 15/10/23.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import "BaseViewController.h"

@interface WebViewController : BaseViewController<UIWebViewDelegate>

@property(nonatomic,copy)NSString *urlString;
@property(nonatomic,copy)NSString *showTitle;
@property(nonatomic,copy)NSString *showContent;
@end
