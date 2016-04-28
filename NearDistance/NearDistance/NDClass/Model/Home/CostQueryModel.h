//
//  CostQueryModel.h
//  NearDistance
//
//  Created by 李世超 on 15/10/30.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CostQueryModel : OneBaseParser

@property (nonatomic,copy) NSString *owner;
@property (nonatomic,copy) NSString *houseNum;
@property (nonatomic,copy) NSString *date;
@property (nonatomic,copy) NSString *waterRate;
@property (nonatomic,copy) NSString *electricBill;
@property (nonatomic,copy) NSString *gasCharge;
@property (nonatomic,copy) NSString *propertyCharges;
@property (nonatomic,copy) NSString *parkingRate;
@property (nonatomic,copy) NSString *generCharge;
@property (nonatomic,copy) NSString *lateFee;
@property (nonatomic,copy) NSString *totalRate;

@end
