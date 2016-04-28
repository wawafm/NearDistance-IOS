//
//  AddressModel.h
//  NearDistance
//
//  Created by 李世超 on 15/10/20.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressModel : OneBaseParser

@property (nonatomic,copy) NSString *addressID;
@property (nonatomic,copy) NSString *userName;
@property (nonatomic,copy) NSString *userPhone;
@property (nonatomic,copy) NSString *city;
@property (nonatomic,copy) NSString *address;
@property (nonatomic,copy) NSString *zipCode;
@property (nonatomic,copy) NSString *memberid;

+(void)getAddress:(NSString *)mid success:(void (^)(AFHTTPRequestOperation *, NSObject *))success failure:(void (^)(NSError *))failure;

@end
