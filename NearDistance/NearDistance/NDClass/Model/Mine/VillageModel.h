//
//  VillageModel.h
//  NearDistance
//
//  Created by 李世超 on 15/10/27.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RoomModel.h"

@interface VillageModel : NSObject

@property (nonatomic,retain) RoomModel *roomModel;
@property (nonatomic,retain) NSMutableArray *roomArray;
@property (nonatomic,copy) NSString *villageID;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *parentID;
- (instancetype)VillageModelWithDict:(NSDictionary *)dict;
@end
