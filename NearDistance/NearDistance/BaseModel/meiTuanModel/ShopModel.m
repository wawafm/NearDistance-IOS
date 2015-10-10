//
//  ShopModel.m
//  NearDistance
//
//  Created by 李世超 on 15/10/8.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "ShopModel.h"

@implementation ShopModel

+ (instancetype)ShopModelWithDict:(NSDictionary *)dict
{
    ShopModel *shopModel = [[self alloc] init];
    shopModel.shop_name  = dict[@"shop_name"];
    shopModel.shop_poiid = dict[@"shop_poiid"];
    shopModel.shop_tel   = dict[@"shop_tel"];
    shopModel.shop_addr  = dict[@"shop_addr"];
    shopModel.shop_area  = dict[@"shop_area"];
    shopModel.shop_long  = dict[@"shop_long"];
    shopModel.shop_lat   = dict[@"shop_lat"];
    shopModel.shop_city  = dict[@"shop_city"];
    
    return shopModel;
}

@end
