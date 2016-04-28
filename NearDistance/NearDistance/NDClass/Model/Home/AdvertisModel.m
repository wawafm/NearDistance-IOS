//
//  AdvertisModel.m
//  NearDistance
//
//  Created by 李世超 on 15/10/28.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "AdvertisModel.h"

@implementation AdvertisModel

+(void)getAdvertisModel:(int)code success:(void (^)(AFHTTPRequestOperation *, NSObject *))success failure:(void (^)(NSError *))failure
{
    app.httpUrl = [NSString stringWithFormat:AF_AD_URL,AF_WEBURL];
    [[NDApi SharedNDApi] requestWithURL:app.httpUrl paras:nil type:NDHttpResponseType_Json success:success failure:failure];
}

@end
