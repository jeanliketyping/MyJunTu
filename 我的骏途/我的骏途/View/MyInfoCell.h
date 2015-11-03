//
//  MyInfoCell.h
//  我的骏途
//
//  Created by 俞烨梁 on 15/10/24.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^nickNameBlock)(NSString *);
typedef void(^cellNumberBlock)(NSString *);
typedef void(^mailBlock)(NSString *);

@interface MyInfoCell : UITableViewCell<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *nickNameTextView;
@property (weak, nonatomic) IBOutlet UITextView *cellNumberTextView;
@property (weak, nonatomic) IBOutlet UITextView *mailTextView;
@property (nonatomic, copy) nickNameBlock nickNameBlock;
@property (nonatomic, copy) cellNumberBlock cellNumberBlock;
@property (nonatomic, copy) mailBlock mailBlock;

@end
