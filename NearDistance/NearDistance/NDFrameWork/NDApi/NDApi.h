//
//  NDApi.h
//  NDHttpClient
//
//  Created by Peter Jin (https://github.com/JNDSir) on  15/1/30.
//  Copyright (c) 2015年 PeterJin.   Email:i@jND.name      All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NDHttpClient.h"


@interface NDApi : NSObject

+ (instancetype)SharedNDApi;

- (void)requestWithURL:(NSString *)url
                 paras:(NSDictionary *)parasDict
                  type:(NDHttpResponseType)type
               success:(void(^)(AFHTTPRequestOperation* operation, NSObject *resultObject))success
               failure:(void(^)(NSError *requestErr))failure ;
- (void)requestWithURL2:(NSString *)url
                referer:(NSString *)refer
                  paras:(NSDictionary *)parasDict
                   type:(NDHttpResponseType)type
                success:(void(^)(AFHTTPRequestOperation* operation, NSObject *resultObject))success
                failure:(void(^)(NSError *requestErr))failure;
@end
