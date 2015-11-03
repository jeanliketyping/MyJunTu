//
//  MyInfoViewController.h
//  我的骏途
//
//  Created by 俞烨梁 on 15/10/23.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import "BaseViewController.h"

@interface MyInfoViewController : BaseViewController

- (IBAction)saveInfoButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
