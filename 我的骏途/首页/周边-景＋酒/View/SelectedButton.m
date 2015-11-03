//
//  SelectedButton.m
//  周边游
//
//  Created by 俞烨梁 on 15/10/22.
//  Copyright (c) 2015年 俞烨梁. All rights reserved.
//

#import "SelectedButton.h"

@implementation SelectedButton

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title{
    self = [super initWithFrame:frame];
    if (self) {
        //标题label
        _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _label.text = title;
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:13];
        [self addSubview:_label];
        
        //箭头image
        _arrowImageView = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width - 23, frame.size.height/2 - 7.5, 30, 15)];
        _arrowImageView.image = [UIImage imageNamed:@"arrow_down_expanablelistview111"];
        _arrowImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:_arrowImageView];
        
        //分隔线
        _sepaLineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(-8, 0, 20, frame.size.height)];
        _sepaLineImageView.image = [UIImage imageNamed:@"1136_menu_img_shuxian"];
        _sepaLineImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:_sepaLineImageView];
        
        //添加观察者
        [self addObserver:self forKeyPath:@"isSelect" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

//观察者事件
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if (_isSelect == YES) {
        [UIView animateWithDuration:.3 animations:^{
            self.arrowImageView.transform = CGAffineTransformMakeRotation(M_PI);
        }];
    }else{
        [UIView animateWithDuration:.3 animations:^{
            self.arrowImageView.transform = CGAffineTransformIdentity;
        }];
    }
}
//移除观察者
- (void)dealloc{
    [self removeObserver:self forKeyPath:@"isSelect"];
}

@end
