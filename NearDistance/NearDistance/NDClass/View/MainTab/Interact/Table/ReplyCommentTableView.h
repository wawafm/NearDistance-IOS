//
//  ReplyTableView.h
//  NearDistance
//
//  Created by 李世超 on 15/10/12.
//  Copyright (c) 2015年 李世超. All rights reserved.
//

#import "NDBaseTableView.h"
#import "ReplyCommentCell.h"
#import "CommentModel.h"

@interface ReplyCommentTableView : NDBaseTableView
{
    NSAttributedString *attributedString;
}
@property (nonatomic,retain)ReplyCommentCell *replyCell;
@property (nonatomic,retain)CommentModel *commentModel;
@property (nonatomic,retain)UIImageView *commentImg;

@property (nonatomic, retain) NSString         *createUser;
@property (nonatomic, retain) NSString         *replyUser;
@property (nonatomic, retain) NSString         *commContent;
@property (nonatomic, retain) NSString         *totalContent;
@end
