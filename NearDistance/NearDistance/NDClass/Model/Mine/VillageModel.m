//
//  VillageModel.m
//  NearDistance
//
//  Created by 李世超 on 15/10/27.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "VillageModel.h"

@implementation VillageModel

- (instancetype)VillageModelWithDict:(NSDictionary *)dict
{
    if (self == [super init]) {
        self.villageID  = dict[@"id"];
        self.name  = dict[@"name"];
        self.parentID = dict[@"parentid"];
        
        NSArray *roomArry = [dict objectForKey:@"rooms"];
        _roomArray = [NSMutableArray array];
        for (NSDictionary *dict in roomArry) {
            _roomModel = [RoomModel RoomModelWithDict:dict];
            [_roomArray addObject:_roomModel];
        }
    }
    
    return self;
}

@end
