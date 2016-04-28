//
//  InteractCell.m
//  NearDistance
//
//  Created by 李世超 on 15/10/10.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "InteractCell.h"

@implementation InteractCell

#pragma mark - xib互动视图
- (void)awakeFromNib {
    //底部线
    _lineLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    //表格的底色
    _lineLabel.backgroundColor = kUIColorFromRGB(LIGHTGRAY_COLOR);
    [self addSubview:_lineLabel];
    
    UITapGestureRecognizer *topicTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topicImgAction:)];
    [_topicImg addGestureRecognizer:topicTap];
    
    UITapGestureRecognizer *faceTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(faceImgAction:)];
    [_faceImg addGestureRecognizer:faceTap];
}

#pragma mark - layoutSubViews
- (void)layoutSubviews
{
    [self interactAssigment];
    [self _replyRelodData];
}

#pragma mark - 互动cell赋值
- (void)interactAssigment
{
    //头像昵称
    [_faceImg setImageWithURL:[NSURL URLWithString:_interactModel.publisher_header] placeholderImage:[UIImage imageNamed:@"interact_face"]];
    
    if (_interactModel.publisher_nickname.length==0) {
        _nickLabel.text = _interactModel.publisher_mobile;
    }else{
        _nickLabel.text = _interactModel.publisher_nickname;
    }
    
    _remarkLabel.width = ScreenWidth-90;
    NSString *content = _interactModel.content;
    attributedString = [[CommonUtil shareInstance] labelInteractContent:content];
    CGSize remarkSize = [attributedString heightWithLabelWidth:ScreenWidth-90];
    _remarkLabel.height = remarkSize.height;
    _remarkLabel.attributedText = attributedString;
    
    if (_interactModel.imagepath.length==0) {
        _topicImg.hidden = YES;
        _timeBgView.top = _remarkLabel.bottom+5;
    }else{
        _topicImg.hidden = NO;
        _topicImg.top = _remarkLabel.bottom+5;
        [_topicImg setImageWithURL:[NSURL URLWithString:_interactModel.imagepath] placeholderImage:[UIImage imageNamed:DEFAULT_IMG]];
    
        _timeBgView.top = _topicImg.bottom+5;
    }

    NSString *time = _interactModel.createtime;
    CGSize sizeTime =[time sizeWithAttributes:@{NSFontAttributeName:FONG_12}];
    _timeLabel.width = sizeTime.width;
    _timeLabel.text = time;
}

- (void)someIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        _lineLabel.frame = CGRectMake(0, 0, ScreenWidth, 0);
    }else{
        _lineLabel.frame = CGRectMake(0, 0, ScreenWidth, 0.5);
    }
}

#pragma mark - 回复视图赋值
- (void)_replyRelodData
{
    if (_commentArray.count > 0) {
        self.replyTableView.hidden = NO;
        
        CGFloat tableHeight = [[CommonUtil shareInstance] tableViewHeight:_interactModel];
        self.replyTableView.top = _timeBgView.bottom;
        self.replyTableView.height = tableHeight;
        self.replyTableView.userInteractionEnabled = YES;
        self.replyTableView.data = _commentArray;
        [self.replyTableView reloadData];
    }else{
        self.replyTableView.hidden = YES;
    }
}

#pragma mark - actions
- (void)topicImgAction:(UITapGestureRecognizer *)sender {
    [[SJAvatarBrowser shareInstance] showImage:(UIImageView*)sender.view];
}

#pragma mark - 头像push
- (void)faceImgAction:(UITapGestureRecognizer *)sender
{
//    MyViewController *myCtrl = [[MyViewController alloc] init];
//    [self.viewController.navigationController pushViewController:myCtrl animated:YES];
//    [CommonUtil NotiTip:@"开发中..." color:SUCCESS_COLOR];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
