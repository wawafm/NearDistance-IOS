//
//  ShopModel.h
//  NearDistance
//
//  Created by 李世超 on 15/10/8.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopModel : NSObject

@property (nonatomic,copy) NSString *shop_name;//门店名称
@property (nonatomic,copy) NSString *shop_poiid;//门店的美团poiid
@property (nonatomic,copy) NSString *shop_tel;//门店电话
@property (nonatomic,copy) NSString *shop_addr;
@property (nonatomic,copy) NSString *shop_area;//门店所在城区
@property (nonatomic,copy) NSString *shop_long;
@property (nonatomic,copy) NSString *shop_lat;
@property (nonatomic,copy) NSString *shop_city;//门店所在城市

+ (instancetype)ShopModelWithDict:(NSDictionary *)dict;
@end
