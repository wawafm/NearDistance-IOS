//
//  VillageNewsModel.h
//  NearDistance
//
//  Created by 李世超 on 15/10/28.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VillageNewsModel : OneBaseParser

@property (nonatomic,copy) NSString *vid;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *createtime;

+(void)getVillageNewsList:(int)page success:(void (^)(AFHTTPRequestOperation *, NSObject *))success failure:(void (^)(NSError *))failure;
@end
