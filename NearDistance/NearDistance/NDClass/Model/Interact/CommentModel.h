//
//  CommentModel.h
//  NearDistance
//
//  Created by 李世超 on 15/10/23.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : OneBaseParser

@property (nonatomic,copy) NSString *commentID;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *from;
@property (nonatomic,copy) NSString *to;
@property (nonatomic,copy) NSString *articleid;
@property (nonatomic,copy) NSString *restoreid;
@property (nonatomic,copy) NSString *createtime;
@property (nonatomic,copy) NSString *commenter_header;
@property (nonatomic,copy) NSString *commenter_nickname;
@property (nonatomic,copy) NSString *commenter_mobile;

+ (instancetype)CommentListWithDict:(NSDictionary *)dict;

@end
