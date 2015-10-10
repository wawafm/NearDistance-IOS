//
//  DealModel.m
//  NearDistance
//
//  Created by 李世超 on 15/10/8.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "DealModel.h"

@implementation DealModel

+ (id)DealModelWithDict:(NSDictionary *)dict
{
    DealModel *dealModel         = [[self alloc] init];
    dealModel.website            = dict[@"website"];
    dealModel.deal_more_img      = dict[@"deal_more_img"];
    dealModel.reservation        = [NSString stringWithFormat:@"%@",dict[@"reservation"]];
    dealModel.partner            = [NSString stringWithFormat:@"%@",dict[@"partner"]];
    dealModel.city_name          = dict[@"city_name"];
    dealModel.city_id            = dict[@"city_id"];
    dealModel.city_url           = dict[@"city_url"];
    dealModel.deal_id            = dict[@"deal_id"];
    dealModel.deal_title         = dict[@"deal_title"];
    dealModel.deal_rank          = dict[@"deal_rank"];
    dealModel.deal_url           = dict[@"deal_url"];
    dealModel.deal_rank          = dict[@"deal_rank"];
    dealModel.deal_wap_url       = dict[@"deal_wap_url"];
    dealModel.deal_img           = dict[@"deal_img"];
    dealModel.deal_cate_id       = dict[@"deal_cate_id"];
    dealModel.deal_cate          = dict[@"deal_cate"];
    dealModel.deal_subcate_id    = dict[@"deal_subcate_id"];
    dealModel.deal_subcate       = dict[@"deal_subcate"];
    dealModel.deal_desc          = dict[@"deal_desc"];
    dealModel.deal_score         = dict[@"deal_score"];
    dealModel.value              = dict[@"value"];
    dealModel.price              = dict[@"price"];
    dealModel.rebate             = dict[@"rebate"];
    dealModel.refund             = dict[@"refund"];
    dealModel.sales_min          = dict[@"sales_min"];
    dealModel.sales_num          = dict[@"sales_num"];
    dealModel.sold_out           = dict[@"sold_out"];
    dealModel.is_post            = dict[@"is_post"];
    dealModel.start_time         = dict[@"start_time"];
    dealModel.end_time           = dict[@"end_time"];
    dealModel.coupon_start_time  = dict[@"coupon_start_time"];
    dealModel.coupon_end_time    = dict[@"coupon_end_time"];

    dealModel.deal_tips          = dict[@"deal_tips"];
    dealModel.deal_wow           = dict[@"deal_wow"];
    dealModel.deal_range         = dict[@"deal_range"];
    dealModel.deal_range_id      = dict[@"deal_range_id"];
    dealModel.deal_district_id   = dict[@"deal_district_id"];
    dealModel.deal_district_name = dict[@"deal_district_name"];
    dealModel.deal_address       = dict[@"deal_address"];
    dealModel.deal_lng           = dict[@"deal_lng"];
    dealModel.deal_lat           = dict[@"deal_lat"];
    dealModel.deal_name          = dict[@"deal_name"];
    dealModel.deal_prom          = dict[@"deal_prom"];
    dealModel.dist               = dict[@"dist"];
    dealModel.deal_seller        = dict[@"deal_seller"];
    dealModel.deal_phones        = dict[@"deal_phones"];
    dealModel.deal_roomtype      = dict[@"deal_roomtype"];
    dealModel.coupon             = dict[@"coupon"];

    return dealModel;
}

@end
