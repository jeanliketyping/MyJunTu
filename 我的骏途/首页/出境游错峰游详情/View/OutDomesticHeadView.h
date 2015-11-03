//
//  OutDomesticHeadView.h
//  我的骏途
//
//  Created by mac on 15/10/19.
//  Copyright (c) 2015年 wendan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OutDomesticModel.h"

@interface OutDomesticHeadView : UIView
@property (strong, nonatomic) IBOutlet UIImageView *headBigImageView;
@property (strong, nonatomic) IBOutlet UILabel *production_noLabel;
@property (strong, nonatomic) IBOutlet UILabel *spend_timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *imagesCount;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *setup_cityLabel;
@property (strong, nonatomic) IBOutlet UILabel *juntu_priceLabel;

@property(nonatomic,strong)OutDomesticModel *model;
@end
