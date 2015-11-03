//
//  MyInfoCell.m
//  我的骏途
//
//  Created by 俞烨梁 on 15/10/24.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import "MyInfoCell.h"

@implementation MyInfoCell

- (void)awakeFromNib {
    _nickNameTextView.delegate = self;
    _cellNumberTextView.delegate = self;
    _mailTextView.delegate = self;
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (_nickNameTextView.text != nil) {
        _nickNameBlock(_nickNameTextView.text);

    }
    if (_cellNumberTextView.text != nil) {
        _cellNumberBlock(_cellNumberTextView.text);
    }
    
    if (_mailTextView.text != nil) {
        _mailBlock(_mailTextView.text);
    }


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
