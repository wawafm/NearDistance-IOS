//
//  HttpAFNetworing.h
//  Wawa
//
//  Created by 李世超 on 15/1/1.
//  Copyright (c) 2015年 李世超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpAFNetworing : NSObject

+ (id)shareInstance;

//检测网路状态
+ (void)netWorkStatus;

//json
- (AFHTTPRequestOperationManager *)httpMgr;
@property (nonatomic,retain) AFHTTPRequestOperationManager *httpMgr;

//xml
- (AFHTTPRequestOperationManager *)xmlMgr;
@property (nonatomic,retain) AFHTTPRequestOperationManager *xmlMgr;
@end
