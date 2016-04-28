//
//  MemberInfoModel.h
//  NearDistance
//
//  Created by 李世超 on 15/10/22.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MemberInfoModel : NSObject<NSCoding>

@property (nonatomic,copy) NSString *mid;
@property (nonatomic,copy) NSString *mobile;
@property (nonatomic,copy) NSString *password;
@property (nonatomic,copy) NSString *nickname;
@property (nonatomic,copy) NSString *headerphoto;
@property (nonatomic,copy) NSString *memberid;
@property (nonatomic,copy) NSString *address;

+(instancetype)memberInfo:(NSDictionary *)dict;
@end
