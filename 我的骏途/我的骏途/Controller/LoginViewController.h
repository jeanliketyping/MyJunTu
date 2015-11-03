//
//  LoginViewController.h
//  我的骏途
//
//  Created by mac on 15/10/26.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import "BaseViewController.h"
@class UserModel;
typedef void(^ModelBlock)(UserModel *);
@interface LoginViewController :BaseViewController<UITextFieldDelegate>

@property(nonatomic,copy)ModelBlock block;
@end
