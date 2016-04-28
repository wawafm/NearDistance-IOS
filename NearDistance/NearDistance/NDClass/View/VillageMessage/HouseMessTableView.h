//
//  HouseMessTableView.h
//  NearDistance
//
//  Created by 李世超 on 15/10/16.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "NDBaseTableView.h"
#import "HouseMessCell.h"
#import "VillageNewsModel.h"
#import "VillageNewsDetailViewController.h"

@interface HouseMessTableView : NDBaseTableView

@property (nonatomic,retain) VillageNewsModel *newsModel;
@property (nonatomic,retain) HouseMessCell *houseMessCell;
@end
