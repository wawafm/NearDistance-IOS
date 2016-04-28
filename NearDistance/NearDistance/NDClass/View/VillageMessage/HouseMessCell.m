//
//  HouseMessCell.m
//  NearDistance
//
//  Created by 李世超 on 15/10/16.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "HouseMessCell.h"

@implementation HouseMessCell

- (void)awakeFromNib {
    // Initialization code
    _lineLabel.height = 0.5;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _titleLabel.text = _newsModel.title;
    _timeLabel.text = _newsModel.createtime;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
