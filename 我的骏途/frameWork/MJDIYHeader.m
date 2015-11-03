//
//  MJDIYHeader.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/6/13.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "MJDIYHeader.h"

@interface MJDIYHeader()
@property (weak, nonatomic) UILabel *label;
@property (weak, nonatomic) UIImageView *s;
@property (weak, nonatomic) UIImageView *logo;
@property (weak, nonatomic) UIActivityIndicatorView *loading;
@end

@implementation MJDIYHeader
#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 50;
    
    // 添加label
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor colorWithRed:54/255.0 green:183/255.0 blue:200/255.f alpha:1];
    label.font = [UIFont boldSystemFontOfSize:13];
    label.textAlignment = NSTextAlignmentLeft;
    [self addSubview:label];
    self.label = label;
    
    // 背景图片
    UIImageView *s = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ma"]];
    [self addSubview:s];
    self.s = s;
    
    // 动画图片
    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"juntu_1_3(2)"]];
    [self addSubview:logo];
    self.logo = logo;
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    
    self.label.frame = CGRectMake(140, 15, 100, 20);
    
    self.s.frame = CGRectMake(70, 0, 50, 50);
    self.logo.frame = CGRectMake(70,0, 35, 35);
    self.logo.center = self.s.center;
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            [self.loading stopAnimating];
            
            [self.logo.layer removeAnimationForKey:@"rotateAnimation"];
            self.label.text = @"下拉刷新首页";
            break;
        case MJRefreshStatePulling:
            [self.loading stopAnimating];
            
            self.label.text = @"放开o(╯□╰)o...";
            break;
        case MJRefreshStateRefreshing:
            
            self.label.text = @"加载中...";
            [self rotateAnimation];
            [self.loading startAnimating];
            break;
        default:
            break;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    
    //透明度设置
    self.label.alpha = pullingPercent*0.5;
    self.logo.alpha = pullingPercent;
    self.s.alpha = pullingPercent;
    
    
}

- (void)rotateAnimation {
    
    //1.创建动画对象
    CABasicAnimation *basic = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    //2.设置动画相关属性
    //动画时间
    basic.duration = 1.0f;
    
    //动画结束值
    basic.toValue = @(2 * M_PI);
    
    basic.repeatCount = HUGE_VALF;
    
    self.logo.layer.anchorPoint = CGPointMake(0.5, 0.5);
    
    //3.把动画对象添加到层上
    [self.logo.layer addAnimation:basic forKey:@"rotateAnimation"];
    
    
}

@end
