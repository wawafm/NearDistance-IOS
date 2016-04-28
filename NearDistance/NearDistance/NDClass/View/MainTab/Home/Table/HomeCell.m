//
//  HomeCell.m
//  NearDistance
//
//  Created by 李世超 on 15/10/10.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "HomeCell.h"

@implementation HomeCell

- (void)awakeFromNib {
    // Initialization code
}

#pragma mark - layout
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_homeOfferImg setImageWithURL:[NSURL URLWithString:_dealModel.deal_img] placeholderImage:[UIImage imageNamed:@""]];
    
    _titleLabel.text = _shopModel.shop_name;
    
    attributedString = [[CommonUtil shareInstance] labelContent:_dealModel.deal_desc];
    _detailLabel.attributedText = attributedString;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
