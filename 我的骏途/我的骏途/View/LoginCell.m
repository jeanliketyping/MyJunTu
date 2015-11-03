//
//  LoginCell.m
//  骏途旅游
//
//  Created by mac on 15/10/11.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "LoginCell.h"

@implementation LoginCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self _createSubView];
        
    }
    
    return self;
}


- (void)_createSubView{
    

    _label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 80, 50)];
    _label.textColor = [UIColor grayColor];
    [self addSubview:_label];
    
    _textF = [[UITextField alloc] initWithFrame:CGRectMake(80, 0, kScreenWidth - 50, 50)];
    [self addSubview:_textF];

}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
