//
//  TabBarButton.h
//  我的骏途
//
//  Created by mac on 15/10/6.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabBarButton : UIButton
/*
 * 初始化方法
 * title 按钮下部的文字
 * imageName 按钮上部图片名
 */
@property(nonatomic,strong)UIImageView *myImageView;
@property(nonatomic,strong)UILabel *label;

-(id)initWithTitle:(NSString *)title
         imageName:(NSString *)imageName
             frame:(CGRect)frame;

@end
