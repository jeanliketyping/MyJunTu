//
//  OutDomesticViewController.h
//  我的骏途
//
//  Created by mac on 15/10/18.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import "BaseViewController.h"

@interface OutDomesticViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate>

@property(nonatomic,copy)NSString *idStr;

@end
