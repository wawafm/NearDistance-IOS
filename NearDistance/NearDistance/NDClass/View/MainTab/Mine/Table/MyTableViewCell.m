//
//  MyTableViewCell.m
//  NearDistance
//
//  Created by 李世超 on 15/10/14.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "MyTableViewCell.h"

@implementation MyTableViewCell

- (void)awakeFromNib {
    
    _lineLabel.height = 0.5;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.myLabel.text = _myText;
}

- (void)someIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==2) {
        self.bindLabel.hidden = NO;
    }else{
        self.bindLabel.hidden = YES;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
