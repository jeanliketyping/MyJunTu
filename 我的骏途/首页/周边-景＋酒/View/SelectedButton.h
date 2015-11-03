//
//  SelectedButton.h
//  周边游
//
//  Created by 俞烨梁 on 15/10/22.
//  Copyright (c) 2015年 俞烨梁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectedButton : UIButton

@property (nonatomic,strong)UILabel *label;
@property (nonatomic,strong)UIImageView *arrowImageView;
@property (nonatomic,assign)BOOL isSelect;
@property (nonatomic,strong)UIImageView *sepaLineImageView;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title;
@end
