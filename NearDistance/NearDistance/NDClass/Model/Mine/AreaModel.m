//
//  AreaModel.m
//  NearDistance
//
//  Created by 李世超 on 15/10/26.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "AreaModel.h"

@implementation AreaModel

- (instancetype)AreaModelWithDict:(NSDictionary *)dict
{
    if (self == [super init]) {
        self.areaID  = dict[@"id"];
        self.name  = dict[@"name"];
        self.parentID = dict[@"parentid"];
        
        NSArray *villageArry = [dict objectForKey:@"buildinglist"];
        _villageArray = [NSMutableArray array];
        for (NSDictionary *dict in villageArry) {
            _villageModel = [[VillageModel alloc] VillageModelWithDict:dict];
            [_villageArray addObject:_villageModel];
        }
    }
    
    return self;
}

@end
