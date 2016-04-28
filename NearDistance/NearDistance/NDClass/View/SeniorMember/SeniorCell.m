//
//  SeniorCell.m
//  NearDistance
//
//  Created by 李世超 on 15/10/16.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "SeniorCell.h"

@implementation SeniorCell

- (void)awakeFromNib {
    _lineLabel.height = 0.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.propertyLabel.text = _areaModel.name;
}

@end
