//
//  MyHeaderView.m
//  NearDistance
//
//  Created by 李世超 on 15/10/14.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "MyHeaderView.h"

@implementation MyHeaderView

- (void)awakeFromNib
{
    _borderLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    
    UITapGestureRecognizer *topicTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(faceImgAction:)];
    [_faceImg addGestureRecognizer:topicTap];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSData *hunterData = MEMBER;
    _memberInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:hunterData];
    if ([_memberInfoModel.headerphoto isEqualToString:@""]) {
        _faceImg.image = [UIImage imageNamed:MY_FACE_IMG];
    }else{
        _faceImgUrl = _memberInfoModel.headerphoto;
        [_faceImg setImageWithURL:[NSURL URLWithString:_faceImgUrl] placeholderImage:[UIImage imageNamed:MY_FACE_IMG]];
    }
    if ([_memberInfoModel.nickname isEqualToString:@""]) {
        _userLabel.text = _memberInfoModel.mobile;
    }else{
        _userLabel.text = _memberInfoModel.nickname;
    }
}

#pragma mark - 昵称改变
- (void)nickAssigment
{
    NSData *hunterData = MEMBER;
    _memberInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:hunterData];
    _userLabel.text = _memberInfoModel.nickname;
}

#pragma mark - 头像放大
- (void)faceImgAction:(UITapGestureRecognizer *)sender {
    [[SJAvatarBrowser shareInstance] showImage:(UIImageView*)sender.view];
}
@end
