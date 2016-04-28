//
//  RoomModel.m
//  NearDistance
//
//  Created by 李世超 on 15/10/27.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "RoomModel.h"

@implementation RoomModel

+ (instancetype)RoomModelWithDict:(NSDictionary *)dict
{
    RoomModel *roomModel = [[self alloc] init];
    roomModel.roomID  = dict[@"id"];
    roomModel.name = dict[@"name"];
    roomModel.parentID   = dict[@"parentid"];
    return roomModel;
}

@end
