//
//  ReplyCell.m
//  NearDistance
//  
//  Created by 李世超 on 15/10/12.
//  Copyright (c) 2015年 李世超. All rights reserved.
//

#import "ReplyCommentCell.h"

@implementation ReplyCommentCell

- (void)awakeFromNib {
    
}

#pragma mark - layoutSubViews
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_faceImg setImageWithURL:[NSURL URLWithString:_commentModel.commenter_header]];
    
    _commContent = _commentModel.content;
    _commContent = [_commContent stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    
    attributedString = [[CommonUtil shareInstance] labelContent:_commContent];
    CGSize contentHeight = [attributedString heightWithLabelWidth:ScreenWidth-135];
    
    self.replyLabel.width = ScreenWidth-135;
    self.replyLabel.height = contentHeight.height+25;
    self.replyLabel.attributedText = attributedString;
    
    self.bgView.width = ScreenWidth-125;
    self.bgView.height = contentHeight.height+10;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
