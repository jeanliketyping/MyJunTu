//
//  HolidayTableViewCell.m
//  我的骏途
//
//  Created by mac on 15/10/23.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import "HolidayTableViewCell.h"

@implementation HolidayTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setModel:(SearchListModel *)model {
    if (_model != model) {
        _model = model;
        
        //图片
        [_thumbImageView sd_setImageWithURL:[NSURL URLWithString:_model.thumb]];
        _thumbImageView.layer.cornerRadius = 5;
        _thumbImageView.layer.masksToBounds = YES;
        //名称
        _titleLabel.text = _model.title;
        //位置
        _positionLabel.text = _model.position;
        //骏途价格
        _juntu_priceLabel.text = [NSString stringWithFormat:@"¥%@",_model.juntu_price];
        //市场价格
        if (_model.market_price != nil) {
            _market_priceLabel.hidden = NO;
            NSString *str = [NSString stringWithFormat:@"¥%@",_model.market_price];
            //设置删除线
            NSMutableAttributedString *attrStr =[[NSMutableAttributedString alloc] initWithString:str];
            [attrStr addAttribute:NSStrikethroughStyleAttributeName value:@1 range:[str rangeOfString:str]];
            _market_priceLabel.attributedText = attrStr;
        }
        //距离
        
    }
}

@end
