//
//  HolidayDetailCell.m
//  我的骏途
//
//  Created by mac on 15/10/24.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import "HolidayDetailCell.h"

@implementation HolidayDetailCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(RoomListModel *)model {
    if (_model != model) {
        _model = model;
        
        //图片
        [_thumbImageView sd_setImageWithURL:[NSURL URLWithString:_model.thumb] placeholderImage:[UIImage imageNamed:@"120-120.png"]];
        _thumbImageView.layer.cornerRadius = 5;
        _thumbImageView.layer.masksToBounds = YES;
        //room_name
        _room_nameLabel.text = _model.room_name;
        //bed_type_breadfast
        _bed_type_breadfast.text = [NSString stringWithFormat:@"%@ %@",_model.bed_type,_model.breakfast];
        //juntu_price
        NSString *junPrice = _model.juntu_price;
        _juntu_price.text = [NSString stringWithFormat:@"¥%.f",[junPrice floatValue]];
        //market_price
        if (_model.market_price != nil) {
            NSString *str = [NSString stringWithFormat:@"¥%@",_model.market_price];
            //设置删除线
            NSMutableAttributedString *attrStr =[[NSMutableAttributedString alloc] initWithString:str];
            [attrStr addAttribute:NSStrikethroughStyleAttributeName value:@1 range:[str rangeOfString:str]];
            _market_price.attributedText = attrStr;
            
        }
        //open_buyLabel
        if ([_model.open_buy isEqualToString:@"Y"]) {
            _open_buyLabel.hidden = NO;
        }else{
            _open_buyLabel.hidden = YES;
        }
    }
}


@end
