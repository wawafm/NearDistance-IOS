//
//  VillageNewsModel.m
//  NearDistance
//
//  Created by 李世超 on 15/10/28.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "VillageNewsModel.h"

@implementation VillageNewsModel

+(void)getVillageNewsList:(int)page success:(void (^)(AFHTTPRequestOperation *, NSObject *))success failure:(void (^)(NSError *))failure
{
    NSString* url = [NSString stringWithFormat:AF_HOUSEMESS_URL,AF_WEBURL,page, AF_PAGE_NUMBER];
    
    [[NDApi SharedNDApi] requestWithURL:url paras:nil type:NDHttpResponseType_Json success:success failure:failure];
}
@end
