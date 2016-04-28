//
//  OfferCell.m
//  NearDistance
//
//  Created by 李世超 on 15/10/10.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "OfferCell.h"

@implementation OfferCell

- (void)awakeFromNib {
    _detailLabel.verticalAlignment = VerticalAlignmentTop;
    _priceLabel.verticalAlignment = VerticalAlignmentTop;
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSString *price = [NSString stringWithFormat:@"￥%@",_dealModel.price];
    NSString *oldPrice = [NSString stringWithFormat:@"￥%@",_dealModel.value];
    NSString *salesNum = [NSString stringWithFormat:@"已售%@",_dealModel.sales_num];
    //根据内容获取Label宽度
    CGSize priceSize =[price sizeWithAttributes:@{NSFontAttributeName:FONG_15}];
    _priceLabel.width = priceSize.width;
    
    CGSize oldSize =[oldPrice sizeWithAttributes:@{NSFontAttributeName:FONG_12}];
    _oldPriceLabel.width = oldSize.width;
    _oldPriceLabel.left = _priceLabel.right+5;
    
    _oldLineLabel.width = oldSize.width-5;
    _oldLineLabel.left = _priceLabel.right+8;
    
    CGSize saleNumSize =[salesNum sizeWithAttributes:@{NSFontAttributeName:FONG_12}];
    _salesNumLabel.width = saleNumSize.width;
    
    [_offerImg setImageWithURL:[NSURL URLWithString:_dealModel.deal_img] placeholderImage:[UIImage imageNamed:@""]];
    
    _titleLabel.text = _shopModel.shop_name;
    
    attributedString = [[CommonUtil shareInstance] labelContent:_dealModel.deal_desc];
    _detailLabel.attributedText = attributedString;
    
    _priceLabel.text = price;
    
    _oldPriceLabel.text = oldPrice;
    
    _salesNumLabel.text = salesNum;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
