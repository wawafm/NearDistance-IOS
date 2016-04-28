//
//  InteractTableView.m
//  NearDistance
//
//  Created by 李世超 on 15/10/10.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "InteractTableView.h"

@implementation InteractTableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"interactCell";
    _interactCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (_interactCell == nil) {
        _interactCell = [[[NSBundle mainBundle] loadNibNamed:@"InteractCell" owner:self options:nil] lastObject];
        _interactCell.backgroundColor = [UIColor whiteColor];
    }
    
    _interactModel = [self.data objectAtIndex:indexPath.row];
    _interactCell.interactModel = _interactModel;
    _interactCell.commentArray = _interactModel.commentArray;
    _interactCell.replyButton.tag = indexPath.row;
    [_interactCell.replyButton addTarget:self action:@selector(replyAction:) forControlEvents:UIControlEventTouchUpInside];
    [_interactCell someIndexPath:indexPath];
    return _interactCell;
}

#pragma mark - commentTableView delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    _interactModel = [self.data objectAtIndex:indexPath.row];
    NSString *content = _interactModel.content;
    NSAttributedString *attribute = [[CommonUtil shareInstance] labelInteractContent:content];
    CGSize  remarkSize;
    CGFloat remarkHeight = 0.0f;
    
    CGFloat imgHeight = 0.0f;
    
    CGFloat replyTableHeight = 0.0f;
    
    CGFloat height = 0.0f;
    if (content!=nil&&![content isEqualToString:@""]) {
        remarkSize = [attribute heightWithLabelWidth:ScreenWidth-90];
        remarkHeight = remarkSize.height;
    }
    
    if (_interactModel.imagepath.length!=0) {
        imgHeight = 125.0f;
    }
    replyTableHeight = [[CommonUtil shareInstance] tableViewHeight:_interactModel];
    CGFloat tableHeight;
    if (replyTableHeight!=0) {
        height = remarkHeight+imgHeight+replyTableHeight+100.0f;
        tableHeight = MAX(height, 100.0f);
    }else{
        height = remarkHeight+imgHeight+replyTableHeight+90.0f;
        tableHeight = MAX(height, 90.0f);
    }
    
    return tableHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)replyAction:(UIButton *)sender
{
    CGRect heheR = [self convertRect:_interactCell.replyTableView.frame toView:nil];
    NSLog(@"----%d",sender.tag);
//    NSLog(@"hehehehe===%@",NSStringFromCGRect(heheR));
    CGFloat maxY = CGRectGetMaxY(heheR);
//    NSLog(@"maxY:%f",maxY);
    if ([self.interactDelegate respondsToSelector:@selector(replyInteract:content:replyY:)]) {
        [self.interactDelegate replyInteract:(int)sender.tag content:@"评论" replyY:maxY];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    
    if ([_interactDelegate respondsToSelector:@selector(scrollIndex)]) {
        [_interactDelegate scrollIndex];
    }
}

@end
