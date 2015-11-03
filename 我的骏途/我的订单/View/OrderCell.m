//
//  OrderCell.m
//  我的骏途
//
//  Created by mac on 15/10/26.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import "OrderCell.h"

@implementation OrderCell


- (void)setModel:(OrderModel *)model{
    if (_model != model ) {
        _model = model;
        //订单名称
        if ([_model.order_type isEqualToString:@"hotel"]) {
            _orderNameLabel.text = _model.hotel_name;
        }
        else if ([_model.order_type isEqualToString:@"dest"]){
            _orderNameLabel.text = _model.order_name;
        }
        else if ([_model.order_type isEqualToString:@"tours"]){
            _orderNameLabel.text = _model.product_name;
        }
        
        //订单编号
        _orderCodeLabel.text = _model.order_id;
        
        //购买日期
        _buyDataLabel.text = [self convertTime:_model.create_time];

        //价格
        _priceLabel.text = [NSString stringWithFormat:@"¥%@",_model.total];
        
        //订单状态
        if ([_model.order_status isEqualToNumber:@2] || [_model.order_status isEqualToNumber:@4]) {
            _orderStateImageView.image = [UIImage imageNamed:@"qufukuan.png"];
        }else if ([_model.order_status isEqualToNumber:@3]){
            _orderStateImageView.image = [UIImage imageNamed:@"yiquxiao.png"];
        }
        
        _orderStateLabel.text = _model.order_status_name;
        
        //订单类型决定的出游或者入住label
        if ([_model.order_type isEqualToString:@"hotel"]) {
            _orderTypeLabel.text = @"入住日期";
            //入住日期
            _useDataLabel.text = [self convertTime:_model.travel_date];
        }else if ([_model.order_type isEqualToString:@"dest"]){
            _orderTypeLabel.text = @"有 效 期";
            //有效期
            _useDataLabel.text = [NSString stringWithFormat:@"%@至%@",[self convertTime:_model.travel_start_date],[self convertTime:_model.to_date]];
        }else if ([_model.order_type isEqualToString:@"route"]){
            _orderTypeLabel.text = @"出游日期";
            //出游日期
            _useDataLabel.text = [self convertTime:_model.travel_date];
        }
        
        
    }

}

//转换时间戳
- (NSString *)convertTime:(NSString *)timeString{
    //时间戳转换成字符串
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]];
    //格式化日期
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *formatterDate = [formatter stringFromDate:date];
    return formatterDate;
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
