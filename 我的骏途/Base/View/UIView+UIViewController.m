//
//  UIView+UIViewController.m
//  WeiBobo
//
//  Created by mac on 15/10/16.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import "UIView+UIViewController.h"

@implementation UIView (UIViewController)

-(UIViewController *)viewController{
    
    UIResponder *next = self.nextResponder;
    while (next != nil) {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = next.nextResponder;
    }
    return nil;
}

@end
