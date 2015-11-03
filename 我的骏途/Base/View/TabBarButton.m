//
//  TabBarButton.m
//  我的骏途
//
//  Created by mac on 15/10/6.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import "TabBarButton.h"



@implementation TabBarButton

-(id)initWithTitle:(NSString *)title imageName:(NSString *)imageName frame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        //创建图片和label
        _myImageView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width-20)/2, 8, 20, 22)];
        _myImageView.image = [UIImage imageNamed:imageName];
        [self addSubview:_myImageView];
        
        //设置图片拉伸模式
        _myImageView.contentMode = UIViewContentModeScaleAspectFit;
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 32, frame.size.width, 15)];
        _label.text = title;
        _label.font = [UIFont systemFontOfSize:10];
        _label.textColor = [UIColor grayColor];
        _label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_label];
    }
    return self;
}

@end
