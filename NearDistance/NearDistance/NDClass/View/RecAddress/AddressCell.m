//
//  AddressCell.m
//  NearDistance
//
//  Created by 李世超 on 15/10/20.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "AddressCell.h"

@implementation AddressCell

- (void)awakeFromNib {
    _lineLabel.height = 0.5;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _nameLabel.text = _addressModel.userName;
    _phoneLabel.text = _addressModel.userPhone;
    _cityLabel.text = _addressModel.city;
    _addressLabel.text = _addressModel.address;
    _zipCodeLabel.text = _addressModel.zipCode;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
