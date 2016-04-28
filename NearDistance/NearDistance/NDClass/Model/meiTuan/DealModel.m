//
//  DealModel.m
//  NearDistance
//
//  Created by 李世超 on 15/10/8.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "DealModel.h"

@implementation DealModel

+(void)getDealModel:(int)limit success:(void (^)(AFHTTPRequestOperation *, NSObject *))success failure:(void (^)(NSError *))failure
{
    app.httpUrl = [NSString stringWithFormat:AF_TODAY_URL,limit];
    app.httpUrl = [app.httpUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[NDApi SharedNDApi] requestWithURL:app.httpUrl paras:nil type:NDHttpResponseType_XML success:success failure:failure];
}
@end
