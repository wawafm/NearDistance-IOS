//
//  InteractListModel.m
//  NearDistance
//
//  Created by 李世超 on 15/10/23.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "InteractListModel.h"

@implementation InteractListModel

- (instancetype)InteractListWithDict:(NSDictionary *)dict
{
    if (self == [super init]) {
        
        self.interactID  = dict[@"id"];
        self.content = dict[@"content"];
        self.imagepath   = dict[@"imagepath"];
        self.memberid  = dict[@"memberid"];
        self.createtime  = dict[@"createtime"];
        
        self.publisher_mobile  = dict[@"publisher_mobile"];
        self.publisher_header  = dict[@"publisher_header"];
        self.publisher_nickname  = dict[@"publisher_nickname"];
        
        NSArray *commentArry = [dict objectForKey:@"comments"];
        _commentArray = [NSMutableArray array];
        for (NSDictionary *dict in commentArry) {
            _commentModel = [CommentModel CommentListWithDict:dict];
            [_commentArray addObject:_commentModel];
        }
    }
    return self;
}

+(void)getInteractList:(int)page success:(void (^)(AFHTTPRequestOperation *, NSObject *))success failure:(void (^)(NSError *))failure
{
    app.httpUrl = [NSString stringWithFormat:AF_ALLGETTOPIC_URL,AF_WEBURL,page];
    [[NDApi SharedNDApi] requestWithURL:app.httpUrl paras:nil type:NDHttpResponseType_Json success:success failure:failure];
}

@end
