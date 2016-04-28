//
//  DealModel.h
//  NearDistance
//
//  Created by 李世超 on 15/10/8.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DealModel : OneBaseParser

@property (nonatomic,copy) NSString *website;
@property (nonatomic,copy) NSString *deal_more_img;
@property (nonatomic,copy) NSString *reservation;//是否需要预约
@property (nonatomic,copy) NSString *partner;
@property (nonatomic,copy) NSString *city_name;
@property (nonatomic,copy) NSString *city_id;
@property (nonatomic,copy) NSString *city_url;
@property (nonatomic,copy) NSString *deal_id;//项目编号
@property (nonatomic,copy) NSString *deal_title;//项目标题
@property (nonatomic,copy) NSString *deal_rank;
@property (nonatomic,copy) NSString *deal_url;//项目主站地址
@property (nonatomic,copy) NSString *deal_wap_url;//项目i版地址（H5页面）
@property (nonatomic,copy) NSString *deal_img;//项目主图地址（图像尺寸可调）
@property (nonatomic,copy) NSString *deal_cate_id;//品类id
@property (nonatomic,copy) NSString *deal_cate;//品类名称
@property (nonatomic,copy) NSString *deal_subcate_id;//细分品类id
@property (nonatomic,copy) NSString *deal_subcate;//细分品类名称
@property (nonatomic,copy) NSString *deal_desc;//项目描述
@property (nonatomic,copy) NSString *deal_score;
@property (nonatomic,copy) NSString *value;//原价
@property (nonatomic,copy) NSString *price;//美团价
@property (nonatomic,copy) NSString *rebate;//折扣
@property (nonatomic,copy) NSString *refund;//是否支持退款（现在全部为可退，数值为1)
@property (nonatomic,copy) NSString *sales_min;//最小销量
@property (nonatomic,copy) NSString *sales_num;//销量
@property (nonatomic,copy) NSString *sold_out;//是否已卖光（包含yes和no两种结果）
@property (nonatomic,copy) NSString *is_post;//是否为物流单
@property (nonatomic,copy) NSString *start_time;//项目开始时间
@property (nonatomic,copy) NSString *end_time;
@property (nonatomic,copy) NSString *coupon_start_time;
@property (nonatomic,copy) NSString *coupon_end_time;
@property (nonatomic,copy) NSString *deal_tips;//购买须知
@property (nonatomic,copy) NSString *deal_wow;
@property (nonatomic,copy) NSString *deal_range;//商圈名称
@property (nonatomic,copy) NSString *deal_range_id;//商圈id
@property (nonatomic,copy) NSString *deal_district_id;//区域id
@property (nonatomic,copy) NSString *deal_district_name;//区域名称（多poi单每个区域间逗号隔开，下同）
@property (nonatomic,copy) NSString *deal_address;//商家地址
@property (nonatomic,copy) NSString *deal_lng;
@property (nonatomic,copy) NSString *deal_lat;
@property (nonatomic,copy) NSString *deal_name;//项目名称
@property (nonatomic,copy) NSString *deal_prom;
@property (nonatomic,copy) NSString *dist;
@property (nonatomic,copy) NSString *deal_seller;//商家品牌
@property (nonatomic,copy) NSString *deal_phones;//商家电话
@property (nonatomic,copy) NSString *deal_roomtype;
@property (nonatomic,copy) NSString *coupon;

//+ (instancetype)DealModelWithDict:(NSDictionary *)dict;

+(void)getDealModel:(int)limit success:(void (^)(AFHTTPRequestOperation *, NSObject *))success failure:(void (^)(NSError *))failure;

@end
