//
//  ReplyTableView.M
//  NearDistance
//
//  Created by 李世超 on 15/10/12.
//  Copyright (c) 2015年 李世超. All rights reserved.
//

#import "ReplyCommentTableView.h"

@implementation ReplyCommentTableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"replyCell";
    _replyCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (_replyCell == nil) {
        _replyCell = [[[NSBundle mainBundle] loadNibNamed:@"ReplyCommentCell" owner:self options:nil] lastObject];
        _replyCell.backgroundColor = [UIColor whiteColor];
        _replyCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    _commentModel = self.data[indexPath.row];
    _replyCell.commentModel = _commentModel;
    return _replyCell;
}



#pragma mark - commentTableView delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    _commentModel = [self.data objectAtIndex:indexPath.row];
    _commContent = _commentModel.content;
    _commContent = [_commContent stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    attributedString = [[CommonUtil shareInstance] labelContent:_commContent];
    CGSize replyHeight = [attributedString heightWithLabelWidth:ScreenWidth-135];
    CGFloat tableHeight = MAX(replyHeight.height+25, 0.0f);
    
    return tableHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    CGRect cellRect = [tableView rectForRowAtIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
