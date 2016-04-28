//
//  XBHttpClient.h
//  XBHttpClient
//
//  Created by Peter Jin (https://github.com/JxbSir) on  15/1/30.
//  Copyright (c) 2015年 PeterJin.   Email:i@jxb.name      All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef enum
{
    NDHttpResponseType_Json,
    NDHttpResponseType_JqueryJson,
    NDHttpResponseType_XML,
    NDHttpResponseType_Common
}NDHttpResponseType;

@interface NDHttpClient : AFHTTPRequestOperationManager


- (void)requestWithURL:(NSString *)url
                 paras:(NSDictionary *)parasDict
                  type:(NDHttpResponseType)type
               success:(void(^)(AFHTTPRequestOperation* operation, NSObject *resultObject))success
               failure:(void(^)(NSError *requestErr))failure ;

@end
