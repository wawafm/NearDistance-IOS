//
//  AddressModel.m
//  NearDistance
//
//  Created by 李世超 on 15/10/20.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "AddressModel.h"

@implementation AddressModel

+(void)getAddress:(NSString *)mid success:(void (^)(AFHTTPRequestOperation *, NSObject *))success failure:(void (^)(NSError *))failure
{
    NSString* url = [NSString stringWithFormat:AF_GETADDRESS_URL,AF_WEBURL,mid];
    
    [[NDApi SharedNDApi] requestWithURL:url paras:nil type:NDHttpResponseType_Json success:success failure:failure];
}
@end
