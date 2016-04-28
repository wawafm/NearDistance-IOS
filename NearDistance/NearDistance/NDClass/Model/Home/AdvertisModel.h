//
//  AdvertisModel.h
//  NearDistance
//
//  Created by 李世超 on 15/10/28.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdvertisModel : OneBaseParser

@property (nonatomic,copy) NSString *aid;
@property (nonatomic,copy) NSString *imagepath;
@property (nonatomic,copy) NSString *url;

+(void)getAdvertisModel:(int)code success:(void (^)(AFHTTPRequestOperation *, NSObject *))success failure:(void (^)(NSError *))failure;
@end
