//
//  HttpAFNetworing.m
//  Wawa
//
//  Created by 李世超 on 15/1/1.
//  Copyright (c) 2015年 李世超. All rights reserved.
//

#import "HttpAFNetworing.h"

static HttpAFNetworing *singleton;

@implementation HttpAFNetworing

#pragma mark - 单例
+ (id)shareInstance
{
    if (singleton == nil) {
        singleton = [[[self class] alloc] init];
    }
    return singleton;
}

#pragma mark 检测网路状态
+ (void)netWorkStatus
{
    /**
     AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G 花钱
     AFNetworkReachabilityStatusReachableViaWiFi = 2,   // WiFi
     */
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"%ld", status);
    }];
}

#pragma mark - AF Operation请求
- (AFHTTPRequestOperationManager *)httpMgr
{
    if(!_httpMgr)
    {
        _httpMgr = [AFHTTPRequestOperationManager manager];
        _httpMgr.requestSerializer.timeoutInterval = 10;         //设置超时时间
        //        [_httpMgr.requestSerializer setValue:@"test" forHTTPHeaderField:@"Cookie"];
        _httpMgr.requestSerializer.HTTPShouldHandleCookies = YES;
        _httpMgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/plain",@"text/javascript",@"application/xml",nil];
    }
    return _httpMgr;
}

#pragma mark - AF Operation请求
- (AFHTTPRequestOperationManager *)xmlMgr
{
    if(!_xmlMgr)
    {
        _xmlMgr = [AFHTTPRequestOperationManager manager];
        _xmlMgr.requestSerializer.timeoutInterval = 10;         //设置超时时间
        _xmlMgr.responseSerializer = [AFXMLParserResponseSerializer serializer];
        _xmlMgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/xml",nil];
    }
    return _xmlMgr;
}

@end
