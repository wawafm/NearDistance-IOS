//
//  InteractListModel.h
//  NearDistance
//
//  Created by 李世超 on 15/10/23.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommentModel.h"

@interface InteractListModel : OneBaseParser

@property (nonatomic,copy) NSString *interactID;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *imagepath;
@property (nonatomic,copy) NSString *memberid;
@property (nonatomic,copy) NSString *createtime;
@property (nonatomic,copy) NSString *comments;
@property (nonatomic,copy) NSString *publisher_header;
@property (nonatomic,copy) NSString *publisher_mobile;
@property (nonatomic,copy) NSString *publisher_nickname;

@property (nonatomic,strong)NSMutableArray *commentArray;
@property (nonatomic,retain) CommentModel *commentModel;

- (instancetype)InteractListWithDict:(NSDictionary *)dict;

+(void)getInteractList:(int)page success:(void (^)(AFHTTPRequestOperation *, NSObject *))success failure:(void (^)(NSError *))failure;

@end
