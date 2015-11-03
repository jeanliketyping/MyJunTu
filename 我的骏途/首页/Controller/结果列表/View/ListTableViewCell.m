//
//  ListTableViewCell.m
//  我的骏途
//
//  Created by mac on 15/10/15.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import "ListTableViewCell.h"

@implementation ListTableViewCell

-(void)setModel:(SearchListModel *)model {
    if (_model != model) {
        _model = model;
        
        //图片
        NSString *thumb = _model.thumb;
        _bigImageView.contentMode = UIViewContentModeScaleAspectFill;
        _bigImageView.layer.cornerRadius = 5;
        _bigImageView.layer.masksToBounds = YES;
        [_bigImageView sd_setImageWithURL:[NSURL URLWithString:thumb]];
        //titile
        _titleLabel.text = _model.title;
        //description
        _descriptionLabel.text = _model.myDescription;
        //JunTuPrice
        _junTuPrice.text = [NSString stringWithFormat:@"¥%@",_model.juntu_price];
        //market_price
        if (_model.market_price != nil) {
            _markPrice.hidden = NO;
            NSString *str = [NSString stringWithFormat:@"¥%@",_model.market_price];
            //设置删除线
            NSMutableAttributedString *attrStr =[[NSMutableAttributedString alloc] initWithString:str];
            [attrStr addAttribute:NSStrikethroughStyleAttributeName value:@1 range:[str rangeOfString:str]];
            _markPrice.attributedText = attrStr;
            
        }
        //跟团
        if ([_model.group_type isEqualToString:@"group"]) {
            _typeImageView.hidden = NO;
            _typeImageView.image = [UIImage imageNamed:@"gentuan_xiao12x"];
        }
        //自驾
        if ([_model.is_self_drive isEqualToString:@"Y"]) {
            _typeImageView.hidden = NO;
            _typeImageView.image = [UIImage imageNamed:@"zijiayou_xiao"];
        }
        //直通车
        if ([_model.is_train isEqualToString:@"Y"]) {
            _typeImageView.hidden = NO;
            _typeImageView.image = [UIImage imageNamed:@"zhitoncghe_xiao"];
        }
        //优惠券
        if ([_model.coupon_status isEqualToString:@"Y"]) {
            _discountLabel.hidden = NO;
            _discountLabel.layer.cornerRadius = 2;
            _discountLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"quchuanma"]];
        }
        
    }
}


- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
