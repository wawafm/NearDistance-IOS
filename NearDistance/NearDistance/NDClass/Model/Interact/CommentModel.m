//
//  CommentModel.m
//  NearDistance
//
//  Created by 李世超 on 15/10/23.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel

+ (instancetype)CommentListWithDict:(NSDictionary *)dict
{
    CommentModel *commentModel = [[self alloc] init];
    
    commentModel.commentID  = dict[@"id"];
    commentModel.content = dict[@"content"];
    commentModel.from   = dict[@"from"];
    commentModel.to  = dict[@"to"];
    commentModel.articleid  = dict[@"articleid"];
    commentModel.restoreid  = dict[@"restoreid"];
    commentModel.createtime  = dict[@"createtime"];
    commentModel.commenter_header  = dict[@"commenter_header"];
    commentModel.commenter_nickname  = dict[@"commenter_nickname"];
    commentModel.commenter_mobile  = dict[@"commenter_mobile"];
    
    return commentModel;
}

@end
