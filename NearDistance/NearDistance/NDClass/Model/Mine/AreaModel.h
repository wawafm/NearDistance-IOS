//
//  AreaModel.h
//  NearDistance
//
//  Created by 李世超 on 15/10/26.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VillageModel.h"

@interface AreaModel : NSObject

@property (nonatomic,retain) NSMutableArray *villageArray;
@property (nonatomic,retain) VillageModel *villageModel;
@property (nonatomic,copy) NSString *areaID;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *parentID;
- (instancetype)AreaModelWithDict:(NSDictionary *)dict;
@end
