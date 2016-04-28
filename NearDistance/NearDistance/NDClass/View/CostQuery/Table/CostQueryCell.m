//
//  CostQueryCell.m
//  NearDistance
//
//  Created by 李世超 on 15/10/16.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "CostQueryCell.h"

@implementation CostQueryCell

- (void)awakeFromNib {
    // Initialization code
    _lineLabel.height = 0.5;
}
//dictionaryWithObjectsAndKeys:@"owner",@"张**",@"houseNum",@"印象麦地-A栋-302",@"date",@"2015.1",@"waterRate",@"35.3",@"electricBill",@"420.72",@"gasCharge",@"62.2",@"propertyCharges",@"92",@"parkingRate",@"260",@"generCharge",@"0.00",@"lateFee",@"0", nil];

- (void)layoutSubviews
{
    [super layoutSubviews];
    _ownerLabel.text = _costModel.owner;
    _houseLabel.text = _costModel.houseNum;
    _dateLabel.text = _costModel.date;
    _waterLabel.text = _costModel.waterRate;
    _electricLabel.text = _costModel.electricBill;
    _gasLabel.text = _costModel.gasCharge;
    _propertyLabel.text = _costModel.propertyCharges;
    _parkingLabel.text = _costModel.parkingRate;
    _generLabel.text = _costModel.generCharge;
    _lateFreeLabel.text = _costModel.lateFee;
    _totalLabel.text = _costModel.totalRate;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
