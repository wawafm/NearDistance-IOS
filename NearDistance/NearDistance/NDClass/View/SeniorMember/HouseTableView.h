//
//  SeniorTableView.h
//  NearDistance
//
//  Created by 李世超 on 15/10/16.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "NDBaseTableView.h"
#import "HouseCell.h"
#import "VillageModel.h"

@interface HouseTableView : NDBaseTableView

@property (nonatomic,retain) VillageModel *villageModel;
@property (nonatomic,retain) NSString *houseID;
@property (nonatomic,retain) HouseCell *houseCell;
@end
