//
//  SelectedView.h
//  周边游
//
//  Created by 俞烨梁 on 15/10/22.
//  Copyright (c) 2015年 俞烨梁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectedButton.h"
@interface SelectedView : UIView<UITableViewDataSource,UITableViewDelegate>

- (instancetype)initWithFrame:(CGRect)frame
                       titles:(NSArray *)titles
                         data:(NSArray *)data;

@end
