//
//  ReplyCell.h
//  NearDistance

//  评论视图
//  Created by 李世超 on 15/10/12.
//  Copyright (c) 2015年 李世超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"

@interface ReplyCommentCell : UITableViewCell
{
    NSAttributedString *attributedString;
}
@property (weak, nonatomic) IBOutlet UIImageView *faceImg;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *replyLabel;
@property (nonatomic,retain) CommentModel *commentModel;

@property (nonatomic, retain) NSString         *createUser;
@property (nonatomic, retain) NSString         *replyUser;
@property (nonatomic, retain) NSString         *commContent;
@property (nonatomic, retain) NSString         *totalContent;

@end
